@JS()
library micro_sdk.micro_element;

import 'dart:html';

import 'package:js/js.dart';

@JS('Function')
external JSFunction(String arg1, String arg2, String functionBody);

Function(String, Function(ShadowRoot)) createMicroElement = JSFunction('name', 'construct', '''
  customElements.define(name, class extends HTMLElement {
    constructor() {
      super();
      const shadowRoot = this.attachShadow({mode: 'open'});
      construct(shadowRoot);
    }
  });
''');

defineMicroElement(String elementName, Function(ShadowRoot shadowRoot) appFactory) {
  return createMicroElement(elementName, allowInterop(appFactory));
}
