import 'dart:async';
import 'dart:html';

class AsyncScriptLoader {
    AsyncScriptLoader(scriptSource) {
      _scriptElement = new ScriptElement()
        ..type = 'text/javascript'
        ..src = scriptSource
        ..async = true;
    }

    ScriptElement _scriptElement;

    Future loadScript() {
      var headTag = document.getElementsByTagName('head')[0];
      headTag.append(_scriptElement);

      return _scriptElement.onLoad.first;
    }
}