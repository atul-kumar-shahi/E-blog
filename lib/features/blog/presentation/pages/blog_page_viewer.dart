import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/format_date.dart';
import '../../domain/entities/blog.dart';

class BlogPageViewer extends StatelessWidget {

  const BlogPageViewer({super.key, required this.blog});

  final Blog blog;

  static route(Blog blog) => MaterialPageRoute(builder: (context)=>BlogPageViewer(blog: blog));



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                Text(blog.title,style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 5,),
                Text(formatDate(blog.updatedAt)),
                SizedBox(height: 20,),
        
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(blog.imageUrl),
                ),
                SizedBox(height: 20,),
                Text(blog.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
