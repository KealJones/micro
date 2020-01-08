import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:react/react_client/react_interop.dart';

import 'package:shared_events/shared_events.dart';

import './shell_experience.dart';
import './shell_experience_manager.dart';

part 'shell_app.over_react.g.dart';

@Factory()
UiFactory<ShellAppProps> ShellApp = _$ShellApp;

@Props()
class _$ShellAppProps extends UiProps {
  bool showMessages;

  List messages;
}

@State()
class _$ShellAppState extends UiState {
  bool showMessages;

  List messages;
}

@Component2()
class ShellAppComponent extends UiStatefulComponent2<ShellAppProps, ShellAppState>  {
  ShellExperienceManager _shellExperienceManager;
  DivElement _messagesBox;

  @override
  Map get defaultProps => (newProps()
    ..showMessages = true
    ..messages = []
  );

  @override
  Map get initialState => (newState()
    ..showMessages = props.showMessages
    ..messages = props.messages
  );

  @override
  void componentDidMount() {
    _shellExperienceManager = new ShellExperienceManager();
    _shellExperienceManager.initializeEventHandlers();

    MicroSdk.listen(ShellPostMessageEvent(), _handlePostMessage);
    MicroSdk.listen(ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _shellExperienceManager.disposeEventHandlers();

    MicroSdk.ignore(ShellPostMessageEvent(), _handlePostMessage);
    MicroSdk.ignore(ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentDidUpdate(prevProps, prevState, [snapshot]) {
    if(state.showMessages) {
      var _messagesBoxNode = findDomNode(_messagesBox);
      _messagesBoxNode.scrollTo(0, _messagesBoxNode.scrollHeight);
    }
  }

  ReactElement _regionOutput() {
    return React.createElement('app-region', jsify({}));
  }

  render() {
    return (Dom.div()..className = 'shell')(
      Dom.h2()('Using over_react 3.1.0-wip'),
      _renderShellControls(),
      _renderMessagesBox(),
      _regionOutput(),
    );
  }

  void _handlePostMessage(ShellPostMessageEvent event) {
    var messages = new List.from(state.messages);
    var postBy = (event.target == findDomNode(this)) ? '' : 'Message posted from ${event.target}:';

    messages.add('${new DateTime.now().toString()} - ${postBy} ${event.message}');
    setState(newState()..messages = messages);
  }

  void _handleToggleMessages(event) {
    var toggledBy = (event.target is ButtonElement) ? 'shell' : event.target;
    MicroSdk.dispatch(ShellPostMessageEvent(
      'Message panel ${state.showMessages ? 'disabled' : 'enabled'} by ${toggledBy}'
    ));

    setState(newState()..showMessages = !state.showMessages);
  }

  List<ReactElement> _renderMessages() {
    List<ReactElement> messages = [];

    for (var i = 0; i < state.messages.length; i++) {
      messages.add(Dom.em()(Dom.p()(state.messages[i])));
    }

    return messages;
  }

  ReactElement _renderMessagesBox() {
    var classes = new ClassNameBuilder()
      ..add('shell__messages')
      ..add('shell__messages--hidden', !state.showMessages);

    return (Dom.div()
      ..className = classes.toClassName()
      ..ref = (ref) {
        _messagesBox = ref;
      }
    )(
      Dom.h4()('Messages'),
      _renderMessages()
    );
  }

  ReactElement _renderShellControls() {
    return (Dom.div()..className = 'shell__controls')(
      (Dom.button()
        ..onClick = (event) {
          MicroSdk.dispatch(ShellExperienceRequestedEvent(ShellExperience.DOCS.prefix));
        }
      )('New Docs Experience'),
      (Dom.button()..onClick = (event) {
        MicroSdk.dispatch(ShellExperienceRequestedEvent(ShellExperience.SPREADSHEETS.prefix));
      })('New Spreadsheets Experience'),
      (Dom.button()
        ..onClick = (event) {
          MicroSdk.dispatch(ShellToggleMessagesEvent());
        }
      )('Toggle Messages')
    );
  }
}

class AppRegion extends MicroSdk.MicroRegion {
  Element node;

  AppRegion(ShadowRoot shadowRoot):super(name:'AppRegion') {
    shadowRoot.append(node);
  }
}
