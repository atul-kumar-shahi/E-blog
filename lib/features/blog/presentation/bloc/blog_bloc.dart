import 'dart:io';
import 'package:blog/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blog/features/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      BlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold((l) => BlogFailure(l.failureMessage), (r) => emit(BlogUploadSuccess()));
  }

  void _onFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res=await _getAllBlogs(NoParams());

    res.fold((l) => BlogFailure(l.failureMessage), (r) => emit(BlogDisplaySuccess(r)));
  }
}
