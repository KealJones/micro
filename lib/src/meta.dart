@JS()
library micro_sdk.meta;

import 'package:js/js.dart';

class MicroContainerMeta {
  static const CDN_URL = 'localhost:9000';
  static const RELEASE_DIR = 'latest/web';
  static const SCRIPT_NAME = 'index.dart.js';
  static const TAG_POSTFIX = '-experience';

  ShellExperienceMeta(this.shellExperience) {
    prefix = shellExperience.prefix;
    tag = '${prefix}${TAG_POSTFIX}';
    source = 'http://${CDN_URL}/${tag}/${RELEASE_DIR}/${SCRIPT_NAME}';
  }

  bool isLoaded = false;

  String prefix;

  ShellExperience shellExperience;

  String source;

  String tag;
}
