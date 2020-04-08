import 'dart:html';
import 'dart:js';

import 'package:reactor/reactor.dart';

import 'micro.dart';
import 'reactor_experience_app.dart';
import 'reactor_experience_sidebar.dart';

class ReactorExperience {
  ReactorExperience(ShadowRoot root) {
    setupMicro(root);
    ReactDOM.render((ReactorExperienceApp()..addAll(root.host.attributes))(), root);
  }

  ReactorExperience.sidebar(ShadowRoot root) {
    setupMicroSidebar(root);
    ReactDOM.render((ReactorExperienceSidebar()..addAll(root.host.attributes))(), root);
  }
}
