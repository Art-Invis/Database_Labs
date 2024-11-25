from auth.dao.payment_dao import PaymentDAO
from sqlalchemy.sql import text
from auth.domain.models import db


class PaymentService:
    @staticmethod
    def check_package_exists(package_id: int) -> bool:
        """Перевіряє існування пакету з вказаним package_id."""
        query = "SELECT COUNT(*) FROM packages WHERE package_id = :package_id"
        result = db.session.execute(text(query), {"package_id": package_id}).scalar()
        return result > 0

    @staticmethod
    def add_payment(package_id: int, amount: float, payment_date: str, payment_status: str):
        """Додає платіж з перевіркою існування пакету."""
        # Перевірка, чи існує пакет
        if not PaymentService.check_package_exists(package_id):
            raise ValueError(f"Package with ID {package_id} does not exist in packages table.")
        
        # Додавання платежу через DAO
        return PaymentDAO.create(package_id, amount, payment_date, payment_status)

    @staticmethod
    def get_all_payments() -> list:
        """Отримує всі платежі."""
        return PaymentDAO.get_all()

    @staticmethod
    def get_payment_by_id(payment_id: int):
        """Отримує платіж за ID."""
        payment = PaymentDAO.get_by_id(payment_id)
        if not payment:
            raise ValueError("Payment not found.")
        return payment

    @staticmethod
    def update_payment(payment_id: int, package_id: int, amount: float, payment_date: str, payment_status: str):
        """Оновлює дані платежу з перевіркою існування package_id."""
        # Перевірка, чи існує пакет
        if not PaymentService.check_package_exists(package_id):
            raise ValueError(f"Package with ID {package_id} does not exist in packages table.")
        
        # Перевірка, чи існує платіж
        payment = PaymentDAO.get_by_id(payment_id)
        if not payment:
            raise ValueError(f"Payment with ID {payment_id} not found.")
        
        # Виклик оновлення через DAO
        return PaymentDAO.update(payment_id, package_id, amount, payment_date, payment_status)

    @staticmethod
    def delete_payment(payment_id: int) -> bool:
        """Видаляє платіж."""
        return PaymentDAO.delete(payment_id)
