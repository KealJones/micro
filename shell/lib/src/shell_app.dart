import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

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

    MicroSdk.listen(MicroSdk.ShellPostMessageEvent(), _handlePostMessage);
    MicroSdk.listen(MicroSdk.ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _shellExperienceManager.disposeEventHandlers();

    MicroSdk.ignore(MicroSdk.ShellPostMessageEvent(), _handlePostMessage);
    MicroSdk.ignore(MicroSdk.ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentDidUpdate(prevProps, prevState, [snapshot]) {
    if(state.showMessages) {
      var _messagesBoxNode = findDomNode(_messagesBox);
      _messagesBoxNode.scrollTo(0, _messagesBoxNode.scrollHeight);
    }
  }

  render() {
    return (Dom.div()..className = 'shell')(
      Dom.h2()('Using over_react 3.1.0-wip'),
      _renderShellControls(),
      _renderMessagesBox()
    );
  }

  void _handlePostMessage(event) {
    var messages = new List.from(state.messages);
    var postBy = (event.target == findDomNode(this)) ? '' : 'Message posted from ${event.target}:';

    messages.add('${new DateTime.now().toString()} - ${postBy} ${event.detail['message']}');
    setState(newState()..messages = messages);
  }

  void _handleToggleMessages(event) {
    var toggledBy = (event.target is ButtonElement) ? 'shell' : event.target;
    MicroSdk.dispatch(MicroSdk.ShellPostMessageEvent(
      'Message panel ${state.showMessages ? 'disabled' : 'enabled'} by ${toggledBy}'
    ), findDomNode(this));

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
          MicroSdk.dispatch(MicroSdk.ShellExperienceRequstedEvent(ShellExperience.DOCS.prefix), event.target);
        }
      )('New Docs Experience'),
      (Dom.button()..onClick = (event) {
        MicroSdk.dispatch(MicroSdk.ShellExperienceRequstedEvent(ShellExperience.SPREADSHEETS.prefix), event.target);
      })('New Spreadsheets Experience'),
      (Dom.button()
        ..onClick = (event) {
          MicroSdk.dispatch(MicroSdk.ShellToggleMessagesEvent());
        }
      )('Toggle Messages')
    );
  }
}
