@JS()
library shell_events.init;

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';

createJsCustomEvent(String type, { Map detail = const {}, bool bubbles = true, bool cancelable = true, bool composed = true }) {
    var options = _CustomEventInit(
      detail: jsify(detail),
      bubbles: bubbles,
      cancelable: cancelable,
      composed: composed
    );
    return _JsCustomEvent(type, options);
}

@JS('CustomEvent')
class _JsCustomEvent implements CustomEvent, Event {
  external get detail;
  external set detail(v);

  external get matchingTarget;
  external set matchingTarget(v);

  external get path;
  external set path(v);

  external get bubbles;
  external set bubbles(v);

  external get cancelable;
  external set cancelable(v);

  external get composed;
  external set composed(v);

  external get currentTarget;
  external set currentTarget(v);


  external get defaultPrevented;
  external set defaultPrevented(v);

  external get eventPhase;
  external set eventPhase(v);

  external get isTrusted;
  external set isTrusted(v);

  external get target;
  external set target(v);

  external get type;
  external set type(v);

  external get timeStamp;
  external set timeStamp(v);

  external preventDefault();
  external stopImmediatePropagation();
  external composedPath();
  external stopPropagation();

  external _JsCustomEvent(String type, _CustomEventInit options);
}

@JS()
@anonymous
class _CustomEventInit {
  external factory _CustomEventInit({
    dynamic detail,
    bool bubbles,
    bool cancelable,
    bool composed,
  });
}

class MicroSdkEvent implements Event {
  MicroSdkEvent({String via = '', String type, Map<dynamic,dynamic> detail = const {}}) {
    Map<dynamic, dynamic> details = {
      'via': '$via',
      ...(detail ?? {})
    };
    this.jsEvent = createJsCustomEvent('$type', detail: details);
  }

  MicroSdkEvent from(dynamic event) {
    this.jsEvent = event;
    return this;
  }

  CustomEvent jsEvent;

  get detail => jsEvent.detail ?? {};

  String get via => jsEvent.detail['via'];

  /**
   * A pointer to the element whose CSS selector matched within which an event
   * was fired. If this Event was not associated with any Event delegation,
   * accessing this value will throw an [UnsupportedError].
   */
  Element get matchingTarget => jsEvent.matchingTarget;

  List<EventTarget> get path => jsEvent.composedPath != null ? composedPath() : [];

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
