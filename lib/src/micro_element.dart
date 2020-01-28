@JS()
library micro_sdk.micro_element;

import 'dart:html';

import 'package:js/js.dart';

@JS('Function')
external JSFunction(String arg1, String arg2, String functionBody);

Function(String, Function(ShadowRoot)) _defineCustomElement = JSFunction('name', 'construct', '''
  customElements.define(name, class extends HTMLElement {
    constructor() {
      super();
      const shadowRoot = this.attachShadow({mode: 'open'});
      construct(shadowRoot);
    }
  });
''');

MicroElement defineMicroElement(String tag, MicroElementConstructor elementConstructor) {
  return MicroElement(tag: tag, constructor: elementConstructor);
}

typedef void MicroElementConstructor(ShadowRoot shadowRoot);

class MicroElement {
  final String tag;
  final String name;
  Node root;

  MicroElement({this.tag, this.name, this.root, MicroElementConstructor constructor}){
    _defineCustomElement(tag, allowInterop(constructor));
  }
}
