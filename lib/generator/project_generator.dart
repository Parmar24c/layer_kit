//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';
import 'package:path/path.dart' as path;

class ProjectGenerator {
  bool generateFullProject() {
    // Start from the script file path
    final currentPath = Directory.current.path;

    // Try walking up until we find the correct template path
    String? foundPath;
    Directory dir = Directory(currentPath);
    while (dir.parent.path != dir.path) {
      final maybeTemplate = Directory(path.join(dir.path, 'proj', 'lib'));
      if (maybeTemplate.existsSync()) {
        foundPath = path.join(dir.path, 'proj');
        break;
      }
      dir = dir.parent;
    }

    if (foundPath == null) {
      print('❌ Could not locate proj folder in parent directories.');
      return false;
    }

    final templateLib = path.join(foundPath, 'lib');
    final targetLib = path.normalize(path.absolute('lib'));

    // Check if target lib directory exists and remove it first
    final libDir = Directory(targetLib);
    if (libDir.existsSync()) {
      try {
        libDir.deleteSync(recursive: true);
        print('🔄 Removed existing lib directory');
      } catch (e) {
        print('❌ Failed to remove existing lib directory: $e');
        return false;
      }
    }
    // Copy lib directory
    final libResult =
        copyDirectory(Directory(templateLib), Directory(targetLib));

    // Copy pubspec.yaml file
    final templatePubspec = File(path.join(foundPath, 'pubspec.yaml'));
    final targetPubspec = File(path.normalize(path.absolute('pubspec.yaml')));
    final pubspecResult = copyPubspecFile(templatePubspec, targetPubspec);

    return libResult && pubspecResult;
  }

  bool copyDirectory(Directory source, Directory destination) {
    if (!source.existsSync()) {
      print('❌ Template lib folder not found: ${source.path}');
      return false;
    }

    for (var entity in source.listSync(recursive: true)) {
      if (entity is File) {
        final relativePath = path.relative(entity.path, from: source.path);
        final newPath = path.join(destination.path, relativePath);
        final newFile = File(newPath);
        if (relativePath.startsWith("src\\feature")) continue;
        newFile.createSync(recursive: true);
        newFile.writeAsBytesSync(entity.readAsBytesSync());
        print('✅  Copied: $relativePath');
      }
    }
    return true;
  }

  bool copyPubspecFile(File source, File destination) {
    if (!source.existsSync()) {
      print('❌ Template pubspec.yaml not found: ${source.path}');
      return false;
    }

    try {
      destination.writeAsBytesSync(source.readAsBytesSync());
      print('✅  Copied: pubspec.yaml');
      return true;
    } catch (e) {
      print('❌ Failed to copy pubspec.yaml: $e');
      return false;
    }
  }
}
