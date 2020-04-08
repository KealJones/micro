import 'dart:js';
import 'dart:html';

import './micro_event.dart';

export './micro_event.dart';

class MicroSdk {
  String moduleName;
  ShadowRoot moduleRoot;
  MicroSdk([this.moduleName = '', this.moduleRoot]);

  MicroSdkEvent createEvent(String type, [Map detail = const {}]){
    return MicroSdkEvent(type: type, detail: detail);
  }

  dispatch(MicroSdkEvent event, { bool useGlobal = false }) {
    if (event.jsEvent.detail != null) {
      event = createEvent(event.type, {...event.detail, 'via': moduleName});
    } else {
      event = createEvent(event.type, {'via': moduleName});
    }
    ((useGlobal || moduleRoot == null) ? window : moduleRoot).dispatchEvent(event.jsEvent);
  }

  listen(MicroSdkEvent event, Function handler, { bool useGlobal = false }) {
    ((useGlobal || moduleRoot == null) ? window : moduleRoot).addEventListener(event.type, allowInterop((_event) => handler(event.from(_event))));
  }

  ignore(MicroSdkEvent event, Function handler, { bool useGlobal = false }) {
    ((useGlobal || moduleRoot == null) ? window : moduleRoot).removeEventListener(event.type, allowInterop((_event) => handler(event.from(_event))));
  }
}
