@JS()
library shell_events.init;

import 'dart:js_util';

import 'package:js/js.dart';

createCustomEvent(String type, { Map detail, bool bubbles: true, bool cancelable: true, bool composed: true }) {
  Map details = detail ?? {};
  var options = CustomEventInit(
    detail: jsify(details),
    bubbles: bubbles,
    cancelable: cancelable,
    composed: composed
  );
  return JsCustomEvent(type, options);
}

@JS('CustomEvent')
class JsCustomEvent {
  external JsCustomEvent(String type, CustomEventInit options);
}

@JS()
@anonymous
class CustomEventInit {
  external factory CustomEventInit({
    dynamic detail,
    bool bubbles,
    bool cancelable,
    bool composed,
  });
}
