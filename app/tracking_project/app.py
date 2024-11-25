from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import yaml
from auth.domain.models import db  


def load_config():
    with open("config/app.yml", 'r') as ymlfile:
        return yaml.safe_load(ymlfile)

config = load_config()

app = Flask(__name__)


app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{config['DB_USER']}:{config['DB_PASSWORD']}@{config['DB_HOST']}/{config['DB_NAME']}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


db.init_app(app)

@app.route('/')
def index():
    return "Підключення до бази даних успішне!"



from auth.controllers.operating_hours_controller import *  

from auth.controllers.receivers_controller import *
from auth.controllers.postmats_controller import *
from auth.controllers.delivery_address_controller import *
from auth.controllers.branches_senders_controller import *  
from auth.controllers.couriers_controller import *
from auth.controllers.payment_controller import *
from auth.controllers.aggregate_controller import *
from auth.controllers.insert_controller import *
from auth.controllers.payment_cursor_controller import *
from auth.controllers.log_controller import *
from auth.controllers.packages_controllers import *

if __name__ == '__main__':
    with app.app_context():
        db.create_all()  
    app.run(debug=True)