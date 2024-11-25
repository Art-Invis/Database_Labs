from auth.domain.models import db
from sqlalchemy.sql import text

class PaymentCursorService:
    @staticmethod
    def create_databases_and_tables():
        try:
            # Виконання збереженої процедури з явним текстовим SQL-запитом
            sql = text("CALL CreateDatabasesAndTablesForPayments()")
            db.session.execute(sql)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise Exception(f"Error executing cursor procedure: {str(e)}")
