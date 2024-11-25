from flask import Blueprint
from auth.controllers.payment_controller import (
    create_payment_logic,
    get_payments_logic,
    get_payment_by_id_logic,
    update_payment_logic,
    delete_payment_logic,
)

payments_blueprint = Blueprint('payments', __name__)

@payments_blueprint.route('/payments', methods=['POST'])
def create_payment():
    return create_payment_logic()

@payments_blueprint.route('/payments', methods=['GET'])
def get_payments():
    return get_payments_logic()

@payments_blueprint.route('/payments/<int:payment_id>', methods=['GET'])
def get_payment_by_id(payment_id):
    return get_payment_by_id_logic(payment_id)

@payments_blueprint.route('/payments/<int:payment_id>', methods=['PUT'])
def update_payment(payment_id):
    return update_payment_logic(payment_id)

@payments_blueprint.route('/payments/<int:payment_id>', methods=['DELETE'])
def delete_payment(payment_id):
    return delete_payment_logic(payment_id)
