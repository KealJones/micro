import 'dart:html';
import 'dart:js';

import './micro_event.dart';

export './micro_event.dart';

dispatch(MicroSdkEvent event, {target}) {
  window.console.log(event);
  (target ?? window).dispatchEvent(event.jsEvent);
}

listen(MicroSdkEvent event, Function handler, {target}) {
  (target ?? window).addEventListener(event.type, allowInterop((_event) => handler(event.from(_event))));
}

ignore(MicroSdkEvent event, Function handler, {target}) {
  (target ?? window).removeEventListener(event.type, allowInterop((_event) => handler(event.from(_event))));
}
