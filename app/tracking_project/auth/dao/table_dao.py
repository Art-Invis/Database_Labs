from app.config.database import get_db

def call_insert_into_table_procedure(table_name, column_list, values_list):
    """
    Викликає збережену процедуру InsertIntoTable для вставки даних.
    :param table_name: Назва таблиці.
    :param column_list: Список колонок (рядком через кому).
    :param values_list: Список значень (рядком через кому).
    """
    query = f"CALL InsertIntoTable('{table_name}', '{column_list}', '{values_list}')"
    db = get_db()
    cursor = db.cursor()
    cursor.execute(query)
    db.commit()
    cursor.close()
