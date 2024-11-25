from auth.domain.models import db

class Payment(db.Model):
    __tablename__ = 'payment'

    payment_id = db.Column(db.Integer, primary_key=True)
    package_id = db.Column(db.Integer, nullable=False)
    amount = db.Column(db.Numeric(10, 2), nullable=False)
    payment_date = db.Column(db.Date, nullable=False)
    payment_status = db.Column(db.Enum('Pending', 'Paid', 'Failed'), nullable=False)

    def __repr__(self):
        return f'<Payment {self.payment_id}>'
