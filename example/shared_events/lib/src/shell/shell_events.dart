import 'package:micro_sdk/micro_sdk.dart';

class _EventTypeConstants {
  static const MODULE_NAME = 'shell';

  static const String EXPERIENCE_REQUESTED = 'experience_requested';

  static const String POST_MESSAGE = 'post_message';

  static const String TOGGLE_MESSAGES = 'toggle_messages';
}

class ShellMicroSdkEvent extends MicroSdkEvent {
  ShellMicroSdkEvent({type, detail}):super(type: '${_EventTypeConstants.MODULE_NAME}:$type', detail:detail);
}

class ShellPostMessageEvent extends ShellMicroSdkEvent {
  ShellPostMessageEvent([message = '']):super(type: _EventTypeConstants.POST_MESSAGE, detail: {'message': message});
  String get message => detail['message'];
}

class ShellExperienceRequestedEvent extends ShellMicroSdkEvent {
  ShellExperienceRequestedEvent({experience, attributes = const {}}):super(type:_EventTypeConstants.EXPERIENCE_REQUESTED, detail: {'experience': experience, 'attributes': attributes});

  String get experience => detail['experience'];

  Map get attributes => detail['attributes'];
}

class ShellToggleMessagesEvent extends ShellMicroSdkEvent {
  ShellToggleMessagesEvent():super(type: _EventTypeConstants.TOGGLE_MESSAGES);
}
