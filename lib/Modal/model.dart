class Note {
  int? id;
  String title;
  String content;
  String dateCreated;
  String category;
  String priority;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.category,
    required this.priority,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date_created': dateCreated,
      'category': category,
      'priority': priority,
    };
  }


  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dateCreated: map['date_created'],
      category: map['category'],
      priority: map['priority'],
    );
  }
}
