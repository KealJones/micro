import './shell_event_constants.dart';
import './micro_event.dart';

class ShellPostMessageEvent extends MicroSdkEvent {
  ShellPostMessageEvent([message]):super(ShellEventConstants.POST_MESSAGE.event, {'message': message});
}
