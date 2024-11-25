from flask import request, jsonify
from app import app, db
from auth.service.payment_service import PaymentService

@app.route('/payment', methods=['GET'])
def get_all_payments():
    try:
        payments = PaymentService.get_all_payments()
        result = [
            {
                "payment_id": payment.payment_id,
                "package_id": payment.package_id,
                "amount": payment.amount,
                "payment_date": payment.payment_date,
                "payment_status": payment.payment_status
            } for payment in payments
        ]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/payment/<int:payment_id>', methods=['GET'])
def get_payment_by_id(payment_id):
    try:
        payment = PaymentService.get_payment_by_id(payment_id)
        result = {
            "payment_id": payment.payment_id,
            "package_id": payment.package_id,
            "amount": payment.amount,
            "payment_date": payment.payment_date,
            "payment_status": payment.payment_status
        }
        return jsonify(result), 200
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/payment', methods=['POST'])
def add_payment():
    try:
        data = request.get_json()
        
        # Перевіряємо, чи існує package_id
        package_exists = PaymentService.check_package_exists(data['package_id'])
        if not package_exists:
            return jsonify({
                "error": f"Package with ID {data['package_id']} does not exist in packages table."
            }), 400

        # Створення платежу
        new_payment = PaymentService.add_payment(
            data['package_id'],
            data['amount'],
            data['payment_date'],
            data['payment_status']
        )

        # Повертаємо всю інформацію про новий платіж
        return jsonify({
            "message": "Payment added successfully",
            "payment": {
                "payment_id": new_payment.payment_id,
                "package_id": new_payment.package_id,
                "amount": new_payment.amount,
                "payment_date": str(new_payment.payment_date),
                "payment_status": new_payment.payment_status
            }
        }), 201

    except ValueError as ve:
        return jsonify({"error": str(ve)}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/payment/<int:payment_id>', methods=['PUT'])
def update_payment(payment_id):
    try:
        data = request.get_json()

        # Перевірка наявності всіх необхідних полів
        if not all(key in data for key in ['package_id', 'amount', 'payment_date', 'payment_status']):
            return jsonify({"error": "Missing required fields"}), 400

        # Оновлення платежу через сервіс
        updated_payment = PaymentService.update_payment(
            payment_id=payment_id,
            package_id=data['package_id'],
            amount=data['amount'],
            payment_date=data['payment_date'],
            payment_status=data['payment_status']
        )

        # Форматування відповіді
        return jsonify({
            "message": "Payment updated successfully",
            "updated_payment": {
                "payment_id": updated_payment.payment_id,
                "package_id": updated_payment.package_id,
                "amount": updated_payment.amount,
                "payment_date": updated_payment.payment_date,
                "payment_status": updated_payment.payment_status
            }
        }), 200

    except ValueError as ve:
        return jsonify({"error": str(ve)}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/payment/<int:payment_id>', methods=['DELETE'])
def delete_payment(payment_id):
    try:
        PaymentService.delete_payment(payment_id)
        return jsonify({"message": "Payment deleted successfully"}), 200
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500
