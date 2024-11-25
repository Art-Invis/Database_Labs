from auth.domain.models import db
from auth.domain.payment import Payment

class PaymentDAO:
    @staticmethod
    def create(package_id: int, amount: float, payment_date: str, payment_status: str) -> Payment:
        new_payment = Payment(
            package_id=package_id,
            amount=amount,
            payment_date=payment_date,
            payment_status=payment_status
        )
        db.session.add(new_payment)
        db.session.commit()
        return new_payment

    @staticmethod
    def get_all() -> list:
        return Payment.query.all()

    @staticmethod
    def get_by_id(payment_id: int) -> Payment:
        return Payment.query.get(payment_id)

    @staticmethod
    def update(payment_id: int, package_id: int, amount: float, payment_date: str, payment_status: str) -> Payment:
        payment = PaymentDAO.get_by_id(payment_id)
        if not payment:
            return None
        payment.package_id = package_id
        payment.amount = amount
        payment.payment_date = payment_date
        payment.payment_status = payment_status
        db.session.commit()
        return payment

    @staticmethod
    def delete(payment_id: int) -> bool:
        payment = PaymentDAO.get_by_id(payment_id)
        if not payment:
            return False
        db.session.delete(payment)
        db.session.commit()
        return True
