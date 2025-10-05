import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/network/http_methods.dart';

class HomeRepository {
  HttpMethods httpMethods = HttpMethods();

  HomeRepository();

  // ProductModel products
  Future<List<BlogModel>> getBlogPost() async {
    try {
      final response = await httpMethods.commonApiGet("posts");
      print('------------------> response at getPosts $response');
      if (response is! List) {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
      List<BlogModel> allBlogList = (response)
          .map((json) => BlogModel.fromJson(json))
          .toList();
      return allBlogList;
    } catch (e) {
      throw Exception('-----------> HomeRepository - getBlogPost failed: $e');
    }
  }
}
