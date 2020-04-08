import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

main(args) async {
  List<Process> backgroundProcesses = [];
  List<String> experiencePaths = [];
  List<Future<ProcessResult>> experiencePubGets = [runPubGet('example/shell')];

  // Capture kill signal and kill all background processes
  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print("exiting");
    backgroundProcesses.forEach((process){
      process.kill();
    });
    exit(0);
  });

  var dir = new Directory('example');
  List contents = dir.listSync();
  for (var fileOrDir in contents) {
    if (fileOrDir is Directory) {
      if (fileOrDir.path.contains('_experience')) {
        experiencePaths.add(fileOrDir.path);
        experiencePubGets.add(runPubGet(fileOrDir.path));
      }
    }
  }
  // Wait for all pub gets to finish
  await Future.wait(experiencePubGets);

  // Start the build watchers
  for(var experiencePath in experiencePaths) {
    backgroundProcesses.add(await runExperienceBuildWatcher(experiencePath));
  }

  // Start Static Handler
  runCdn();

  // Start webdev serve in release mode on the shell directory
  print('Running webdev serve for shell');
  await Process.start('webdev', ['serve', '-r', '--', '--delete-conflicting-outputs'], workingDirectory: 'example/shell').then((Process process) {
    process.stdout
        .transform(utf8.decoder)
        .listen((data) { print(data); });
  }).catchError((e){
    print(e);
  });
}

void runCdn() {
  print('Starting fake CDN server');
  var handler = createStaticHandler('example/cdn', listDirectories: true, serveFilesOutsidePath: true);
  io.serve(handler, 'localhost', 9000);
}

Future<ProcessResult> runPubGet(String path) {
  print('Running pub get for $path');
  return Process.run('pub', ['get'], workingDirectory: path, stdoutEncoding: utf8);
}

Future<Process> runExperienceBuildWatcher(String experiencePath) async {
  var experienceName = experiencePath.replaceAll('example/', '');
  print('Running build_runner watch for $experienceName');
  return Process.start('pub', ['run', 'build_runner', 'watch', '-o', '../cdn/${experienceName.replaceAll('_', '-')}/latest/', '-r'], workingDirectory: experiencePath).then((process) {
    process.stdout
        .transform(utf8.decoder)
        .listen((data) { print(data); });
        return process;
  });
}
