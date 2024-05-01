import numpy as np
import urllib.request
import cv2
import face_recognition
from datetime import datetime

def mark_attendance(image_names, known_face_encoding,imgURL):
    l1 =[]

    students = image_names.copy()    

    # Download and load the image from the URL
    image_url = imgURL
    response = urllib.request.urlopen(image_url)
    image_data = response.read()
    nparr = np.frombuffer(image_data, np.uint8)
    input_image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    # input_image_path = r"C:\Users\shiva\Documents\face attendance\image2.jpg"
    # input_image = face_recognition.load_image_file(input_image_path)
    input_image_rgb = cv2.cvtColor(input_image, cv2.COLOR_BGR2RGB)
    face_locations = face_recognition.face_locations(input_image_rgb)
    face_encodings = face_recognition.face_encodings(input_image_rgb, face_locations)

    if students:
        face_names = []
        for face_encoding in face_encodings:
            matches = face_recognition.compare_faces(known_face_encoding, face_encoding, tolerance=0.45)
            name = ""
            face_distances = face_recognition.face_distance(known_face_encoding, face_encoding)
            best_match_index = np.argmin(face_distances)
            
            if matches[best_match_index]:
                name = image_names[best_match_index]
            
            face_names.append(name)
            
            if name in students:
                students.remove(name)
                l1.append(name)
    return l1
