import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:shared_events/shared_events.dart';

import './shell_regions.dart';
import './micro.dart';
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

    micro.listen(ShellPostMessageEvent(), _handlePostMessage);
    micro.listen(ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _shellExperienceManager.disposeEventHandlers();

    micro.ignore(ShellPostMessageEvent(), _handlePostMessage);
    micro.ignore(ShellToggleMessagesEvent(), _handleToggleMessages);
  }

  @override
  void componentDidUpdate(prevProps, prevState, [snapshot]) {
    if(state.showMessages) {
      var _messagesBoxNode = findDomNode(_messagesBox);
      _messagesBoxNode.scrollTo(0, _messagesBoxNode.scrollHeight);
    }
  }

  ReactElement _appRegion() {
    return React.createElement(ShellRegions.app.tag, jsify({}));
  }

  ReactElement _sidebarRegion() {
    return React.createElement(ShellRegions.sidebar.tag, jsify({}));
  }

  render() {
    return Fragment()(
      Dom.header()(
        Dom.h2()('Shell: Using over_react ^3.1.0'),
        _renderShellControls(),
        _renderMessagesBox(),
        Dom.nav()(
          'Toolbar.'
        ),
      ),
      (Dom.div()..className="body")(
        (Dom.main()..className = "content")(
          _appRegion(),
        ),
        Dom.aside()(
          _sidebarRegion(),
        ),
      ),
      Dom.footer()(),
    );
  }

  void _handlePostMessage(ShellPostMessageEvent event) {
    var messages = new List.from(state.messages);
    var postBy = 'Message posted from ${event.via ?? 'shell'}:';

    messages.add('${new DateTime.now().toString()} - ${postBy} ${event.message}');
    setState(newState()..messages = messages);
  }

  void _handleToggleMessages(event) {
    micro.dispatch(ShellPostMessageEvent(
      'Message panel ${state.showMessages ? 'disabled' : 'enabled'} by ${event.via}'
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
          micro.dispatch(ShellExperienceRequestedEvent(experience: ShellExperience.DOCS.prefix));
        }
      )('New Docs Experience'),
      (Dom.button()..onClick = (event) {
        micro.dispatch(ShellExperienceRequestedEvent(experience: ShellExperience.SPREADSHEETS.prefix, attributes: {'test':true}));
      })('New Spreadsheets Experience'),
      (Dom.button()..onClick = (event) {
        micro.dispatch(ShellExperienceRequestedEvent(experience: ShellExperience.REACTOR.prefix, attributes: {'test':true}));
      })('New Reactor Experience'),
      (Dom.button()
        ..onClick = (event) {
          micro.dispatch(ShellToggleMessagesEvent());
        }
      )('Toggle Messages')
    );
  }
}
