import face_recognition
import cv2
import os
import numpy as np

def resize_image(image):
    screen_height, screen_width = 800, 1200  

    image_height, image_width = image.shape[:2]

    scale = min(screen_height / image_height, screen_width / image_width)

    resized_image = cv2.resize(image, (int(image_width * scale), int(image_height * scale)))

    return resized_image


def visualize_face_detection(group_image_path):
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

        face_landmarks = face_recognition.face_landmarks(rgb_group_image, [face_location])[0]

        for facial_feature in face_landmarks.keys():
            for point in face_landmarks[facial_feature]:
                cv2.circle(image_visualize, point, 2, (0, 0, 255), -1)


    cv2.imshow("Final Face Recognition Results", resize_image(image_visualize))
    cv2.waitKey(0)
    cv2.imwrite('output_img.jpg',image_visualize)
    cv2.destroyAllWindows()


group_image_path = "group.jpg"


visualize_face_detection(group_image_path )
