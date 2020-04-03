import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

import 'ss_experience_app.dart';
import 'ss_experience_sidebar.dart';

class SSExperience {
  SSExperience(ShadowRoot root) {
    setClientConfiguration();
    MicroSdk.setModule('Spreadsheets');
    react.render((SSExperienceApp()..addProps(root.host.attributes))(), root);
  }

  SSExperience.sidebar(ShadowRoot root) {
    setClientConfiguration();
    MicroSdk.setModule('Spreadsheets');
    react.render((SSExperienceSidebar()..addProps(root.host.attributes))(), root);
  }
}
