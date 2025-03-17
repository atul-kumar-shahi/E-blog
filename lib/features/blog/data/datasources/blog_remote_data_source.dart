import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImp implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImp(this.supabaseClient);

  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blog').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
} catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogData = await supabaseClient
          .from('blog')
          .select('*, profiles (name)');
      return blogData
          .map(
            (e) => BlogModel.fromJson(
              e,
            ).copyWith(posterName: e['profiles']['name']),
          )
          .toList();
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
