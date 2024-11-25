from auth.domain.models import db
from sqlalchemy import text

class InsertService:
    @staticmethod
    def insert_into_table(table_name, column_list, values_list):
        query = f"INSERT INTO {table_name} ({column_list}) VALUES ({values_list})"
        try:
            db.session.execute(text(query))
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e

    @staticmethod
    def insert_into_link(table_name, column1_name, column2_name, value1, value2):
        query = f"INSERT INTO {table_name} ({column1_name}, {column2_name}) VALUES ({value1}, {value2})"
        try:
            db.session.execute(text(query))
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e

    @staticmethod
    def insert_test_rows(table_name, column_list):
        query = f"INSERT INTO {table_name} ({column_list}) VALUES "
        for i in range(1, 11):
            query += f"('Noname{i}', '+3800000000{i}', 'noname{i}@example.com')"
            if i < 10:
                query += ", "
        try:
            db.session.execute(text(query))
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e
        
    @staticmethod
    def insert_link_by_values(link_table, column1_value, column2_value):
        """
        Вставка зв’язку у таблицю M:N на основі реальних значень з інших таблиць.
        """
        try:
            # Пошук ID для першого значення
            query1 = f"SELECT id FROM first_table WHERE name = :value1"
            result1 = db.session.execute(text(query1), {"value1": column1_value}).fetchone()
            if not result1:
                raise ValueError(f"Value '{column1_value}' not found in first_table.")
            id1 = result1[0]

            # Пошук ID для другого значення
            query2 = f"SELECT id FROM second_table WHERE name = :value2"
            result2 = db.session.execute(text(query2), {"value2": column2_value}).fetchone()
            if not result2:
                raise ValueError(f"Value '{column2_value}' not found in second_table.")
            id2 = result2[0]

            # Вставка у таблицю зв’язків
            insert_query = f"INSERT INTO {link_table} (first_id, second_id) VALUES (:id1, :id2)"
            db.session.execute(text(insert_query), {"id1": id1, "id2": id2})
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e
        
    @staticmethod
    def insert_courier_branch(courier_name, branch_address):
        """
        Calls the InsertCourierBranch stored procedure and returns the IDs.
        """
        try:
            # Call the stored procedure
            sql = text("CALL InsertCourierBranch(:courier_name, :branch_address)")
            result = db.session.execute(sql, {"courier_name": courier_name, "branch_address": branch_address}).fetchone()
            db.session.commit()

            # Extract the IDs from the result
            return {
                "message": f"Relation successfully inserted between courier '{courier_name}' and branch '{branch_address}'.",
                "courier_id": result.courier_id,
                "branch_id": result.branch_id
            }
        except Exception as e:
            db.session.rollback()
            error_message = str(e)
            # Extract meaningful error message from SQLSTATE
            if "45000" in error_message:
                detailed_message = error_message.split("45000: ")[-1]
                return {"error": detailed_message.strip()}
            else:
                raise e