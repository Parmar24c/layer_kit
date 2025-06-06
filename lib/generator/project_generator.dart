//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as path;

class ProjectGenerator {

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

  Future<bool> generateFullProject() async {

    final foundPath = await findProjPath();


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
