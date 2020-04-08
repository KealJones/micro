import 'dart:html';
import 'dart:js';

import 'package:reactor/reactor.dart';
import 'package:shared_events/shared_events.dart';

import 'micro.dart';
part 'reactor_experience_app.reactor.g.dart';

Factory<Props> ReactorExperienceApp = _ReactorExperienceApp;

class ReactorExperienceAppStateInterface {
  int counter;
}

class ReactorExperienceAppState extends State implements ReactorExperienceAppStateInterface {}

@ReactorComponent()
class ReactorExperienceAppComponent extends Component<Props, ReactorExperienceAppState>  {
  InputElement _postMessageInput;

  get initialState => (ReactorExperienceAppState()
    ..counter = 0
  );

  render() {
    return Dom.div()(
      (Dom.h4()..style = {'margin': 0})('Reactor: Using reactor 0.1.0 no dependency on over_react'),
      Dom.p()('Counter: ' + state.counter.toString()),
      Dom.div()(
        (Dom.button()
          ..onClick = allowInterop((event) => setState(ReactorExperienceAppState()..counter = ++state.counter))
        )('Increment'),
        (Dom.button()
          ..onClick = allowInterop((event) => setState(ReactorExperienceAppState()..counter = --state.counter))
        )('Decrement')
      ),
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
        ..ref = allowInterop((ref) { _postMessageInput = ref; })
      )(),
      (Dom.button()
        ..style = {
          'margin': '0 .2rem'
        }
        ..onClick = (e) {
          micro.dispatch(ShellPostMessageEvent(_postMessageInput.value));
        }
      )('Post Message')
    );
  }
}
