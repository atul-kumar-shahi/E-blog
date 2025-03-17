import 'package:blog/core/common/entities/user.dart';
import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.remoteDataSource,this.connectionChecker);


  @override
  Future<Either<Failure, User>> currentUser() async{
   try{
     if(!await (connectionChecker.isConnected)){
        final session =remoteDataSource.currentUserSession;
        if(session ==null){
          return left(Failure('user not Logged in'));
        }
        return right(UserModel(id: session.user.id, name: '', email: session.user.email??''));
      }
      final user=await remoteDataSource.getCurrentUserData();

      if(user==null){
        return left(Failure('user not Logged in'));
      }

      return right(user);
   }on ServerException catch(e){
     return left(Failure(e.message));
   }
  }

  @override
  Future<Either<Failure, User>> SignInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if(!await (connectionChecker.isConnected)){
        return Left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }


}
