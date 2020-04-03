import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'docs_experience_app.dart';


class DocsExperience {
  final ShadowRoot root;

  DocsExperience(this.root) {
    setClientConfiguration();
    MicroSdk.setModule('Docs');
    react.render(DocsExperienceApp()(), root);
  }
}
