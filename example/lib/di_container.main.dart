//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

part of 'di_container.dart';

class Di {
  const Di._();

  static final sl = GetIt.instance;

  static Future<void> init() async {
    /// CORE
    ///

    sl
          ..registerLazySingleton<Dio>(() => Dio())
          ..registerLazySingleton<LoggingInterceptor>(() => LoggingInterceptor())
          ..registerLazySingleton<DioClient>(() => DioClient(Apis.url, dio: sl(), loggingInterceptor: sl()))
          ..registerLazySingleton<NetworkService>(() => NetworkService()..startConnectionStreaming())
        // ..registerLazySingleton<FirebaseClient>(() => FirebaseClient())
        // ..registerLazySingleton<HiveClient>(() => HiveClient()..initHive());
        //
        ;

    /// REPOS
    ///
    sl
          ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dioClient: sl()))
          ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(dioClient: sl()))
        //
        ;

    /// PROVIDERS
    ///
    sl
          ..registerFactory<ThemeProvider>(() => ThemeProvider())
          ..registerFactory<SplashProvider>(() => SplashProvider(sp: sl()))
          ..registerFactory<AuthProvider>(() => AuthProvider(authRepo: sl(), networkService: sl()))
          ..registerFactory<HomeProvider>(() => HomeProvider(networkService: sl()))
          ..registerFactory<DemoProvider>(() => DemoProvider(authRepo: sl(), networkService: sl()))
        //
        ;

    /// EXTERNAL
    ///
    // Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  static List<SingleChildWidget> get changeNotifierProviders => [
        StreamProvider(create: (_) => sl<NetworkService>().controller.stream, initialData: NetworkStatus.offline),
        ChangeNotifierProvider(create: (_) => sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SplashProvider>()),
        ChangeNotifierProvider(create: (_) => sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => sl<DemoProvider>()),
      ];
}

extension GetProvidersExtension on BuildContext {
  ThemeProvider get themeProvider => this.read<ThemeProvider>();
  SplashProvider get splashProvider => this.read<SplashProvider>();
  AuthProvider get authProvider => this.read<AuthProvider>();
  HomeProvider get homeProvider => this.read<HomeProvider>();
  DemoProvider get demoProvider => this.read<DemoProvider>();
}
