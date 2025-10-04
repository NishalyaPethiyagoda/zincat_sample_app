class BlogModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  BlogModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to create a BlogModel from JSON
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
