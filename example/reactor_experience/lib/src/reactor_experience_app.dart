import 'dart:html';

import 'package:reactor/reactor.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:shared_events/shared_events.dart';

part 'reactor_experience_app.reactor.g.dart';

Factory<Props> ReactorExperienceApp = _ReactorExperienceApp;

class ReactorExperienceAppStateInterface {
  int counter;
}

class ReactorExperienceAppState extends State implements ReactorExperienceAppStateInterface {}


@ReactorComponent()
class ReactorExperienceAppComponent extends Component<Props, ReactorExperienceAppState>  {
  var _postMessageInput;

  get initialState => (ReactorExperienceAppState()
    ..counter = 0
  );

  render() {
    return Dom.div()(
      (Dom.h4()..style = {'margin': 0})('Reactor: Using reactor 0.1.0 no dependency on over_react'),
      Dom.p()('Counter: ' + state.counter.toString()),
      Dom.div()(
        (Dom.button()
          ..onClick = (event) => setState(ReactorExperienceAppState()..counter = ++state.counter)
        )('Increment'),
        (Dom.button()
          ..onClick = (event) => setState(ReactorExperienceAppState()..counter = --state.counter)
        )('Decrement')
      ),
      (Dom.form()
        ..onSubmit = (e) {
          e.stopPropagation();
          e.preventDefault();
          MicroSdk.dispatch(ShellPostMessageEvent(_postMessageInput.value));
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
          ..ref = (ref) => _postMessageInput = ref
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
