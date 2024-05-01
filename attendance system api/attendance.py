from face_encodings import get_face_encodings
from write_attendance import mark_attendance
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

image_names, known_face_encoding = get_face_encodings()

cred = credentials.Certificate("marked-b1ac1-firebase-adminsdk-am0i3-70dda8ce76.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
doc_ref = db.collection("attendance").document("pSY5Ir2aswyqFmdaSP8O")
doc = doc_ref.get().to_dict()
l1 = []
for imgUrl in doc['images']:
    l1.extend(mark_attendance(image_names, known_face_encoding,imgUrl))

doc['attendees'] = l1
doc_ref.set(doc)