import 'package:bloc/bloc.dart';

import 'package:zincat_sample_app/models/blog_model.dart';

import 'package:zincat_sample_app/screens/home/bloc/home_event.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_state.dart';
import 'package:zincat_sample_app/screens/home/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitialState()) {
    on<HomeGetProductsEvent>((event, emit) async {
      emit(HomeInitialState());

      try {
        List<BlogModel> products = await homeRepository.getPoducts();

        emit(HomeProductsLoadedState(products));
      } catch (e) {
        print('-----------------> home bloc get products error:  $e');
      }
    });
  }
}
