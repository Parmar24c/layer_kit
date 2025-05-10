//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

class FeatureGenerator {
  final String featureName;
  final ReCase _feature;
  final ReCase _existingName = ReCase('feature');

  FeatureGenerator(this.featureName) : _feature = ReCase(featureName);


  Future<String?> findProjPath() async {
    // 1. Try resolving using package URI
    try {
      final uri = Uri.parse('package:layer_kit/proj/');
      final resolved = await Isolate.resolvePackageUri(uri);

      if (resolved != null) {
        final projDir = path.normalize(resolved.toFilePath());
        if (Directory(projDir).existsSync()) {
          return projDir;
        }
      }
    } catch (e) {
      print('Package resolution failed: $e');
      // Fall back if resolve fails
    }

    // 2. Check in the layer_kit package location
    try {
      final uri = Uri.parse('package:layer_kit/layer_kit.dart');
      final resolved = await Isolate.resolvePackageUri(uri);

      if (resolved != null) {
        // Navigate up from the resolved package file to find the proj directory
        final packageDir = path.dirname(path.dirname(resolved.toFilePath()));
        final projPath = path.join(packageDir, 'proj');

        if (Directory(projPath).existsSync()) {
          return projPath;
        }
      }
    } catch (e) {
      print('Package base resolution failed: $e');
    }

    // 3. Search in parent directories starting from current working directory
    String? foundPath;
    Directory dir = Directory.current;

    // Look for 'proj' in the current directory first
    final directProj = path.join(dir.path, 'proj');
    if (Directory(directProj).existsSync()) {
      return directProj;
    }

    // Then check each parent until root
    while (dir.parent.path != dir.path) {
      // Try to find proj directory
      final projCandidate = path.join(dir.path, 'proj');
      if (Directory(projCandidate).existsSync()) {
        foundPath = projCandidate;
        break;
      }

      // Also check in a potential 'packages/layer_kit' subdirectory
      final packageProj = path.join(dir.path, 'packages', 'layer_kit', 'proj');
      if (Directory(packageProj).existsSync()) {
        foundPath = packageProj;
        break;
      }

      dir = dir.parent;
    }

    return foundPath;
  }


  void generate() async {
    final base = 'lib/src/${_feature.snakeCase}';

    // Check if feature already exists
    final featureDir = Directory(base);
    if (featureDir.existsSync()) {
      stdout.write(
          '⚠️ Feature "${_feature.snakeCase}" already exists. Do you want to override it? (y/n): ');
      final response = stdin.readLineSync()?.toLowerCase() ?? 'n';
      if (response != 'y') {
        print('❌ Feature generation cancelled.');
        return;
      }
      print('🔄 Overriding existing feature...');
    }

    // // Start from the script file path
    // final currentPath = Directory.current.path;
    //
    // // Try walking up until we find the correct template path
    // String? foundPath;
    // Directory dir = Directory(currentPath);
    // while (dir.parent.path != dir.path) {
    //   final maybeTemplate = Directory(path.join(dir.path, 'proj', 'lib'));
    //   if (maybeTemplate.existsSync()) {
    //     foundPath = maybeTemplate.path;
    //     break;
    //   }
    //   dir = dir.parent;
    // }

    final foundPath = await findProjPath();

    if (foundPath == null) {
      print('❌ Could not locate proj/lib folder in parent directories.');
      return;
    }

    final templateLib = foundPath;

    final templateDir = Directory(path.join(templateLib, "lib", "src", "feature"));

    if (!templateDir.existsSync()) {
      print('❌ Template folder not found: ${templateDir.path}');
      return;
    }

    for (final entity in templateDir.listSync(recursive: true)) {
      if (entity is File) {
        final relativePath = path.relative(entity.path, from: templateDir.path);
        final updatedPath = _replaceFeatureInPath(relativePath);
        final fullTargetPath = path.join(base, updatedPath);
        _copyAndReplaceContent(entity.path, fullTargetPath);
      }
    }

    // Update routes file
    _updateRoutesFile(
        path.join(Directory.current.path, 'lib/config/routes/routes.dart'));

    print('✅  Feature "${_feature.snakeCase}" generated successfully!');
  }

  String _replaceFeatureInPath(String originalPath) {
    return originalPath
        .replaceAll(_existingName.snakeCase, _feature.snakeCase)
        .replaceAll(_existingName.camelCase, _feature.camelCase)
        .replaceAll(_existingName.pascalCase, _feature.pascalCase)
        .replaceAll(_existingName.constantCase, _feature.constantCase);
  }

  void _copyAndReplaceContent(String sourcePath, String targetPath) {
    final file = File(sourcePath);
    if (!file.existsSync()) {
      print('❌ Missing: $sourcePath');
      return;
    }

    String content = file.readAsStringSync();

    // Replace both login and auth references
    content = content
        .replaceAll(_existingName.snakeCase, _feature.snakeCase)
        .replaceAll(_existingName.camelCase, _feature.camelCase)
        .replaceAll(_existingName.pascalCase, _feature.pascalCase)
        .replaceAll(_existingName.constantCase, _feature.constantCase);

    final destFile = File(targetPath);
    destFile.createSync(recursive: true);
    destFile.writeAsStringSync(content);
    print('📄 Generated: $targetPath');
  }

  void _updateRoutesFile(String routesFilePath) {
    final routesFile = File(routesFilePath);
    if (!routesFile.existsSync()) {
      print('❌ Routes file not found: $routesFilePath');
      return;
    }

    String content = routesFile.readAsStringSync();

    // Find the last route declaration
    final routeRegex = RegExp(r'static const \w+ = Routes\._\("\w+"\);');
    final matches = routeRegex.allMatches(content).toList();

    if (matches.isEmpty) {
      print('❌ Could not parse routes file format');
      return;
    }

    final lastMatch = matches.last;
    final lastRoute = content.substring(lastMatch.start, lastMatch.end);

    // Create new route with proper indentation
    final indent = lastRoute.substring(0, lastRoute.indexOf('static'));
    final newRoute =
        '${indent}static const ${_feature.camelCase} = Routes._("${_feature.camelCase}");';

    // Insert the new route after the last route
    final updatedContent = content.substring(0, lastMatch.end) +
        '\n$newRoute' +
        content.substring(lastMatch.end);

    routesFile.writeAsStringSync(updatedContent);
    print('🔄 Updated routes file with new route: ${_feature.camelCase}');
  }
}
