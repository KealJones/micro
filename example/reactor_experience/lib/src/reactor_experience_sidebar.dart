import 'dart:html';

import 'package:reactor/reactor.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:shared_events/shared_events.dart';

part 'reactor_experience_sidebar.reactor.g.dart';

Factory<Props> ReactorExperienceSidebar = _ReactorExperienceSidebar;


class ReactorExperienceSidebarStateInterface {
  int counter;
}

class ReactorExperienceSidebarState extends State implements ReactorExperienceSidebarStateInterface {}


@ReactorComponent()
class ReactorExperienceSidebarComponent extends Component<Props, ReactorExperienceSidebarState>  {
  InputElement _postMessageInput;

  get initialState => (ReactorExperienceSidebarState()
    ..counter = 0
  );

  render() {
    return Dom.div()(
      (Dom.h4()..style = {'margin': 0})('Reactor Sidebar!'),
      Dom.p()('Counter: ' + state.counter.toString()),
      Dom.div()(
        (Dom.button()
          ..onClick = (event) => setState(ReactorExperienceSidebarState()..counter = ++state.counter)
        )('Increment'),
        (Dom.button()
          ..onClick = (event) => setState(ReactorExperienceSidebarState()..counter = --state.counter)
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
          ..ref = (ref) { _postMessageInput = ref; }
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
