# run service on windows
waitress-serve --listen=*:8080 aiservice:app

aiservice - name of python file with flask app
app - variable of flask service: "app = Flask(__name__)"

#test service
python test.py
requires: pip install requests