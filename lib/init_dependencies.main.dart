part of 'init_dependencies.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
  );

  Hive.defaultDirectory=(await getApplicationDocumentsDirectory() ).path;
  serviceLocater.registerLazySingleton(() => supabase.client);
  _initAuth();
  _initBlog();

  serviceLocater.registerFactory(()=> InternetConnection());

  serviceLocater.registerLazySingleton(()=>Hive.box(name: 'blogs'));
  //core
  serviceLocater.registerLazySingleton(() => AppUserCubit());

  serviceLocater.registerFactory<ConnectionChecker>(()=>ConnectionCheckerImp(internetConnection:serviceLocater() ));
}

void _initAuth() {
  serviceLocater
  //Data Source
    ..registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(serviceLocater()),
    )

    ..registerFactory<BlogLocalDataSource>(()=> BlogLocalDataSourceImp(serviceLocater()))
  //Repository
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(serviceLocater(),serviceLocater()),
    )
  //User Cases
    ..registerFactory(() => UserSignUp(serviceLocater()))
    ..registerFactory(() => UserSignIn(serviceLocater()))
    ..registerFactory(() => CurrentUser(serviceLocater()))
  //Bloc
    ..registerLazySingleton(
          () => AuthBloc(
        userSignUp: serviceLocater(),
        userSignIn: serviceLocater(),
        currentUser: serviceLocater(),
        appUserCubit: serviceLocater(),
      ),
    );
}

void _initBlog() {
  serviceLocater

  //data source
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImp(serviceLocater()))


  //repository
    ..registerFactory<BlogRepository>(()=>BlogRepositoryImpl(serviceLocater(),serviceLocater(),serviceLocater()))

  //use case
    ..registerFactory(()=>UploadBlog(serviceLocater()))

    ..registerFactory(()=>GetAllBlogs(serviceLocater()))

  //bloc
    ..registerLazySingleton(()=>BlogBloc(getAllBlogs: serviceLocater(), uploadBlog: serviceLocater()));
}
