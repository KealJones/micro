import 'dart:async';
import 'dart:html';

import 'package:shared_events/shared_events.dart';
import 'package:shell/src/shell_regions.dart';

import './shell_experience.dart';
import './shell_experience_meta.dart';
import 'package:micro_sdk/micro_sdk.dart';
import 'micro.dart';

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
    addExperience(event.experience, attributes: event.attributes);
  }

  Future addExperience(String experience, {Map attributes = const {}}) async {
    var experienceMeta = _registeredExperiences[experience];

    if(!experienceMeta.isLoaded) {
      var asyncExperienceLoader = AsyncScriptLoader(experienceMeta.source);
      var asyncExperienceLoaderOnLoad = asyncExperienceLoader.loadScript();
      asyncExperienceLoaderOnLoad.whenComplete(await () => experienceMeta.isLoaded = true);
    }

    var sidebarTag = experienceMeta.tag + '-sidebar';
    ShellRegions.app.root.dispatchEvent(MicroRegionUpdateEvent(region: ShellRegions.app, newContent: Element.tag(experienceMeta.tag)..attributes = attributes).jsEvent);
    ShellRegions.sidebar.root.dispatchEvent(MicroRegionUpdateEvent(region: ShellRegions.sidebar, newContent: Element.tag(sidebarTag)..attributes = attributes).jsEvent);
  }

  void disposeEventHandlers() {
    micro.ignore(ShellExperienceRequestedEvent(), _handleAddExperience);
  }

  void initializeEventHandlers() {
    micro.listen(ShellExperienceRequestedEvent(), _handleAddExperience);
  }
}
