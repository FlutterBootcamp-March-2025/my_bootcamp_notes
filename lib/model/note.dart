class Note {
  String? id;
  String title;
  String note;
  DateTime createdAt;

  Note({this.id, required this.title, required this.note, DateTime? createdAt})
    : this.createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(String id, Map<String, dynamic> data) {
    return Note(
      id: id,
      title: data['title'] ?? '',
      note: data['note'] ?? '',
      createdAt:
          data['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
              : DateTime.now(),
    );
  }
}
