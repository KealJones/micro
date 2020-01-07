class ShellEventConstants {
  const ShellEventConstants._(this.event);

  static const COMPONENT_NAME = 'shell';

  final String event;

  static const ShellEventConstants EXPERIENCE_REQUESTED =
    const ShellEventConstants._('${ShellEventConstants.COMPONENT_NAME}:experience_requested');

  static const ShellEventConstants POST_MESSAGE =
    const ShellEventConstants._('${ShellEventConstants.COMPONENT_NAME}:post_message');

  static const ShellEventConstants TOGGLE_MESSAGES =
    const ShellEventConstants._('${ShellEventConstants.COMPONENT_NAME}:toggle_messages');
}
