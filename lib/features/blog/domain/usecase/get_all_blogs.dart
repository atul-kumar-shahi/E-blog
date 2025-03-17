import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/blog.dart';
import '../repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>,NoParams>{
  final BlogRepository blogRepository;
  GetAllBlogs( this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params)async {
    return await blogRepository.getAllBlogs();
  }

}