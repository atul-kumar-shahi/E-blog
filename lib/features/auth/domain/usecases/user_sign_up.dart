import 'package:blog/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<User,UserSignUpParams >{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params)async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password
    );
  }
  
}

class UserSignUpParams{
  const UserSignUpParams({ required this.name,required this.password,required this.email});
  final String name;
  final String email;
  final String password;
}