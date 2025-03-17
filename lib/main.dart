import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/signin_page.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => serviceLocater<AppUserCubit>(),
        ),
        BlocProvider(
          create:
              (_) => serviceLocater<AuthBloc>(),
        ),
        BlocProvider(
          create:
              (_) => serviceLocater<BlogBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState(){
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit,AppUserState,bool>(selector: (state){
        return state is AppUserSignedIn;
      }, builder: (context,isLoggedIn){
        if(isLoggedIn){
          return const BlogPage();
        }
        return SigninPage();
      }),
    );
  }
}
