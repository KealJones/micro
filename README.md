# Dart Microfrontend Example app

This repo brings multiple other repos into a single easy to run local microfrontends experience.

## Getting Started
From the root of this repo run `pub get` then to run the entire example run `dart run.dart`.

### What does `run.dart` do?
1. Runs watchers that build js bundles of each experience and outputs them into the `example/cdn` directory
2. Serves a shelf static file server on the `example/cdn` directory (this would minic a real cdn)
3. Finally serves `example/shell` using `webdev serve` in release mode
