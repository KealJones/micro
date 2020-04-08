import 'package:micro_sdk/micro_sdk.dart';

MicroSdk micro;

MicroSdk micro_sidebar;

MicroSdk setupMicro(root) {
  micro = MicroSdk('Reactor', root);
}

MicroSdk setupMicroSidebar(root) {
  micro_sidebar = MicroSdk('ReactorSidebar', root);
}
