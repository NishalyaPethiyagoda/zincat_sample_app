import 'package:flutter/material.dart';
import 'package:zincat_sample_app/models/blog_model.dart';
import 'package:zincat_sample_app/screens/blog_detail/view/blog_detail_screen.dart';

class BlogDashboardCard extends StatelessWidget {
  final BlogModel product;
  const BlogDashboardCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlogDetailScreen(blog: product),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8.0, 4, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: product.id,
                child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // Text('\$ ${product.price.toString()}'),
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
