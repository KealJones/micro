import 'dart:html';
import 'dart:js';

import './micro_event.dart';

dispatch(MicroSdkEvent event, [target]) {
  window.console.log(event.e);
  window.document.dispatchEvent(event.e);
}

listen(MicroSdkEvent event, Function handler, [target]) {
  window.document.addEventListener(event.eventName, allowInterop(handler));
}

ignore(MicroSdkEvent event, Function handler, [target]) {
  window.document.removeEventListener(event.eventName, allowInterop(handler));
}