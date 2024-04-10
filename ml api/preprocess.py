import cv2
import numpy as np
import os
import face_recognition

# Function to perform image processing and enhancement tasks
def preprocess_image(image, cropFace):
    # Resize the image to reduce computation time
    resized_image = cv2.resize(image, (0, 0), fx=0.5, fy=0.5)

    # Convert the resized image to grayscale
    grayscale_image = cv2.cvtColor(resized_image, cv2.COLOR_BGR2GRAY)

    if(cropFace):
        resized_image = crop_face(resized_image)

    # # Apply histogram equalization to enhance contrast
    # equalized_image = cv2.equalizeHist(grayscale_image)

    #  # Normalize pixel values to range [0, 1]
    # normalized_image = equalized_image.astype(np.float32) / 255.0

    kernel = np.array([[-1,-1,-1], [-1,9,-1], [-1,-1,-1]]) # Sharpening kernel with reduced intensity
    sharpened_image = cv2.filter2D(resized_image, -1, kernel)
    
    return sharpened_image

def crop_face(grayscale_image,padding=0.25):
    # Detect faces in the image
    face_locations = face_recognition.face_locations(grayscale_image)

    if len(face_locations) > 0:
        # Extract the coordinates of the first face
        top, right, bottom, left = face_locations[0]
        
        # Calculate padding around the face
        height, width,_ = grayscale_image.shape
        padding_y = int((bottom - top) * padding)
        padding_x = int((right - left) * padding)
        
        # Expand the bounding box with padding
        top = max(0, top - padding_y)
        right = min(width, right + padding_x)
        bottom = min(height, bottom + padding_y)
        left = max(0, left - padding_x)
        
        # Crop the face region from the image
        cropped_face = grayscale_image[top:bottom, left:right]
        
        return cropped_face
    else:
        return grayscale_image


image_path = r"C:\Users\shiva\Documents\face attendance\image.jpg"
image = cv2.imread(image_path)

# Preprocess and enhance the image
processed_image = preprocess_image(image,True)

# Display the preprocessed image
cv2.imshow('Preprocessed Image', processed_image)
cv2.waitKey(0)  # Wait indefinitely until a key is pressed
cv2.destroyAllWindows() 

output_image_path = os.path.join(r"C:\Users\shiva\Documents\face attendance", f"preprocessed{image_path[-4:]}")
cv2.imwrite(output_image_path, processed_image)