from face_encodings import get_face_encodings
from write_attendance import mark_attendance

image_names, known_face_encoding = get_face_encodings()

print("Student names:", image_names)
print("Face encodings:", known_face_encoding)

mark_attendance(image_names, known_face_encoding)