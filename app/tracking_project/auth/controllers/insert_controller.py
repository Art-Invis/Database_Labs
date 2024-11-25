from flask import Blueprint, jsonify, request
from auth.service.insert_service import InsertService  # Імпортуємо сервіс
from app import app
insert_blueprint = Blueprint('insert', __name__)

# Процедура для параметризованої вставки
@insert_blueprint.route('/insert', methods=['POST'])
def insert_into_table():
    data = request.get_json()
    try:
        table_name = data.get('table_name')
        column_list = data.get('column_list')
        values_list = data.get('values_list')

        if not table_name or not column_list or not values_list:
            return jsonify({"error": "Missing parameters"}), 400

        # Викликаємо сервіс для виконання вставки
        InsertService.insert_into_table(table_name, column_list, values_list)

        return jsonify({"message": "Data inserted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Процедура для вставки зв’язку M:M
@insert_blueprint.route('/insert_link', methods=['POST'])
def insert_link():
    data = request.get_json()
    try:
        table_name = data.get('table_name')
        column1_name = data.get('column1_name')
        column2_name = data.get('column2_name')
        value1 = data.get('value1')
        value2 = data.get('value2')

        if not table_name or not column1_name or not column2_name or not value1 or not value2:
            return jsonify({"error": "Missing parameters"}), 400

        # Викликаємо сервіс для виконання зв'язку
        InsertService.insert_into_link(table_name, column1_name, column2_name, value1, value2)

        return jsonify({"message": "Link inserted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Процедура для тестової вставки 10 рядків
@insert_blueprint.route('/insert_test_rows', methods=['POST'])
def insert_test_rows():
    data = request.get_json()
    try:
        table_name = data.get('table_name')
        column_list = data.get('column_list')

        if not table_name or not column_list:
            return jsonify({"error": "Missing parameters"}), 400

        # Викликаємо сервіс для тестової вставки
        InsertService.insert_test_rows(table_name, column_list)

        return jsonify({"message": "Test data inserted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@insert_blueprint.route('/link_by_values', methods=['POST'])
def insert_link_by_values():
    data = request.get_json()
    try:
        table_name = data.get('table_name')
        column1_value = data.get('column1_value')  # Значення для першого стовпця
        column2_value = data.get('column2_value')  # Значення для другого стовпця

        if not table_name or not column1_value or not column2_value:
            return jsonify({"error": "Missing parameters"}), 400

        # Викликаємо сервіс для пошуку ID за значеннями та вставки у таблицю-зв'язок
        InsertService.insert_link_by_values(table_name, column1_value, column2_value)

        return jsonify({"message": "Link inserted by values successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@insert_blueprint.route('/insert_courier_branch', methods=['POST'])
def insert_courier_branch():
    data = request.get_json()
    try:
        courier_name = data.get('courier_name')
        branch_address = data.get('branch_address')

        if not courier_name or not branch_address:
            return jsonify({"error": "Missing courier_name or branch_address"}), 400

        # Call the service to execute the procedure
        result = InsertService.insert_courier_branch(courier_name, branch_address)

        if "error" in result:
            return jsonify(result), 400  # Return error message
        else:
            return jsonify(result), 200  # Return success message
    except Exception as e:
        return jsonify({"error": str(e)}), 500


app.register_blueprint(insert_blueprint, url_prefix='/insert')