class BlogCommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  BlogCommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  // Factory constructor for creating a BlogCommentModel from JSON
  factory BlogCommentModel.fromJson(Map<String, dynamic> json) {
    return BlogCommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
