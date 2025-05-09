# LayerKit CLI Commands

LayerKit comes with a powerful CLI tool that helps you scaffold projects and features quickly. This document covers all available commands and their options.

## Command Overview

| Command | Description |
|---------|-------------|
| `dart run layer_kit --project` | Generate a complete project structure |
| `dart run layer_kit --feature <name>` | Generate a new feature |

## Project Generation

The project generator creates a complete LayerKit project structure with all necessary files and configurations.

### Usage

```bash
dart run layer_kit --project
```

### What It Creates

Running the project generator will create the following structure:

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

### Notes

- If the `lib` directory already exists, it will be overwritten (after confirmation)
- The project generator will also copy the `pubspec.yaml` file from the template

## Feature Generation

The feature generator creates a new feature with all necessary files following the MVVM + Clean Architecture pattern.

### Usage

```bash
dart run layer_kit --feature <feature_name>
```

Example:
```bash
dart run layer_kit --feature auth
```

### What It Creates

For a feature named "auth", it will create:

```
lib/src/auth/
├── datasource/
│   ├── models/
│   │   └── auth_model.dart           # Domain models
│   ├── requests/
│   │   └── auth_req.dart             # API request DTOs
│   ├── response/
│   │   └── auth_response.dart        # API response DTOs
│   └── repo/
│       ├── auth_repo.dart            # Repository interface
│       └── auth_repo_impl.dart       # Repository implementation
├── providers/
│   └── auth_provider.dart            # Provider/ViewModel
└── screens/
    └── auth_screen.dart              # UI screen
```

The command will also automatically:
- Update the routes file to include the new feature
- Generate appropriate model classes
- Set up the repository pattern
- Create a basic screen and provider

### Template Customization

The feature generator uses templates from the `proj/lib/src/feature` directory. These templates are included in the Layer