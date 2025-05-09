//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

class FeatureGenerator {
  final String featureName;
  final ReCase _feature;
  final ReCase _existingName = ReCase('feature');

  FeatureGenerator(this.featureName) : _feature = ReCase(featureName);

  void generate() {
    final base = 'lib/src/${_feature.snakeCase}';

    // Check if feature already exists
    final featureDir = Directory(base);
    if (featureDir.existsSync()) {
      stdout.write('⚠️ Feature "${_feature.snakeCase}" already exists. Do you want to override it? (y/n): ');
      final response = stdin.readLineSync()?.toLowerCase() ?? 'n';
      if (response != 'y') {
        print('❌ Feature generation cancelled.');
        return;
      }
      print('🔄 Overriding existing feature...');
    }

    // Start from the script file path
    final currentPath = Directory.current.path;

    // Try walking up until we find the correct template path
    String? foundPath;
    Directory dir = Directory(currentPath);
    while (dir.parent.path != dir.path) {
      final maybeTemplate = Directory(path.join(dir.path, 'proj', 'lib'));
      if (maybeTemplate.existsSync()) {
        foundPath = maybeTemplate.path;
        break;
      }
      dir = dir.parent;
    }

    if (foundPath == null) {
      print('❌ Could not locate proj/lib folder in parent directories.');
      return;
    }

    final templateLib = foundPath;

    final templateDir = Directory(path.join(templateLib,"src", "feature"));

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
    _updateRoutesFile(path.join(Directory.current.path, 'lib/config/routes/routes.dart'));

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
    final newRoute = '${indent}static const ${_feature.camelCase} = Routes._("${_feature.camelCase}");';

    // Insert the new route after the last route
    final updatedContent = content.substring(0, lastMatch.end) +
        '\n$newRoute' +
        content.substring(lastMatch.end);

    routesFile.writeAsStringSync(updatedContent);
    print('🔄 Updated routes file with new route: ${_feature.camelCase}');
  }
}