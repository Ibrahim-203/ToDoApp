class Todo {
  final int id;
  final String title;

  final String createdAt;
  final String? updatedAt;
  final bool status;

  Todo({
    required this.id,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    required this.status,
  });

  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map) => Todo(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'])
          .toIso8601String(),
      updatedAt: map['updated_at'] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(map['updated_at'])
              .toIso8601String(),
      status: map['status'] == 1);
}
