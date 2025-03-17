import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/user.dart';
import '../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required CurrentUser currentUser,
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit =appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>AuthLoading());
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_onAuthUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        password: event.password,
        email: event.email,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l.failureMessage)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
      UserSignInParams(password: event.password, email: event.email),
    );
    res.fold(
      (l) => emit(AuthFailure(l.failureMessage)),
      (user) =>_emitAuthSuccess(user,emit),
    );
  }

  void _onAuthUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.failureMessage)),
      (user)=> _emitAuthSuccess(user,emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit)async{

     _appUserCubit.updateUser(user);
      emit(AuthSuccess(user)) ;
  }
}
