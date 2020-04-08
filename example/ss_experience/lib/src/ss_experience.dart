import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;

import 'ss_experience_app.dart';
import 'ss_experience_sidebar.dart';

class SSExperience {
  SSExperience(ShadowRoot root) {
    setClientConfiguration();
    react.render((SSExperienceApp()..addProps(root.host.attributes))(), root);
  }

  SSExperience.sidebar(ShadowRoot root) {
    setClientConfiguration();
    react.render((SSExperienceSidebar()..addProps(root.host.attributes))(), root);
  }
}
