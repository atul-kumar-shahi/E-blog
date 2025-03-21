import 'dart:io';
import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl( this.connectionChecker,this.blogLocalDataSource,this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {

    try{
      if(!await(connectionChecker.isConnected)){
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        topics: topics,
        id: const Uuid().v1(),
        posterId: posterId,
        content: content,
        title: title,
        imageUrl: '',
        updatedAt: DateTime.now(),
      );
      final imageUrl=await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);

      blogModel=blogModel.copyWith(
        imageUrl: imageUrl,
      );
      final uploadedBlog=await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    }on ServerException catch(e){
      return Left(Failure(e.message));
    }

  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async{
    try{
      if(!await(connectionChecker.isConnected)){
        final blogs=blogLocalDataSource.loadBlogs();
        return right(blogs);
       }
       final blogs= await blogRemoteDataSource.getAllBlogs();
        blogLocalDataSource.uploadLocalBlog(blogs: blogs);
       return right(blogs);
    }on ServerException catch(e){
      return Left(Failure(e.toString()));
    }
  }
}
