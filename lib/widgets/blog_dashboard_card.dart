import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zincat_sample_app/common/global_variables.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_bloc.dart';
import 'package:zincat_sample_app/screens/blog_detail/bloc/blog_detail_event.dart';

class BlogDashboardCard extends StatelessWidget {
  final BlogModel blogPost;
  final VoidCallback? onTap;
  const BlogDashboardCard({super.key, required this.blogPost, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
        context.read<BlogDetailBloc>().add(BlogDetailLoadEvent(blogPost.id));
        globalNavigatorKey.currentState?.pushNamed('/blogDetailScreen', arguments: {'blog': blogPost});
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      blogPost.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      blogPost.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
