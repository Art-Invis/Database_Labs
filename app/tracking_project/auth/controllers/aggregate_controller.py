from flask import Blueprint, request, jsonify
from auth.service.aggregate_service import AggregateService
from app import app

aggregate_blueprint = Blueprint('aggregate', __name__)

@aggregate_blueprint.route('/aggregate', methods=['GET'])
def get_aggregate():
    try:
        table_name = request.args.get('table_name')
        column_name = request.args.get('column_name')
        operation = request.args.get('operation')
        
        if not table_name or not column_name or not operation:
            return jsonify({"error": "Missing parameters"}), 400
        
        valid_operations = ['MAX', 'MIN', 'SUM', 'AVG']
        
        if operation not in valid_operations:
            return jsonify({"error": f"Invalid operation. Valid operations are {', '.join(valid_operations)}."}), 400
        
        # Викликаємо сервіс для виконання агрегації
        result = AggregateService.calculate_aggregate(table_name, column_name, operation)
        
        if result is None:
            return jsonify({"error": f"No data found in column '{column_name}' of table '{table_name}'."}), 404
        
        # Формуємо відповідь залежно від операції
        response = {}
        if operation == 'SUM':
            response['sum'] = result
        elif operation == 'AVG':
            response['average'] = result
        elif operation == 'MAX':
            response['maximum'] = result
        elif operation == 'MIN':
            response['minimum'] = result
        
        return jsonify(response), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

app.register_blueprint(aggregate_blueprint)
