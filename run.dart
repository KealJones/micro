import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

import 'dart:math';

main(args) async {
  List<Process> backgroundProcesses = [];
  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print("exiting");
    backgroundProcesses.forEach((process){
      process.kill(ProcessSignal.sigkill);
    });
    exit(0);
  });
  var dir = new Directory('example');
  List contents = dir.listSync();
  for (var fileOrDir in contents) {
    if (fileOrDir is Directory) {
      if (fileOrDir.path.contains('_experience')) {
        backgroundProcesses.add(await startExperienceBuildWatcher(fileOrDir.path));
      }
    }
  }
  // Start Static Handler
  print('Starting fake CDN server');
  var handler = createStaticHandler('example/cdn', listDirectories: true, serveFilesOutsidePath: true);
  io.serve(handler, 'localhost', 9000);
  await runPubGet('example/shell');
  await Process.start('webdev', ['serve', '-r', '--', '--delete-conflicting-outputs'], workingDirectory: 'example/shell').then((Process process) {
    process.stdout
        .transform(utf8.decoder)
        .listen((data) { print(data); });
  }).catchError((e){
    print(e);
  });
}

Future<Process> runPubGet(String path) async {
  await Process.start('pub', ['get'], workingDirectory: path).then((Process process) {
    process.stdout
        .transform(utf8.decoder)
        .listen((data) { print(data); });
  }).catchError((e){
    print(e);
  });
}

Future<Process> startExperienceBuildWatcher(String experiencePath) async {
  var experienceName = experiencePath.replaceAll('example/', '');
  print(experiencePath);
  print('Running pub get for $experienceName');
  await runPubGet(experiencePath);
  print('Running build_runner watch for $experienceName');
  return Process.start('pub', ['run', 'build_runner', 'watch', '-o', '../cdn/${experienceName.replaceAll('_', '-')}/latest/', '-r'], workingDirectory: experiencePath);
}
