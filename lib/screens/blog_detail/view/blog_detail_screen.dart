import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/models/blog_comment_model.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_bloc.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_event.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_state.dart';
import 'package:zincat_sample_app/screens/blog_detail/blog_detail_repository.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider<BlogDetailBloc>(
      create: (BuildContext context) =>
          BlogDetailBloc(BlogDetailRepository())..add(BlogDetailLoadEvent(widget.blog.id)),
      child: BlocListener<BlogDetailBloc, BlogDetailState>(
        listener: (context, state) {
          if (state is BlogDetailLoading) {
          } else if (state is BlogDetailLoaded) {
            comments = state.comments;
          } else if (state is BlogDetailError) {
          }
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 10, 88, 199),
                centerTitle: true,
                iconTheme: const IconThemeData(
                  color: Colors.white, // Set the back button color to white
                ),
                title: const Text(
                  "Blog Detail",
                  style: TextStyle(
                    color: Colors.white, // Set the title color to white
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.35,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(255, 10, 88, 199), Color.fromARGB(255, 56, 181, 195)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24.0),
                              bottomRight: Radius.circular(24.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(color: const Color.fromARGB(255, 230, 244, 255).withValues(alpha: 0.88)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                      child: Hero(
                        tag: widget.blog.id,
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.blog.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.88),
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: 25,
                      right: 25,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
                        child: Column(
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNotExpanded = !isNotExpanded;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                                      child: Text(
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        widget.blog.body,
                                        overflow: isNotExpanded ? TextOverflow.ellipsis : null,
                                        maxLines: isNotExpanded ? 4 : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    isNotExpanded
                                        ? const Text(
                                            "Tap to view more",
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
