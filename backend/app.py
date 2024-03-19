from face_encodings import get_face_encodings
from write_attendance import mark_attendance
from flask import Flask, request, jsonify


app = Flask(__name__)

image_names, known_face_encoding = get_face_encodings()

@app.route('/')
def home():
    return "Welcome to Face Attendance System"

@app.route('/encodings',methods=['GET','POST'])
def get_encodings():
    if request.method == 'POST':
        image_names, known_face_encoding = get_face_encodings()
        return jsonify({'image_names':image_names,'known_face_encoding':known_face_encoding}),201
    if request.method == 'GET':
         return jsonify({'image_names':image_names,'known_face_encoding':known_face_encoding}),200

@app.route('/attendance')
def get_attendance():
    if request.method == 'GET':
        attendees = mark_attendance(image_names, known_face_encoding)
        if(len(attendees)==0):
            return jsonify({'No data found'}),404
        else: 
            return jsonify({'attendees': attendees }),200
if __name__ == '__main__':
    app.run(debug=True)