import 'dart:async';
import 'dart:html';

import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

import './shell_experience.dart';
import './shell_experience_meta.dart';

class ShellExperienceManager {
  static final ShellExperienceManager _instance = new ShellExperienceManager._internal();

  factory ShellExperienceManager() {
    return _instance;
  }

  Map _registeredExperiences = new Map<String, ShellExperienceMeta>();

  ShellExperienceManager._internal() {
    ShellExperience.experiences.forEach((ShellExperience experience) {
      _registeredExperiences[experience.prefix] = new ShellExperienceMeta(experience);
    });
  }

  void _handleAddExperience(event) {
    addExperience(event.detail['experience']);
  }

  Future addExperience(String experience) async {
    var experienceMeta = _registeredExperiences[experience];

    if(!experienceMeta.isLoaded) {
      var asyncExperienceLoader = MicroSdk.AsyncScriptLoader(experienceMeta.source);
      var asyncExperienceLoaderOnLoad = asyncExperienceLoader.loadScript();
      asyncExperienceLoaderOnLoad.whenComplete(await () => experienceMeta.isLoaded = true);
    }

    document.body.append(new Element.tag(experienceMeta.tag));
  }

  void disposeEventHandlers() {
    MicroSdk.ignore(MicroSdk.ShellExperienceRequstedEvent(), _handleAddExperience);
  }

  void initializeEventHandlers() {
    MicroSdk.listen(MicroSdk.ShellExperienceRequstedEvent(), _handleAddExperience);
  }
}
