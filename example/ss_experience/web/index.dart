import 'package:ss_experience/ss_experience.dart';
import 'package:micro_sdk/micro_sdk.dart';

void main() {
  defineMicroElement('ss-experience', (e) => SSExperience(e));
  defineMicroElement('ss-experience-sidebar', (e) => SSExperience.sidebar(e));
}
