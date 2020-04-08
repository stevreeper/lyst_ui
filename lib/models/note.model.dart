import 'dart:convert';

class Note {
  int id;
  String title;
  String content;
  int categoryId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    this.id,
    this.title,
    this.content,
    this.categoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        categoryId = json['categoryId'],
        userId = json['userId'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'categoryId': categoryId,
        'userId': userId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  @override
  String toString() => jsonEncode(this.toJson());
}
