@JS()
library shell_events.init;

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';

createJsCustomEvent(String type, { Map detail, bool bubbles: true, bool cancelable: true, bool composed: true }) {
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
  external get detail;
  external set detail(v);
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

class MicroSdkEvent implements CustomEvent, Event {
  CustomEvent jsEvent;

  get detail => jsEvent.detail;

  MicroSdkEvent from(event) {
    this.jsEvent = event;
    return this;
  }

  /**
   * A pointer to the element whose CSS selector matched within which an event
   * was fired. If this Event was not associated with any Event delegation,
   * accessing this value will throw an [UnsupportedError].
   */
  Element get matchingTarget => jsEvent.matchingTarget;

  List<EventTarget> get path => jsEvent.composedPath != null ? composedPath() : [];

  MicroSdkEvent({type, module, detail = const {}}) {
    this.jsEvent = createJsCustomEvent(eventType(module, type), detail: detail);
  }

  @override
  bool get bubbles => jsEvent.bubbles;

  @override
  bool get cancelable => jsEvent.cancelable;

  @override
  bool get composed => jsEvent.composed;

  @override
  List<EventTarget> composedPath() => jsEvent.composedPath();

  @override
  EventTarget get currentTarget => jsEvent.currentTarget;

  @override
  bool get defaultPrevented => jsEvent.defaultPrevented;

  @override
  int get eventPhase => jsEvent.eventPhase;

  @override
  bool get isTrusted => jsEvent.isTrusted;

  @override
  void preventDefault() => jsEvent.preventDefault();

  @override
  void stopImmediatePropagation() => jsEvent.stopImmediatePropagation();

  @override
  void stopPropagation() => jsEvent.stopPropagation();

  @override
  EventTarget get target => jsEvent.target;

  @override
  num get timeStamp => jsEvent.timeStamp;

  @override
  String get type => jsEvent.type;
}

eventType(module, type) => (module != null ? module + ':' : '') + type;
