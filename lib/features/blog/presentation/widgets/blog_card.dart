import 'package:blog/core/utils/calculate_reading_time.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';
import '../pages/blog_page_viewer.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.color});

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
     onTap: (){
       Navigator.push(context, BlogPageViewer.route(blog));
     },
      child: Container(
        margin: EdgeInsets.all(16).copyWith(
          bottom: 4
        ),
        padding: EdgeInsets.all(16),
        height: 200,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 6,
                    children:
                        blog.topics.map((e) => Chip(label: Text(e))).toList(),
                  ),
                ),
                Text(blog.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ],
            ),
            Text('${calculateReadingTime(blog.content).toString()} min'),
          ],
        ),
      ),
    );
  }
}
