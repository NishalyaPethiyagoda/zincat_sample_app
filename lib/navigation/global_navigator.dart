import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/common/global_variables.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_bloc.dart';
import 'package:zincat_sample_app/screens/blog_detail/blog_detail_repository.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_bloc.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_event.dart';
import 'package:zincat_sample_app/screens/home/home_repository.dart';
import 'package:zincat_sample_app/screens/home/view/home_screen.dart';
import 'package:zincat_sample_app/screens/blog_detail/view/blog_detail_screen.dart';

class GlobalNavigator extends StatelessWidget {
  const GlobalNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(HomeRepository())..add(HomeGetProductsEvent()),
        ),
        BlocProvider<BlogDetailBloc>(
      create: (BuildContext context) =>
          BlogDetailBloc(BlogDetailRepository()),
        ),
      ],
      child: Navigator(
        key: globalNavigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/homeScreen":
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
                settings: RouteSettings(name: '/homeScreen', arguments: args),
              );

            case '/blogDetailScreen':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) {
                  return BlogDetailScreen(blog: args['blog']);
                },
                settings: RouteSettings(name: '/blogDetailScreen', arguments: args),
              );

            default:
              return MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
                settings: RouteSettings(name: '/homeScreen'),
              );
          }
        },
      ),
    );
  }
}
