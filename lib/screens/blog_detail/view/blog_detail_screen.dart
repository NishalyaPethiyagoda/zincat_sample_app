import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/models/blog_comment_model.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_bloc.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_state.dart';
import 'package:zincat_sample_app/widgets/custom_popup.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool isNotExpanded = true;
  List<BlogCommentModel> comments = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogDetailBloc, BlogDetailState>(
      listener: (context, state) {
        if (state is BlogDetailLoading) {
        } else if (state is BlogDetailLoaded) {
          comments = state.comments;
        } else if (state is BlogDetailError) {
          showCustomPopup(
            context: context,
            titleText: 'Error',
            text: state.message,
            secondaryButtonText: 'Cancel',
            onSecondaryButtonPress: () {},
            secondaryButtonColor: const Color.fromARGB(255, 10, 88, 199),
            secondaryButtonTextColor: const Color.fromARGB(255, 255, 255, 255),
          );
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 10, 88, 199),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "BLOG DETAILS",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
              ),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        widget.blog.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2.0, 0, 0.0, 8.0),
                                child: Text(
                                  "Description",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),

                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 54, 132, 241)),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  widget.blog.body,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2.0, 0, 0.0, 8.0),
                              child: Text(
                                "Comments",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            BlocBuilder<BlogDetailBloc, BlogDetailState>(
                              builder: (context, state) {
                                if (state is BlogDetailLoading) {
                                  return const Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(color: Color.fromARGB(255, 10, 88, 199)),
                                    ),
                                  );
                                } else if (state is BlogDetailLoaded) {
                                  return Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 12.0),
                                          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 212, 236, 255),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                comments[index].name,
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                comments[index].body,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: comments.length,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "No Comments Available. Refresh to Load again.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
