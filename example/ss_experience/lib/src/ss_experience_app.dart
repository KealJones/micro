import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:shared_events/shared_events.dart';

import 'micro.dart';

part 'ss_experience_app.over_react.g.dart';

@Factory()
UiFactory<SSExperienceAppProps> SSExperienceApp = _$SSExperienceApp;

@Props()
class _$SSExperienceAppProps extends UiProps {
}

@State()
class _$SSExperienceAppState extends UiState {
  int counter;
}

@Component2()
class SSExperienceAppComponent extends UiStatefulComponent2<SSExperienceAppProps, SSExperienceAppState>  {
  Ref<InputElement> _postMessageInput = createRef();

  Map get initialState => (newState()
    ..counter = 0
  );

  render() {
    return Dom.div()(
      (Dom.h4()..style = {'margin': 0})('Spreadsheets: Using over_react 3.1.0 & Component2'),
      Dom.p()('Counter: ' + state.counter.toString()),
      Dom.div()(
        (Dom.button()
          ..onClick = (event) => setState(newState()..counter = ++state.counter)
        )('Increment'),
        (Dom.button()
          ..onClick = (event) => setState(newState()..counter = --state.counter)
        )('Decrement')
      ),
      (Dom.form()
        ..onSubmit = (e) {
          e.stopPropagation();
          e.preventDefault();
          micro.dispatch(ShellPostMessageEvent(_postMessageInput.current.value));
        }
      )(
        (Dom.label()
          ..htmlFor = 'shellMessage'
          ..style = {
            'display': 'block',
            'margin': '.8rem 0 .2rem 0'
          }
        )('Message'),
        (Dom.input()
          ..type = 'text'
          ..id = 'shellMessage'
          ..ref = _postMessageInput
        )(),
        (Dom.button()
          ..type = 'submit'
          ..style = {
            'margin': '0 .2rem'
          }
        )('Post Message')
      )
    );
  }
}
