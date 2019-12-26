import 'dart:html';

import './create_custom_event.dart';

class MicroSdkEvent {
  Event e;
  String eventName;
  Map detail;

  MicroSdkEvent(this.eventName, [this.detail]) {
    this.e = createCustomEvent(eventName, detail: detail);
  }
}
