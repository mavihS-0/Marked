import face_recognition
import cv2
import numpy as np

def visualize_face_recognition(image_path):
    # Load the image
    image = cv2.imread(image_path)

    # Convert the image from BGR color (OpenCV) to RGB color (face_recognition)
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Display the original image
    cv2.imshow("Original Image", image)
    cv2.waitKey(0)

    # Find all face locations in the image
    face_locations = face_recognition.face_locations(rgb_image)

    # Sort face locations based on their top-left coordinates
    face_locations.sort(key=lambda loc: (loc[0], loc[3]))

    # Create a copy of the original image for visualization
    image_visualize = np.copy(image)

    # Loop through each face found in the image
    for face_location in face_locations:
        # Extract the coordinates of the face
        top, right, bottom, left = face_location

        # Draw a rectangle around the face
        cv2.rectangle(image_visualize, (left, top), (right, bottom), (0, 255, 0), 2)

        # Display the image with face detection
        cv2.imshow("Face Detection", image_visualize)
        cv2.waitKey(0)

        # Extract the facial features of the face
        face_landmarks = face_recognition.face_landmarks(rgb_image, [face_location])[0]

        # Draw circles for each facial feature
        for facial_feature in face_landmarks.keys():
            for point in face_landmarks[facial_feature]:
                cv2.circle(image_visualize, point, 2, (0, 0, 255), -1)

        # Display the image with facial landmarks
        cv2.imshow("Facial Landmarks", image_visualize)
        cv2.waitKey(0)

    # Display the final image with face detection and facial landmarks
    cv2.imshow("Final Result", image_visualize)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# Specify the path to the image
image_path = "group2.jpg"

# Call the function to visualize face recognition
visualize_face_recognition(image_path)
