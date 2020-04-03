import 'dart:html';

import 'package:reactor/reactor.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

import 'reactor_experience_app.dart';
import 'reactor_experience_sidebar.dart';

class ReactorExperience {
  ReactorExperience(ShadowRoot root) {
    MicroSdk.setModule('Reactor');
    ReactDOM.render((ReactorExperienceApp()..addAll(root.host.attributes))(), root);
  }

  ReactorExperience.sidebar(ShadowRoot root) {
    MicroSdk.setModule('Reactor');
    ReactDOM.render((ReactorExperienceSidebar()..addAll(root.host.attributes))(), root);
  }
}
