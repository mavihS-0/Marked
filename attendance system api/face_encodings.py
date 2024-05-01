import face_recognition
import os
import json


def save_face_encodings(folder_path, output_file):
    filenames = []
    face_encodings = []

    for filename in os.listdir(folder_path):
        if filename.lower().endswith(('.jpg', '.jpeg', '.png')):
            image_path = os.path.join(folder_path, filename)
            image = face_recognition.load_image_file(image_path)
            face_encoding = face_recognition.face_encodings(image)

            if face_encoding:
                print(filename)
                filenames.append(filename)
                face_encodings.append(face_encoding[0].tolist())

    data = {'filenames': filenames, 'face_encodings': face_encodings}
    with open(output_file, 'w') as json_file:
        json.dump(data, json_file)

folder_path = r"E:\DISK_DRIVE\marked\Marked\ml api\known images"

output_file = "face_encodings.json"

save_face_encodings(folder_path, output_file)