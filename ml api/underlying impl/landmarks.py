import face_recognition
import cv2
import numpy as np

def resize_image(image):
    screen_height, screen_width = 800, 1200  

    image_height, image_width = image.shape[:2]

    scale = min(screen_height / image_height, screen_width / image_width)

    resized_image = cv2.resize(image, (int(image_width * scale), int(image_height * scale)))

    return resized_image

def visualize_face_recognition(image_path):
    image = cv2.imread(image_path)
    image = resize_image(image)

    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    cv2.imshow("Original Image", image)
    cv2.waitKey(0)

    face_locations = face_recognition.face_locations(rgb_image)

    face_locations.sort(key=lambda loc: (loc[0], loc[3]))

    image_visualize = np.copy(image)

    for face_location in face_locations:
        top, right, bottom, left = face_location

        cv2.rectangle(image_visualize, (left, top), (right, bottom), (0, 255, 0), 2)

        cv2.imshow("Face Detection", image_visualize)
        cv2.waitKey(0)

        face_landmarks = face_recognition.face_landmarks(rgb_image, [face_location])[0]
        print(face_landmarks)

        for facial_feature in face_landmarks.keys():
            for point in face_landmarks[facial_feature]:
                cv2.circle(image_visualize, point, 2, (0, 0, 255), -1)

        cv2.imshow("Facial Landmarks", image_visualize)
        cv2.waitKey(0)

        face_encoding = face_recognition.face_encodings(rgb_image, [face_location])[0]
        print(len(face_encoding))

    cv2.imshow("Final Result", image_visualize)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

image_path = "gaurav.jpg"

visualize_face_recognition(image_path)
