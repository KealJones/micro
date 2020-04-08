import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;
import 'docs_experience_app.dart';


class DocsExperience {
  DocsExperience(ShadowRoot root) {
    setClientConfiguration();
    react.render((DocsExperienceApp()..addProps(root.host.attributes))(), root);
  }
}
