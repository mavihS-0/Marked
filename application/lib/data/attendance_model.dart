class Attendance{
  final List<String> attendees;
  final List<String> images;
  final String time;
  final String slot;
  final String date;
  final String id;

  Attendance({
    required this.id,
    required this.attendees,
    required this.images,
    required this.time,
    required this.slot,
    required this.date,
  });

  factory Attendance.fromMap(Map<String, dynamic> map){
    DateTime dateTime = map['time'].toDate();
    String date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    String time = '${dateTime.hour}:${dateTime.minute}';
    map['attendees'].sort();
    return Attendance(
      id: map['id'],
      attendees: List<String>.from(map['attendees']),
      images: List<String>.from(map['images']),
      date: date,
      time: time,
      slot: map['slot'],
    );
  }
}