import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/user.dart';

class CurrentUser implements UseCase<User,NoParams>{
  final AuthRepository authRepository;
  CurrentUser( this.authRepository);


  @override
  Future<Either<Failure, User>> call(NoParams params) async{

     return await authRepository.currentUser();
  }

}
