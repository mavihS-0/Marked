import numpy as np
import cv2
import face_recognition
import csv
from datetime import datetime
from face_encodings import get_face_encodings

def mark_attendance(image_names, known_face_encoding):
    now = datetime.now()
    current_date = now.strftime("%Y-%m-%d")
    print(current_date, "  ", now)

    l1 =[]

    students = image_names.copy()

    file_name = current_date + '.csv'
    f = open(file_name, 'w+', newline='')
    lnwriter = csv.writer(f)

    input_image_path = r"C:\Users\shiva\Documents\face attendance\image2.jpg"
    input_image = face_recognition.load_image_file(input_image_path)
    input_image_rgb = cv2.cvtColor(input_image, cv2.COLOR_BGR2RGB)
    face_locations = face_recognition.face_locations(input_image_rgb)
    face_encodings = face_recognition.face_encodings(input_image_rgb, face_locations)

    if students:
        face_names = []
        for face_encoding in face_encodings:
            matches = face_recognition.compare_faces(known_face_encoding, face_encoding)
            name = ""
            face_distances = face_recognition.face_distance(known_face_encoding, face_encoding)
            best_match_index = np.argmin(face_distances)
            
            if matches[best_match_index]:
                name = image_names[best_match_index]
            
            face_names.append(name)
            
            if name in students:
                students.remove(name)
                l1.append(name)
                current_time = now.strftime("%H-%M-%S")
                lnwriter.writerow([name, current_time])
    return l1

    f.close()