# Getting Started with LayerKit

This guide will walk you through the basics of setting up and using LayerKit in your Flutter projects.

## Installation

First, add LayerKit to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  layer_kit: ^1.0.0

```

Run:

```bash
flutter pub get
```

## Creating a New Project

### Option 1: Generate a Complete Project Structure

Start with a fresh Flutter project:

```bash
flutter create my_layerkit_app
cd my_layerkit_app
```

Then generate the LayerKit project structure:

```bash
dart run layer_kit --project
```

This will:
- Create the recommended folder structure
- Set up configuration files
- Add core utilities and components
- Configure routing

### Option 2: Manual Setup

If you prefer to set up manually or integrate into an existing project:

1. Create the folder structure:

```
lib/
├── config/                         # Configuration files
│   ├── data/                       # Data-related config
│   ├── lang/                       # Localization
│   ├── routes/                     # Routing
│   └── theme/                      # Theme configuration
├── core/                           # Core components
│   ├── callbacks/                  # Callback interfaces
│   ├── common/                     # Common utilities
│   │   └── widgets/                # Reusable widgets
│   ├── constants/                  # Constants
│   ├── extensions/                 # Extension methods
│   ├── helper/                     # Helper methods 
│   ├── network/                    # Network service 
│   └── utils/                      # Utilities
├── src/                            # Features
│   ├── feature1/                   # Feature module
│   │   ├── datasource/             # Data sources
│   │   │   ├── models/             # Data models
│   │   │   │   ├── body_models/    # UI display Model (used in screens)
│   │   │   │   ├── requests/       # API request models
│   │   │   │   └── response/       # API response models
│   │   │   └── repo/               # Repository implementation
│   │   ├── providers/              # Feature providers
│   │   └── screens/                # UI screens
│   └── feature2/                   # Another feature module
├── di_container.dart               # Dependency Injection imports (part of di main)
├── di_container.main.dart          # di main file - injection of all dependencies
└── main.dart                       # Entry point
```

2. Set up the LayerKit configuration in your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayerKitInitializer(
      envType: EnvType.development,
      showDevLog: true,
      // Other configuration options
      child: MaterialApp(
        title: 'LayerKit App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
```

## Adding a New Feature

To generate a new feature with all necessary files:

```bash
dart run layer_kit --feature auth
```

This command will create:

```
lib/src/auth/
├── datasource/
│   ├── models/
│   │   └── auth_model.dart
│   ├── requests/
│   │   └── auth_req.dart
│   ├── response/
│   │   └── auth_response.dart
│   └── repo/
│       ├── auth_repo.dart
│       └── auth_repo_impl.dart
├── providers/
│   └── auth_provider.dart
└── screens/
    └── auth_screen.dart
```

It will also update your routes file to include the new feature.

## Building a Feature

Let's walk through implementing a simple authentication feature:

### 1. Define the Data Models, Requests, Responses

```dart
// lib/src/auth/datasource/models/requests/login_req.dart
class LoginReq {
  final String email;
  final String password;

  LoginReq({required this.email, required this.password});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'password': password,
      };

/// CREATE toFormData() METHOD HERE IF YOUR REQUEST CONTAINS FILE
/// AND IT HAVE TO CONVERT TO MULTIPART FILE TO PASS DATA IN API
/// FOR THAT HERE IS DEMO
///
//  Future<FormData> toFormData() async {
//     final imagee = await MultipartFile.fromFile(image?.path ?? "", contentType: MediaType.parse(getMimeType(filePath: image?.path ?? "")));
//     return FormData.fromMap({
//       'name': name,
//       'image': imagee,
//       'status': status ? 1 : 0,
//     });
//   }
}


// lib/src/auth/datasource/models/response/login_response.dart
class LoginResponse {
  final bool status;
  final String message;
  final List<dynamic>? data;

  LoginResponse({required this.status, required this.message, required this.data});

  /// THIS IS fromJson METHOD THAT IS ONLY REQUIRED IN RESPONSE
  /// IF YOU WANT TO STORE DATA OFFLINE THAN YOU NEED TO toJson METHOD

  factory LoginResponse.fromJson(Map<String, dynamic>? json) =>
      LoginResponse(
        status: json?['status'] ?? false,
        message: json?['message'] ?? "Something went wrong.!",
        data: json?['data'],
      );
}



```

### 2. Create the Repository Interface

```dart
// lib/src/auth/datasource/repo/auth_repo.dart
import '../models/requests/login_req.dart';
import '../models/response/login_response.dart';

abstract interface class AuthRepo {
  Future<LoginResponse> adminLogin(LoginReq _);
}
```

### 3. Implement the Repository

```dart
// lib/src/auth/datasource/repo/auth_repo_impl.dart

import 'package:layer_kit_example/config/data/dio/dio_client.dart';
import 'package:layer_kit_example/src/auth/datasource/models/requests/login_req.dart';
import 'package:layer_kit_example/src/auth/datasource/models/response/login_response.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo.dart';

import '../../../../core/callbacks/callbacks.dart';
import '../../../../core/constants/api_constants.dart';


class AuthRepoImpl implements AuthRepo {
  final DioClient _dioClient;

  AuthRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<LoginResponse> adminLogin(LoginReq req) async {
    return repoCallback<LoginResponse>(
      name: "adminLogin",
      callback: () async {
        final res = await _dioClient.post(Apis.adminLogin, data: req.toJson());
        return LoginResponse.fromJson(res.data ?? {});
      },
    );
  }
}

/// CHANGE toJson TO toFormData WHERE YOU PASS IMAGE OF FILE (AS MULTIPART FILE)
/// FOR THAT YOU HAVE TO CREATE toFormData() METHOD IN YOUR REQUEST CLASS
/// toFormData() METHOD CONVERT NORMAL FILE IMAGE TO MULTIPART FILE
/// HERE IS DEMO :
/// --> final res = await _dioClient.post(Apis.adminLogin, data: req.toFormData(), contentType: CType.formData);
///
```

### 4. Create the ViewModel/Provider (Or any other state management technique)

```dart
// lib/src/auth/providers/auth_provider.dart
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/src/auth/datasource/models/requests/login_req.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo.dart';
import 'package:layer_kit_example/core/network/network_service.dart';
import '../../../core/callbacks/callbacks.dart';
import '../../../core/utils/common_toast.dart';

class AuthProvider extends BaseViewModel {
  final AuthRepo _authRepo;
  final NetworkService _networkService;

  AuthProvider({required AuthRepo authRepo, required NetworkService networkService})
      : _authRepo = authRepo,
        _networkService = networkService;
  
  /// LOGIN FOR ADMIN
  ///
  Future<bool> adminLogin({
    required String email,
    required String password,
    bool listen = true,
  }) async {
    setLoading();
    final isNetwork = await _networkService.isConnected;
    final isSuccess = await apiCallback(
      name: "adminLogin",
      isNetwork: isNetwork,
      doWhenOnline: () async {
        final req = LoginReq(email: email, password: password);
        final res = await _authRepo.adminLogin(req);
        showSnackbar(res.message);
        setLoaded();
        return res.status;
      },
      errorListener: (e) {
        setError(e.toString());
      },
    );
    if (listen) notifyListeners();
    return isSuccess;
  }
}

```

### 5. Create the UI Screen

```dart
// lib/src/auth/screens/login_screen.dart
import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:layer_kit_example/core/callbacks/callbacks.dart';
import 'package:layer_kit_example/core/common/widgets/custom_elevated_button.dart';
import 'package:layer_kit_example/core/network/network_checker_widget.dart';
import 'package:layer_kit_example/src/main_screen.dart';

import '../../../config/routes/routes.dart';

class LoginScreen extends StatelessWidget with BaseRoute {
  const LoginScreen({super.key});

  @override
  Widget get screen => this;

  @override
  AppRoutes get routeName => Routes.login;

  @override
  TransitionType get transitionType => TransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        devlog("pop invoked in login page");
      },
      child: NetworkCheckerWidget(
        child: Scaffold(
          appBar: AppBar(
            title: Txt.appbar("loginScreen".tr(), color: context.colors.primary),
          ),
          body: SafeArea(
            child: Center(
              child: CustomElevatedButton(
                child: Txt.regular14("loginWithoutEmailPassword".tr(), color: context.colors.WHITE),
                onTap: () {
                  safeRun(name: "login without email password", tryBlock: () {
                    context.pushReplacementNamed(MainScreen(initialIndex: 0));
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 6. Register Dependencies

Using a dependency injection framework like `get_it`:

```dart
// lib/di_container.main.dart
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
      ..registerLazySingleton<NetworkService>(() => NetworkService()..startConnectionStreaming());

    /// REPOS
    ///
    sl
      ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dioClient: sl()))
      ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(dioClient: sl()));

    /// PROVIDERS
    ///
    sl
      ..registerFactory<AuthProvider>(() => AuthProvider(authRepo: sl(), networkService: sl()))
      ..registerFactory<DemoProvider>(() => DemoProvider(authRepo: sl(), networkService: sl()));
  }

  static List<SingleChildWidget> get changeNotifierProviders => [
    StreamProvider(create: (_) => sl<NetworkService>().controller.stream, initialData: NetworkStatus.offline),
    ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => sl<DemoProvider>()),
  ];
}

extension GetProvidersExtension on BuildContext {
  AuthProvider get authProvider => this.read<AuthProvider>();
  DemoProvider get demoProvider => this.read<DemoProvider>();
}

```

### 7. Setup DI in Main App

```dart
// lib/main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// FIREBASE SETUP
  ///
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await _setupFirebaseCrashlytics();
  ///
  /// /////////////

  await Di.init();


  runApp(MultiProvider(
    providers: Di.changeNotifierProviders,
    child: MyApp(),
  ));
}
```

## Using LayerKit Utilities

LayerKit provides various utilities to make development easier:

### Logging

```dart
import 'package:layer_kit/layer_kit.dart';

void myFunction() {
  devlog('This is a debug message');
  devlogError('This is an error message');
}
```

### UI Decorations

```dart
Container(
  decoration: boxDecorationWithRoundedCorners(
    backgroundColor: Colors.white,
    borderRadius: radius(12),
    boxShadow: defaultBoxShadow(),
  ),
  child: Text('Styled Container'),
)
```

### Extensions

```dart
// Time formatting
final duration = 125;
print(duration.toMMSS); // "02 : 05"

// String casing
final text = "hello world";
print(text.toTitleCase); // "Hello World"
```

## Best Practices

1. **Feature Isolation**: Each feature should be self-contained in its own directory
2. **Dependency Injection**: Use dependency injection for loose coupling
3. **Error Handling**: Consistently use the Failure classes for domain-level errors
4. **State Management**: Use the BaseViewModel for consistent state management
5. **Testing**: Write tests for each layer, especially Use Cases and ViewModels

## Next Steps

- Explore the [LayerKit Architecture document](ARCHITECTURE.md) for more details on the architectural patterns
- Check out the [API Reference](API_REFERENCE.md) for detailed API documentation
- Refer to the example app in the repository for more complex usage patterns

---

With this guide, you should be able to get started with LayerKit and leverage its architecture to build maintainable Flutter applications. If you have any questions or need further assistance, please refer to the documentation or reach out to the maintainers.