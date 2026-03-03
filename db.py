import re

import psycopg2
import streamlit as st


def get_connection():
    """Create a new PostgreSQL connection from Streamlit secrets."""
    db_config = st.secrets["connections"]["postgresql"]
    return psycopg2.connect(
        host=db_config["host"],
        port=db_config["port"],
        dbname=db_config["database"],
        user=db_config["username"],
        password=db_config["password"],
    )


_DML_PATTERN = re.compile(
    r"\b(INSERT|UPDATE|DELETE|DROP|ALTER|TRUNCATE|CREATE|GRANT|REVOKE)\b",
    re.IGNORECASE,
)


def execute_sql_query(sql_query: str) -> str:
    """Execute a read-only SQL SELECT query and return results as a text table.

    This is the function exposed to the LLM via tool use.
    Two layers of DML protection:
      1. Regex check blocks dangerous statements before execution.
      2. PostgreSQL session is set to read-only mode.
    """
    # --- Guard layer 1: regex ---
    if _DML_PATTERN.search(sql_query):
        return "Error: Only SELECT queries are allowed. Data modification is not permitted."

    try:
        conn = get_connection()
        try:
            # --- Guard layer 2: read-only session ---
            conn.set_session(readonly=True)
            cur = conn.cursor()
            cur.execute(sql_query)
            columns = [desc[0] for desc in cur.description]
            rows = cur.fetchall()
            cur.close()
        finally:
            conn.close()
    except Exception as e:
        return f"SQL Error: {e}"

    if not rows:
        return "Query returned no results."

    # Format as a text table
    col_widths = [len(c) for c in columns]
    for row in rows:
        for i, val in enumerate(row):
            col_widths[i] = max(col_widths[i], len(str(val)))

    header = " | ".join(c.ljust(col_widths[i]) for i, c in enumerate(columns))
    separator = "-+-".join("-" * w for w in col_widths)
    lines = [header, separator]
    for row in rows:
        line = " | ".join(str(val).ljust(col_widths[i]) for i, val in enumerate(row))
        lines.append(line)

    return "\n".join(lines)


def get_schema_description() -> str:
    """Query information_schema and return a human-readable schema description."""
    columns_sql = """
        SELECT table_name, column_name, data_type, is_nullable,
               column_default
        FROM information_schema.columns
        WHERE table_schema = 'public'
        ORDER BY table_name, ordinal_position;
    """
    fk_sql = """
        SELECT
            tc.table_name,
            kcu.column_name,
            ccu.table_name  AS foreign_table,
            ccu.column_name AS foreign_column
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
            ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage ccu
            ON tc.constraint_name = ccu.constraint_name
        WHERE tc.constraint_type = 'FOREIGN KEY'
          AND tc.table_schema = 'public';
    """
    try:
        conn = get_connection()
        try:
            cur = conn.cursor()
            cur.execute(columns_sql)
            col_rows = cur.fetchall()
            cur.execute(fk_sql)
            fk_rows = cur.fetchall()
            cur.close()
        finally:
            conn.close()
    except Exception as e:
        return f"Error reading schema: {e}"

    # Build FK lookup: (table, column) -> "references foreign_table(foreign_column)"
    fk_map = {}
    for table, column, ftable, fcolumn in fk_rows:
        fk_map[(table, column)] = f"REFERENCES {ftable}({fcolumn})"

    schema_lines = []
    current_table = None
    for table, column, dtype, nullable, default in col_rows:
        if table != current_table:
            if current_table is not None:
                schema_lines.append("")
            schema_lines.append(f"Table: {table}")
            schema_lines.append("-" * (len(table) + 7))
            current_table = table
        parts = [f"  {column} ({dtype})"]
        if nullable == "NO":
            parts.append("NOT NULL")
        if default:
            parts.append(f"DEFAULT {default}")
        fk = fk_map.get((table, column))
        if fk:
            parts.append(fk)
        schema_lines.append(" — ".join(parts))

    return "\n".join(schema_lines)
