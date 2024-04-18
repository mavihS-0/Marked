import face_recognition
import os

def get_face_encodings():
    folder_path = r"E:\DISK_DRIVE\marked\Marked\ml api\known images"

    image_names = ['21BCE6196','21BCE0001','21BCE0002','21BCE5780','21BCE0003','21BCE5319','21BCE0004','21BCE6205','21BCE0005','21BCE1619','21BCE0006','21BCE0007','21BCE0008','21BCE6204','21BCE0009']

    known_face_encoding = []

    for filename in os.listdir(folder_path):
        if filename.lower().endswith(('.jpg', '.jpeg', '.png')): 
            image_path = os.path.join(folder_path, filename)
            
            image = face_recognition.load_image_file(image_path)
            
            face_locations = face_recognition.face_locations(image)
            
            if len(face_locations) > 0:
                face_encoding = face_recognition.face_encodings(image, known_face_locations=[face_locations[0]])[0]
                
                known_face_encoding.append(list(face_encoding))
                
            else:
                print(f"No faces found in {filename}")

    return image_names, known_face_encoding