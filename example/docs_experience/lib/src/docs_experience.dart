import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'docs_experience_app.dart';


class DocsExperience {
  DocsExperience(ShadowRoot root) {
    setClientConfiguration();
    MicroSdk.setModule('Docs');
    react.render((DocsExperienceApp()..addProps(root.host.attributes))(), root);
  }
}
