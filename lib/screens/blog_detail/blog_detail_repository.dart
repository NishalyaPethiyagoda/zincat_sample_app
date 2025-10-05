import 'package:zincat_sample_app/models/blog_comment_model.dart';
import 'package:zincat_sample_app/network/http_methods.dart';

class BlogDetailRepository {
  final HttpMethods httpMethods = HttpMethods();

  Future<List<BlogCommentModel>> getCommentsForPost(int postId) async {
    try {
      final response = await httpMethods.commonApiGet('posts/$postId/comments');
      if (response is List) {
        return response.map((json) => BlogCommentModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Unexpected response for comments: ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('BlogDetailRepository.getCommentsForPost failed: $e');
    }
  }
}
