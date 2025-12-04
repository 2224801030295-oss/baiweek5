class Note {
  int? id;
  String title;
  String content;
  String timestamp; // ISO string

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      timestamp: map['timestamp'] as String,
    );
  }
}
