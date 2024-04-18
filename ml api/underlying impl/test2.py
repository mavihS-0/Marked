import face_recognition
import cv2
import os
import numpy as np

def visualize_face_matching(group_image_path, known_face_encodings, known_face_names):
    # Load the group image
    group_image = cv2.imread(group_image_path)

    # Convert the image from BGR color (OpenCV) to RGB color (face_recognition)
    rgb_group_image = cv2.cvtColor(group_image, cv2.COLOR_BGR2RGB)

    # Display the original group image
    cv2.imshow("Original Group Image", group_image)
    cv2.waitKey(0)

    # Find all face locations in the group image
    face_locations = face_recognition.face_locations(rgb_group_image)

    # Create a copy of the group image for visualization
    image_visualize = np.copy(group_image)

    # Loop through each face found in the group image
    for face_location in face_locations:
        # Extract the coordinates of the face
        top, right, bottom, left = face_location

        # Draw a rectangle around the face
        cv2.rectangle(image_visualize, (left, top), (right, bottom), (0, 255, 0), 2)

        # Display the image with face detection
        cv2.imshow("Face Detection", image_visualize)
        cv2.waitKey(0)

        # Extract the face encoding of the current face
        face_encoding = face_recognition.face_encodings(rgb_group_image, [face_location])[0]

        # Compare the face encoding with known face encodings
        matches = face_recognition.compare_faces(known_face_encodings, face_encoding)

        # Initialize the name of the person as unknown by default
        name = "Unknown"

        # Check if a match is found
        if True in matches:
            # Find the index of the matched face encoding
            match_index = matches.index(True)

            # Get the name of the matched person
            name = known_face_names[match_index]

        # Annotate the image with the name of the matched person
        cv2.putText(image_visualize, name, (left + 6, bottom - 6), cv2.FONT_HERSHEY_DUPLEX, 0.5, (255, 255, 255), 1)

        # Display the image with annotations
        cv2.imshow("Face Recognition Results", image_visualize)
        cv2.waitKey(0)

    # Display the final image with face recognition results
    cv2.imshow("Final Face Recognition Results", image_visualize)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# Folder path containing known face images
folder_path = r"E:\DISK_DRIVE\marked\Marked\ml api\known images"

# Load known face encodings and names
known_face_encodings = []
known_face_names = []

for filename in os.listdir(folder_path):
    if filename.lower().endswith(('.jpg', '.jpeg', '.png')):
        image_path = os.path.join(folder_path, filename)
        image = face_recognition.load_image_file(image_path)
        face_encoding = face_recognition.face_encodings(image)[0]
        known_face_encodings.append(face_encoding)
        known_face_names.append(os.path.splitext(filename)[0])

# Path to the group image
group_image_path = "group3.jpg"

# Call the function to visualize face matching
visualize_face_matching(group_image_path, known_face_encodings, known_face_names)
