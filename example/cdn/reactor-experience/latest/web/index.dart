import 'package:reactor_experience/reactor_experience.dart';
import 'package:micro_sdk/micro_sdk.dart';

void main() {
  defineMicroElement('reactor-experience', (e) => ReactorExperience(e));
  defineMicroElement('reactor-experience-sidebar', (e) => ReactorExperience.sidebar(e));
}
