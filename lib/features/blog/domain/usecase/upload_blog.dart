import 'dart:io';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/blog.dart';

class UploadBlog implements UseCase<Blog,BlogParams>{
  final BlogRepository blogRepository;
  UploadBlog( this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(BlogParams params) async{
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
        topics: params.topics,
    );
  }
   
}


class BlogParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  BlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}