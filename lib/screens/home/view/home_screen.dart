import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_bloc.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_event.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_state.dart';
import 'package:zincat_sample_app/screens/home/home_repository.dart';
import 'package:zincat_sample_app/widgets/blog_dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BlogModel> products = [];
  bool isLoading = true;
  bool expandSearch = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // searchController.addListener(_onSearchChange);
  }

  // void _onSearchChange() {
  //   Provider.of<ProductProvider>(
  //     context,
  //     listen: false,
  //   ).filterProducts(searchController.text);
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          HomeBloc(HomeRepository())..add(HomeGetProductsEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            isLoading = true;
          } else if (state is HomeProductsLoadedState) {
            products = state.products;
            // Provider.of<ProductProvider>(
            //   context,
            //   listen: false,
            // ).setProductItems(products);
            setState(() {
              isLoading = false;
            });
          }
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
              expandSearch = !expandSearch;
            });
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 251, 169, 128),
              centerTitle: false,
              title: Text(
                "Posts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              actions: [
                expandSearch
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            autofocus: false,
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Post by Title...',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ), // Adjust the radius as needed
                                borderSide: BorderSide
                                    .none, // Optional: to remove border color
                              ),
                            ),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            expandSearch = !expandSearch;
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
              ],
            ),
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 251, 169, 128),
                      Color.fromARGB(255, 251, 222, 208),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.grey),
                        )
                      : ListView.builder(
                          itemCount: (products.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            int firstIndex = index * 2;
                            int secondIndex = firstIndex + 1;

                            BlogModel leftProduct = products[firstIndex];
                            BlogModel? rightProduct =
                                secondIndex < products.length
                                ? products[secondIndex]
                                : null;
                            return Row(
                              children: [
                                Expanded(
                                  child: BlogDashboardCard(
                                    product: leftProduct,
                                  ),
                                ),
                                rightProduct != null
                                    ? Expanded(
                                        child: BlogDashboardCard(
                                          product: rightProduct,
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
