import 'package:zincat_sample_app/models/blog_comment_model.dart';

sealed class BlogDetailState {}

class BlogDetailInitial extends BlogDetailState {}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailLoaded extends BlogDetailState {
  final List<BlogCommentModel> comments;
  BlogDetailLoaded({required this.comments});
}

class BlogDetailError extends BlogDetailState {
  final String message;
  BlogDetailError(this.message);
}
