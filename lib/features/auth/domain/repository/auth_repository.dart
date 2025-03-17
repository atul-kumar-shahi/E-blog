import 'package:blog/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRepository{
 Future<Either<Failure,User>>signUpWithEmailPassword({required String name, required String email, required String password});
 Future<Either<Failure,User>>SignInWithEmailPassword({ required String email, required String password});
 Future<Either<Failure,User>>currentUser();

}