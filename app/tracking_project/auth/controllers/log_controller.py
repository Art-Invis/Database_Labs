from flask import Blueprint, jsonify, request
from auth.domain.models import db
from sqlalchemy.sql import text
from app import app
logs_blueprint = Blueprint('logs', __name__)

@logs_blueprint.route('/logs/packages', methods=['GET'])
def get_package_logs():
    try:
        package_id = request.args.get('package_id')
        action_type = request.args.get('action_type')
        
        query = "SELECT * FROM package_logs WHERE 1=1"
        
        if package_id:
            query += " AND package_id = :package_id"
        if action_type:
            query += " AND action_type = :action_type"
        
        logs = db.session.execute(text(query), {'package_id': package_id, 'action_type': action_type}).fetchall()
        
        return jsonify([{
            "log_id": log.log_id,
            "package_id": log.package_id,
            "action_type": log.action_type,
            "change_time": log.change_time.strftime('%Y-%m-%d %H:%M:%S')
        } for log in logs]), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
app.register_blueprint(logs_blueprint)