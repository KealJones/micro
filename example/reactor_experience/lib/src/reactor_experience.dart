import 'package:reactor/reactor.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

import 'reactor_experience_app.dart';
import 'reactor_experience_sidebar.dart';

class ReactorExperience {
  ReactorExperience(root) {
    MicroSdk.setModule('Reactor');
    ReactDOM.render(ReactorExperienceApp()(), root);
  }

  ReactorExperience.sidebar(root) {
    MicroSdk.setModule('Reactor');
    ReactDOM.render(ReactorExperienceSidebar()(), root);
  }
}
