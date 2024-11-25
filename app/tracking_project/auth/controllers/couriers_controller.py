from flask import Blueprint, request, jsonify
from app import app
from auth.service.couriers_service import CouriersService

couriers_blueprint = Blueprint('couriers', __name__)


@couriers_blueprint.route('/couriers', methods=['POST'])
def create_courier():
    try:
        data = request.get_json()
        new_courier = CouriersService.create_courier(data['name'], data['phone'], data['vehicle_type'])
        return jsonify({"message": "Courier created successfully", "courier_id": new_courier.courier_id}), 201
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@couriers_blueprint.route('/couriers', methods=['GET'])
def get_couriers():
    try:
        couriers = CouriersService.get_all_couriers()
        result = [{"courier_id": courier.courier_id, "name": courier.name, "phone": courier.phone, "vehicle_type": courier.vehicle_type} for courier in couriers]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@couriers_blueprint.route('/couriers/<int:courier_id>', methods=['GET'])
def get_courier_by_id(courier_id):
    try:
        courier = CouriersService.get_courier_by_id(courier_id)
        return jsonify({"courier_id": courier.courier_id, "name": courier.name, "phone": courier.phone, "vehicle_type": courier.vehicle_type}), 200
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@couriers_blueprint.route('/couriers/<int:courier_id>', methods=['PUT'])
def update_courier(courier_id):
    try:
        data = request.get_json()
        updated_courier = CouriersService.update_courier(courier_id, data['name'], data['phone'], data['vehicle_type'])
        if updated_courier:
            return jsonify({"message": "Courier updated successfully"}), 200
        return jsonify({"error": "Courier not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@couriers_blueprint.route('/couriers/<int:courier_id>', methods=['DELETE'])
def delete_courier(courier_id):
    try:
        success = CouriersService.delete_courier(courier_id)
        if success:
            return jsonify({"message": f"Courier with ID {courier_id} was deleted successfully"}), 200
        return jsonify({"error": f"Courier with ID {courier_id} does not exist or Minimum cardinality of 6 rows must be maintained"}), 404
    except Exception as e:
        error_message = str(e)
        if "Minimum cardinality of 6 rows must be maintained" in error_message:
            # Специфічне повідомлення для тригера
            return jsonify({"error": "Cannot delete courier: The table must have at least 6 couriers."}), 400
        return jsonify({"error": f"An unexpected error occurred: {error_message}"}), 500


app.register_blueprint(couriers_blueprint)