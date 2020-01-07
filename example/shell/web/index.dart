import 'dart:html';

import 'package:react/react_dom.dart' as react;
import 'package:react/react_client.dart';

import 'package:shell/shell.dart' show ShellApp;

void main() {
  setClientConfiguration();
  
  react.render(ShellApp()(), document.querySelector('#shellApp'));
}