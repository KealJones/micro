import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;

import 'docs_experience_app.dart';


class DocsExperience {
  final ShadowRoot root;

  DocsExperience(this.root) {
    setClientConfiguration();

    react.render(DocsExperienceApp()(), root);
  }
}
