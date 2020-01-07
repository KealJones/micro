import './shell_event_constants.dart';
import './micro_event.dart';

class ShellExperienceRequstedEvent extends MicroSdkEvent {
  ShellExperienceRequstedEvent([experience]):super(ShellEventConstants.EXPERIENCE_REQUESTED.event, {'experience': experience});
}
