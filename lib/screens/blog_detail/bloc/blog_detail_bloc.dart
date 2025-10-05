import 'package:bloc/bloc.dart';
import 'blog_detail_event.dart';
import 'blog_detail_state.dart';
import 'package:zincat_sample_app/screens/blog_detail/blog_detail_repository.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  final BlogDetailRepository repository;

  BlogDetailBloc(this.repository) : super(BlogDetailInitial()) {
    on<BlogDetailLoadEvent>((event, emit) async {
      emit(BlogDetailLoading());
      try {
        final comments = await repository.getCommentsForPost(event.postId);
        emit(BlogDetailLoaded( comments: comments));
      } catch (e) {
        emit(BlogDetailError(e.toString()));
      }
    });
  }
}
