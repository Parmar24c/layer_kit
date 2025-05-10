//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:args/args.dart';
import 'package:layer_kit/generator/feature_generator.dart';
import 'package:layer_kit/generator/project_generator.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('feature', abbr: 'f', help: 'Generate a feature with name')
    ..addFlag('project',
        abbr: 'p', help: 'Generate full project structure', defaultsTo: false)
    ..addFlag('help',
        abbr: 'h', help: 'Display this help information', negatable: false);

  final argResults = parser.parse(arguments);

  if (argResults['help'] == true) {
    _printHelp(parser);
    return;
  }

  if (argResults['project']) {
    print('🛠 Generating full project...');
    final generator = ProjectGenerator();
    final res = await generator.generateFullProject();
    if (res) print('✅  Project generated successfully!');
    return;
  } else if (argResults['feature'] != null) {
    final featureName = argResults['feature']!;
    print('✨  Generating feature: $featureName');
    final generator = FeatureGenerator(featureName);
    generator.generate();
    return;
  } else {
    print('❗ Please specify an option.\n');
    _printHelp(parser);
  }
}

void _printHelp(ArgParser parser) {
  print('''
📦 Layer Kit - Clean Architecture + MVVM Project Generator

Usage:
  dart run layer_kit --project       Generate full project structure
  dart run layer_kit --feature name  Generate a new feature
  dart run layer_kit --help          Show help

Options:
${parser.usage}
''');
}
