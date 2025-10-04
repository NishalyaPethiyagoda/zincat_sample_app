import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/network/http_methods.dart';

class HomeRepository {
  HttpMethods httpMethods = HttpMethods();

  HomeRepository();

  // ProductModel products
  Future<List<BlogModel>> getPoducts() async {
    try {
      final response = await httpMethods.commonApiGet("posts");
      List<BlogModel> allBlogList = (response as List<dynamic>)
          .map((json) => BlogModel.fromJson(json))
          .toList();
      return allBlogList;
    } catch (e) {
      rethrow;
    }
  }
}
