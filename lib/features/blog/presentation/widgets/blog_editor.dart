import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
      maxLines: null,
      validator:(value){
        if(value!.isEmpty){
          return '$hintText is missing';
        }
        return null;
      }



    );
  }
}
