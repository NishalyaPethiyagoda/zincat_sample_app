sealed class BlogDetailEvent {}

class BlogDetailLoadEvent extends BlogDetailEvent {
  final int postId;
  BlogDetailLoadEvent(this.postId);
}
