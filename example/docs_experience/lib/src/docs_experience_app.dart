import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:shared_events/shared_events.dart';

part 'docs_experience_app.over_react.g.dart';

@Factory()
UiFactory<DocsExperienceAppProps> DocsExperienceApp = _$DocsExperienceApp;

@Props()
class _$DocsExperienceAppProps extends UiProps {
}

@State()
class _$DocsExperienceAppState extends UiState {
  int counter;
}

@Component()
class DocsExperienceAppComponent extends UiStatefulComponent<DocsExperienceAppProps, DocsExperienceAppState>  {
  ButtonElement _toggleMessagesButton;

  Map getInitialState() => (newState()
    ..counter = 0
  );

  render() {
    return Dom.div()(
      (Dom.h4()..style = { 'margin': 0 })('Docs: using over_react 3.0.0'),
      Dom.p()('Counter: ${state.counter}'),
      Dom.div()(
        Dom.p()('Docs Operations'),
        (Dom.button()..onClick = (event) => setState(newState()..counter = state.counter + 1))('Increment'),
        (Dom.button()..onClick = (event) => setState(newState()..counter = state.counter - 1))('Decrement')
      ),
      Dom.div()(
        Dom.p()('Shell Operations'),
        (Dom.button()
          ..onClick = (event) {
            MicroSdk.dispatch(ShellToggleMessagesEvent());
          }
          ..ref = (ref) {
            _toggleMessagesButton = ref;
          }
        )('Toggle Shell Messages')
      )
    );
  }
}
