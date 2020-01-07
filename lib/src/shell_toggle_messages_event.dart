import './shell_event_constants.dart';
import './micro_event.dart';

class ShellToggleMessagesEvent extends MicroSdkEvent {
  ShellToggleMessagesEvent():super(ShellEventConstants.TOGGLE_MESSAGES.event);
}