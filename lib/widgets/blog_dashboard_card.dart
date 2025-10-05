import 'package:flutter/material.dart';
import 'package:zincat_sample_app/common/global_variables.dart';
import 'package:zincat_sample_app/models/blog_model.dart';

class BlogDashboardCard extends StatelessWidget {
  final BlogModel product;
  final VoidCallback? onTap;
  const BlogDashboardCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
        globalNavigatorKey.currentState?.pushNamed('/blogDetailScreen', arguments: {'blog': product});
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
                      product.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.body,
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
