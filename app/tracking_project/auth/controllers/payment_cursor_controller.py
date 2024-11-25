from flask import Blueprint, jsonify, request
from auth.service.payment_cursor_service import PaymentCursorService
from app import app
payment_cursor_blueprint = Blueprint('payment_cursor', __name__)

@payment_cursor_blueprint.route('/payments/cursor', methods=['POST'])
def create_databases_and_tables_for_payments():
    try:
        # Викликаємо сервіс для виконання процедури
        PaymentCursorService.create_databases_and_tables()
        return jsonify({"message": "Databases and tables created successfully based on payment statuses."}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
app.register_blueprint(payment_cursor_blueprint, url_prefix='/api')