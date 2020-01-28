import 'dart:html';

import 'package:react/react_dom.dart' as react;
import 'package:react/react_client.dart';

import 'package:micro_sdk/micro_sdk.dart';

import 'package:shell/shell.dart' show ShellApp;
import 'package:shell/src/shell_app.dart';

void main() {
  setClientConfiguration();

  react.render(ShellApp()(), document.querySelector('#shellApp'));
}
