import 'package:micro_sdk/micro_sdk.dart';

class _EventTypeConstants {
  static const MODULE_NAME = 'shell';

  static const String EXPERIENCE_REQUESTED = 'experience_requested';

  static const String POST_MESSAGE = 'post_message';

  static const String TOGGLE_MESSAGES = 'toggle_messages';
}

class ShellMicroSdkEvent extends MicroSdkEvent {
  ShellMicroSdkEvent({type, detail}):super(module: _EventTypeConstants.MODULE_NAME, type: type, detail:detail);
}

class ShellPostMessageEvent extends ShellMicroSdkEvent {
  ShellPostMessageEvent([message]):super(type: _EventTypeConstants.POST_MESSAGE, detail: {'message': message});

  String get message => detail['message'];
}

class ShellExperienceRequestedEvent extends ShellMicroSdkEvent {
  ShellExperienceRequestedEvent([experience]):super(type:_EventTypeConstants.EXPERIENCE_REQUESTED, detail: {'experience': experience});

  String get experience => detail['experience'];
}

class ShellToggleMessagesEvent extends ShellMicroSdkEvent {
  ShellToggleMessagesEvent():super(type: _EventTypeConstants.TOGGLE_MESSAGES);
}
