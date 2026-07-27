import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('create')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Print this usage information.');

  try {
    final results = parser.parse(arguments);

    if (results['help'] == true || results.command == null) {
      printUsage(parser);
      return;
    }

    final command = results.command!;
    if (command.name == 'create') {
      if (command.rest.isEmpty) {
        print('Error: Please specify the project name.');
        print('Usage: getx_boilerplate_cli create <project_name>');
        exit(1);
      }

      final projectName = command.rest.first;
      await createProject(projectName);
    } else {
      print('Unknown command: ${command.name}');
      printUsage(parser);
    }
  } catch (e) {
    print('Error: $e');
    printUsage(parser);
    exit(1);
  }
}

void printUsage(ArgParser parser) {
  print('GetX Boilerplate CLI - Starter Template Generator');
  print('\nUsage: getx_boilerplate_cli <command> [arguments]');
  print('\nGlobal options:');
  print(parser.usage);
  print('\nAvailable commands:');
  print('  create <project_name>   Scaffold a new Premium GetX Clean Architecture project.');
}

Future<void> createProject(String projectName) async {
  // Validate project name (standard Dart package naming rules)
  final nameRegExp = RegExp(r'^[a-z][a-z0-9_]*$');
  if (!nameRegExp.hasMatch(projectName)) {
    print('Error: "$projectName" is not a valid Dart package name.');
    print('Dart package names must start with a lowercase letter, and contain only lowercase letters, numbers, and underscores.');
    exit(1);
  }

  print('\n🚀 Creating new project: $projectName...');

  // Check if Git is installed
  try {
    final gitCheck = await Process.run('git', ['--version'], runInShell: true);
    if (gitCheck.exitCode != 0) {
      print('Error: Git is not available. Please install Git and try again.');
      exit(1);
    }
  } catch (_) {
    print('Error: Git is not installed or not found in system PATH.');
    exit(1);
  }

  final targetDir = Directory(p.join(Directory.current.path, projectName));
  if (targetDir.existsSync()) {
    print('Error: Directory "$projectName" already exists in the current folder.');
    exit(1);
  }

  // 1. Clone the repository
  print('📥 Cloning template repository from GitHub...');
  final cloneResult = await Process.run(
    'git',
    ['clone', 'https://github.com/parentroots/getx.git', projectName],
    runInShell: true,
  );

  if (cloneResult.exitCode != 0) {
    print('Error: Failed to clone repository.');
    print(cloneResult.stderr);
    exit(1);
  }

  // 2. Remove the .git directory
  final gitDir = Directory(p.join(targetDir.path, '.git'));
  if (gitDir.existsSync()) {
    print('🧹 Clearing git history...');
    try {
      gitDir.deleteSync(recursive: true);
    } catch (e) {
      print('Warning: Failed to delete .git directory automatically. You may need to delete it manually. Error: $e');
    }
  }

  // 3. Remove local CLI folder if cloned (to keep the user's template project completely clean)
  final cliDirInTemplate = Directory(p.join(targetDir.path, 'getx_boilerplate_cli'));
  if (cliDirInTemplate.existsSync()) {
    try {
      cliDirInTemplate.deleteSync(recursive: true);
    } catch (_) {}
  }

  // 4. Perform search & replace for "getx_template" -> projectName in files
  print('🔧 Customizing project configurations...');
  await performSearchAndReplace(targetDir, projectName);

  // 5. Run flutter pub get
  print('📦 Resolving Flutter dependencies (flutter pub get)...');
  final pubGetResult = await Process.run(
    'flutter',
    ['pub', 'get'],
    workingDirectory: targetDir.path,
    runInShell: true,
  );

  if (pubGetResult.exitCode != 0) {
    print('Warning: "flutter pub get" failed. You might need to run it manually inside the project directory.');
    print(pubGetResult.stderr);
  } else {
    print('✅ Dependencies resolved successfully!');
  }

  // Print success message
  print('\n🎉 Success! Your new project is ready at: ${targetDir.path}');
  print('\nTo get started:');
  print('  cd $projectName');
  print('  flutter run');
  print('\nHappy Coding! 🚀');
}

Future<void> performSearchAndReplace(Directory directory, String projectName) async {
  final targetName = 'getx_template';

  // Walk and replace contents
  await for (final entity in directory.list(recursive: true, followLinks: false)) {
    if (entity is File) {
      // Skip binary/non-text files commonly found in Flutter projects
      final extension = p.extension(entity.path).toLowerCase();
      if (['.png', '.jpg', '.jpeg', '.gif', '.ico', '.pdf', '.zip', '.mp4', '.ttf', '.otf', '.woff'].contains(extension)) {
        continue;
      }

      try {
        final content = await entity.readAsString();
        if (content.contains(targetName)) {
          final updatedContent = content.replaceAll(targetName, projectName);
          await entity.writeAsString(updatedContent);
        }
      } catch (_) {
        // Safe to catch and ignore encoding/read errors for binary/system files
      }
    }
  }

  // Walk again to rename files and directories containing "getx_template"
  // We list all entities, sort them by path length descending (deepest first),
  // and rename them to avoid invalid path errors when parents are renamed first.
  final entitiesToRename = <FileSystemEntity>[];
  await for (final entity in directory.list(recursive: true, followLinks: false)) {
    final baseName = p.basename(entity.path);
    if (baseName.contains(targetName)) {
      entitiesToRename.add(entity);
    }
  }

  // Sort by length descending (deepest first)
  entitiesToRename.sort((a, b) => b.path.length.compareTo(a.path.length));

  for (final entity in entitiesToRename) {
    final parentDir = p.dirname(entity.path);
    final oldName = p.basename(entity.path);
    final newName = oldName.replaceAll(targetName, projectName);
    final newPath = p.join(parentDir, newName);

    try {
      if (entity is File) {
        entity.renameSync(newPath);
      } else if (entity is Directory) {
        entity.renameSync(newPath);
      }
    } catch (e) {
      print('Warning: Failed to rename ${entity.path} to $newPath. Error: $e');
    }
  }
}
