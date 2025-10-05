import 'package:zincat_sample_app/models/blog_model.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeProductsLoadedState extends HomeState {
  final List<BlogModel> products;
  HomeProductsLoadedState(this.products);
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}
