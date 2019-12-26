import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;

import 'ss_experience_app.dart';

class SSExperience {
  final ShadowRoot root;

  SSExperience(this.root) {
    setClientConfiguration();

    react.render(SSExperienceApp()(), root);
  }
}
