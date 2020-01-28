import 'dart:async';
import 'dart:html';

import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;
import 'package:shared_events/shared_events.dart';
import 'package:shell/src/shell_regions.dart';

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

  void _handleAddExperience(ShellExperienceRequestedEvent event) {
    addExperience(event.experience);
  }

  Future addExperience(String experience) async {
    var experienceMeta = _registeredExperiences[experience];

    if(!experienceMeta.isLoaded) {
      var asyncExperienceLoader = MicroSdk.AsyncScriptLoader(experienceMeta.source);
      var asyncExperienceLoaderOnLoad = asyncExperienceLoader.loadScript();
      asyncExperienceLoaderOnLoad.whenComplete(await () => experienceMeta.isLoaded = true);
    }

    MicroSdk.dispatch(MicroSdk.MicroRegionUpdateEvent(region: ShellRegions.app, newContent: Element.tag(experienceMeta.tag)));
    MicroSdk.dispatch(MicroSdk.MicroRegionUpdateEvent(region: ShellRegions.sidebar, newContent: Element.tag(experienceMeta.tag + '-sidebar')));
  }

  void disposeEventHandlers() {
    MicroSdk.ignore(ShellExperienceRequestedEvent(), _handleAddExperience);
  }

  void initializeEventHandlers() {
    MicroSdk.listen(ShellExperienceRequestedEvent(), _handleAddExperience);
  }
}
