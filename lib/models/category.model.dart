import 'dart:convert';

class Category {
  int id;
  String title;
  int color;
  int userId;
  int notesCount;
  DateTime createdAt;
  DateTime updatedAt;

  Category(
      {this.id,
      this.title,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        color = json['color'],
        userId = json['userId'],
        notesCount = int.parse(json['notesCount']),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'color': color,
        'userId': userId,
        'notesCount': notesCount,
        'createdAt': createdAt.toIso8601String(),
        'updateAt': updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
