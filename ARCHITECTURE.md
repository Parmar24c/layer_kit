# LayerKit Architecture

LayerKit is designed around a hybrid architecture that combines the strengths of MVVM (Model-View-ViewModel) pattern with Clean Architecture principles. This document explains the core architectural concepts, components, and how they interact.

## Core Architectural Principles

### MVVM Pattern

The Model-View-ViewModel pattern separates UI logic from business logic and data handling:

- **View** - Flutter UI components that render the interface and handle user interactions
- **ViewModel** - Manages UI state, processes user actions, and communicates with the domain layer
- **Model** - Represents the data structure and business logic

### Clean Architecture Layers

LayerKit implements Clean Architecture with distinct layers:

1. **Presentation Layer** (UI)
    - Views (Flutter Widgets, Screens)
    - ViewModels/Provider (State Management Technique)

2. **Domain Layer**
    - Domain Models (Body Models in Data Sources)
    - Repository Interfaces

3. **Data Layer** (Data Access)
    - Repository Implementations
    - Data Sources (Requests and Response Models)

## Component Details

### Views

Views are implemented as Flutter Widgets (Screens) that:
- Render the user interface
- Handle user interactions
- Observe and react to ViewModel state changes
- Never contain business logic

Example structure:
```
feature/
└── screens/
    ├── feature_screen.dart           # Main screen
    └── widgets/                      # Feature-specific widgets
        └── feature_item_widget.dart
```

### ViewModels

ViewModels extend `BaseViewModel` and:
- Hold and manage UI state through the `ViewState` enum
- Execute business logic by delegating to Use Cases
- Transform domain models into view models if needed
- Provide methods for UI interactions

Key features of `BaseViewModel`:
- State management with `ViewState` (initial, loading, loaded, error)
- Error handling with `errorMessage`
- State update methods: `setLoading()`, `setLoaded()`, `setError()`

Example:
```dart
class FeatureProvider extends BaseViewModel {
   final FeatureRepo _featureRepo;
   final NetworkService _networkService;

   FeatureProvider({required FeatureRepo featureRepo, required NetworkService networkService})
           : _featureRepo = featureRepo,
              _networkService = networkService;
   
   Future<bool> getData({
      required String data1,
      required String data2,
      bool listen = true,
   }) async {
      setLoading();
      final isNetwork = await _networkService.isConnected;
      final isSuccess = await apiCallback(
         name: "getData",
         isNetwork: isNetwork,
         doWhenOnline: () async {
            final req = FeatureReq(data1: data1, data2: data2);
            final res = await _featureRepo.getData(req);
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

### Repositories

Repositories:
- Abstract data sources from the rest of the application
- Define interfaces in the domain layer
- Have implementations in the data layer
- Handle data mapping between domain and data models
- Apply error handling and potentially caching logic

Example:
```dart
// Interface
abstract interface class FeatureRepo {
   Future<FeatureResponse> getData(FeatureReq req);
}

// Implementation
class FeatureRepoImpl implements FeatureRepo {
   final DioClient _dioClient;

   FeatureRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

   @override
   Future<FeatureResponse> getData(FeatureReq req) async {
      return await repoCallback<FeatureResponse>(
         name: "getData",
         callback: () async {
            final res = await _dioClient.post(Apis.getData, data: req.toJson());
            return FeatureResponse.fromJson(res.data ?? {});
         },
      );
   }
}
```

### Data Sources

Data Sources:
- Responsible for data access from a specific source
- Return data models/DTOs
- It contains Request Models and Response Models

Example:
```dart
/// Request Model
class FeatureReq {
   final String data1;
   final String data2;

   FeatureReq({required this.data1, required this.data2});

   /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
   Map<String, dynamic> toJson() => {
      'data1': data1,
      'data2': data2,
   };
}

/// Response Model
class FeatureResponse {
   final bool status;
   final String message;
   final List<dynamic>? data;

   FeatureResponse({required this.status, required this.message, required this.data});

   factory FeatureResponse.fromJson(Map<String, dynamic>? json) => FeatureResponse(
      status: json?['status'] ?? false,
      message: json?['message'] ?? "Something went wrong.!",
      data: json?['data'],
   );
}

```

## Error Handling

LayerKit implements a consistent error handling strategy across layers:

1. **Exceptions** - Thrown by data sources when errors occur
    - `ServerException` - Remote data source errors
    - `CacheException` - Local storage errors
    - `NetworkException` - Network connectivity issues

2. **Failures** - Domain-level errors used by repositories and above
    - `ServerFailure` - Server-related errors
    - `CacheFailure` - Cache-related errors
    - `NetworkFailure` - Network-related errors

3. **ViewModel Error State** - UI-facing error representation
    - `ViewState.error` - Error state in the UI
    - `errorMessage` - User-friendly error message

## Dependency Injection

LayerKit is designed to work with dependency injection, typically with get_it or Provider:

```dart
class Di {
  // ... code ...
   setupDependencies();
  // ... code ...

   void setupDependencies() {
      // Repositories
      sl.registerLazySingleton<FeatureRepo>(
                 () => FeatureRepoImpl(dioClient: sl()),
      );
      // ViewModels
      sl.registerFactory(() => FeatureProvider(featureRepo: sl(),  networkService: sl()));
   }
}
```

## Feature Generation

LayerKit's feature generator creates all necessary files following this architecture:

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

## Navigation Flow

1. Routes are defined in a dedicated routes file
2. Each feature has its own route constant
3. Navigation is handled via a routing library for type-safe navigation

## Configuration System

LayerKit uses a centralized configuration system through `KitConfig` that allows customizing:
- Environment settings (development/production)
- UI defaults (text sizes, font families)
- Decoration parameters (radius, elevations)
- Logging behavior

## Flow of Control

A typical flow through the layers:

1. User interacts with a Widget  
2. Widget calls a method on its ViewModel
3. ViewModel updates state to loading
4. ViewModel calls Repository method
6. Repository calls DataSource
7. Data flows back up through the layers
8. ViewModel updates state to loaded
9. View reflects the new state

---

This architecture provides clear separation of concerns, testability, and maintainability while keeping the development workflow efficient and consistent.