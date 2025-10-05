import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_bloc.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_event.dart';
import 'package:zincat_sample_app/screens/home/bloc/home_state.dart';
import 'package:zincat_sample_app/screens/home/home_repository.dart';
import 'package:zincat_sample_app/widgets/blog_dashboard_card.dart';
import 'package:zincat_sample_app/widgets/custom_popup.dart';

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
  List<BlogModel> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChange);
  }

  void _onSearchChange() {
    searchQuery = searchController.text;
    setState(() {
      filteredProducts = products.where((product) {
        return product.title.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(HomeRepository())..add(HomeGetProductsEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            isLoading = true;
          } else if (state is HomeProductsLoadedState) {
            products = state.products;
            filteredProducts = products;
            setState(() {
              isLoading = false;
            });
          } else if (state is HomeErrorState) {
            setState(() {
              isLoading = false;
            });
            showCustomPopup(
              context: context,
              titleText: 'Error',
              text: state.message,
              primaryButtonText: 'Cancel',
              onPrimaryButtonPress: () {
                Navigator.of(context).pop();
              },
            );
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
              backgroundColor: const Color.fromARGB(255, 10, 88, 199),
              centerTitle: expandSearch ? false : true,
              title: Text(
                "BLOGS",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
              ),
              actions: [
                expandSearch
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                        child: SizedBox(
                          width: 230,
                          height: 35,
                          child: TextField(
                            autofocus: false,
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Post by Title...',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.88),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
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
                        icon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.88)),
                      ),
              ],
            ),
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 10, 88, 199), Color.fromARGB(255, 230, 244, 255)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : filteredProducts.isNotEmpty
                      ? ListView.builder(
                          itemCount: (filteredProducts.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            int firstIndex = index * 2;
                            int secondIndex = firstIndex + 1;

                            BlogModel leftProduct = filteredProducts[firstIndex];
                            BlogModel? rightProduct = secondIndex < filteredProducts.length
                                ? filteredProducts[secondIndex]
                                : null;

                            // Map title-length ratio to flex range 3..7
                            final int leftTitleLen = leftProduct.title.length;
                            final int rightTitleLen = rightProduct?.title.length ?? 0;

                            // If no right product, show left product full width
                            if (rightProduct == null) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: BlogDashboardCard(
                                  product: leftProduct,
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                ),
                              );
                            }

                            final int totalTitle = leftTitleLen + rightTitleLen;
                            final double ratio = totalTitle == 0 ? 0.5 : (leftTitleLen / totalTitle);

                            int leftFlex = (2 + (ratio * 6)).round();
                            if (leftFlex < 2) leftFlex = 2;
                            if (leftFlex > 8) leftFlex = 8;
                            final int rightFlex = 10 - leftFlex;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: leftFlex,
                                    child: BlogDashboardCard(
                                      product: leftProduct,
                                      onTap: () {
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: rightFlex,
                                    child: BlogDashboardCard(
                                      product: rightProduct,
                                      onTap: () {
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "No Blogs Available. Refresh to Load again.",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
