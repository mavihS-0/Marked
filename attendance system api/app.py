from write_attendance import mark_attendance
from flask import Flask, request, jsonify,send_file
import firebase_admin
import csv
import os
import json
import numpy as np
from firebase_admin import credentials
from firebase_admin import firestore
cred = credentials.Certificate("marked-b1ac1-firebase-adminsdk-am0i3-5580de3b5b.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

app = Flask(__name__)

def load_face_encodings(input_file):
    with open(input_file, 'r') as json_file:
        data = json.load(json_file)

    face_encodings = np.array(data['face_encodings'])

    return data['filenames'], face_encodings

image_names, known_face_encoding = load_face_encodings('face_encodings.json')

image_names = [name.split('.')[0] for name in image_names]

@app.route('/',methods = ['GET'])
def home():
    if request.method == 'GET':
        return jsonify('Welcome to the face recognition API'),200

@app.route('/encodings',methods=['GET'])
def get_encodings():
    if request.method == 'GET':
         with open('face_encodings.json', 'r') as json_file:
            data = json.load(json_file)
         return data,200

@app.route('/attendance')
def get_attendance():
    if request.method == 'GET':
        attendees = []
        if request.args.get('docId'):
            docId = request.args.get('docId')
            try: 
                doc_ref = db.collection("attendance").document(docId)
            except:
                return jsonify('Document not found'),404
            doc = doc_ref.get().to_dict()
            for imgUrl in doc['images']:
                attendees.extend(mark_attendance(image_names, known_face_encoding,imgUrl))
            attendees = list(set(attendees))
            attendees.sort()
            doc['attendees'] = attendees
            fileName = doc['slot'].replace('+','_')+'_'+doc['date'].replace('/','_')+'.csv'
            f = open('output_files/'+fileName, 'w+', newline='')
            lnwriter = csv.writer(f)
            lnwriter.writerow(['Name'])
            for student in attendees:
                lnwriter.writerow([student])
            f.close()
            doc_ref.set(doc)
        return jsonify('Data written'),200

@app.route('/download', methods=['GET'])
def download_file():

    slot = request.args.get('slot')
    date = request.args.get('date')

    project_directory = os.path.abspath(os.path.dirname(__file__))
    file_path = os.path.join(project_directory, 'files', slot+'_'+date+'.csv')
    print(file_path)
    filename = str(slot+'_'+date+'.csv')

    return send_file(file_path, download_name =filename, as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000,debug=True)