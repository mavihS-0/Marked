import face_recognition
import cv2
import os
import numpy as np
import json

def load_face_encodings(input_file):
    with open(input_file, 'r') as json_file:
        data = json.load(json_file)

    face_encodings = np.array(data['face_encodings'])

    return data['filenames'], face_encodings


def resize_image(image):
    screen_height, screen_width = 800, 1200  

    image_height, image_width = image.shape[:2]

    scale = min(screen_height / image_height, screen_width / image_width)

    resized_image = cv2.resize(image, (int(image_width * scale), int(image_height * scale)))

    return resized_image


def visualize_face_matching(group_image_path, known_face_encodings, known_face_names):
    group_image = cv2.imread(group_image_path)

    rgb_group_image = cv2.cvtColor(group_image, cv2.COLOR_BGR2RGB)

    cv2.imshow("Original Group Image", resize_image(group_image))
    cv2.waitKey(0)

    face_locations = face_recognition.face_locations(rgb_group_image,model='hog')

    # Sort face locations based on their top-right coordinates
    face_locations.sort(key=lambda loc: (loc[0], loc[3]))

    image_visualize = np.copy(group_image)
    for face_location in face_locations:
       
        top, right, bottom, left = face_location

        cv2.rectangle(image_visualize, (left, top), (right, bottom), (0, 255, 0), 2)

        # cv2.imshow("Face Detection", resize_image(image_visualize))
        # cv2.waitKey(0)

        face_landmarks = face_recognition.face_landmarks(rgb_group_image, [face_location])[0]

        for facial_feature in face_landmarks.keys():
            for point in face_landmarks[facial_feature]:
                cv2.circle(image_visualize, point, 2, (0, 0, 255), -1)

        face_encoding = face_recognition.face_encodings(rgb_group_image, [face_location])[0]

        matches = face_recognition.compare_faces(known_face_encodings, face_encoding, tolerance=0.45)
        name = "unknown"

        face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
        best_match_index = np.argmin(face_distances)

        print(face_distances,known_face_names)
        print(matches,known_face_names)
            
        if matches[best_match_index]:
            name = known_face_names[best_match_index]

        text_size, _ = cv2.getTextSize(name, cv2.FONT_HERSHEY_DUPLEX, 1, 1)
        cv2.rectangle(image_visualize, (left + 6, bottom - text_size[1] - 6), (left + text_size[0] + 6, bottom + 6), (0, 255, 0), cv2.FILLED)
        cv2.putText(image_visualize, name, (left + 6, bottom - 6), cv2.FONT_HERSHEY_DUPLEX, 1, (0,0,0), 1)

        # cv2.imshow("Face Recognition Results", resize_image(image_visualize))
        # cv2.waitKey(0)

    cv2.imshow("Final Face Recognition Results", resize_image(image_visualize))
    cv2.waitKey(0)
    cv2.imwrite('output_img.jpg',image_visualize)
    cv2.destroyAllWindows()


input_file = "face_encodings.json"

filenames, face_encodings = load_face_encodings(input_file)

group_image_path = "group5.jpg"

filenames = [os.path.splitext(filename)[0] for filename in filenames]

visualize_face_matching(group_image_path, face_encodings, filenames)
