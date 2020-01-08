import 'dart:html';

import 'package:micro_sdk/src/micro_sdk.dart';

abstract class MicroContainer {
  List<MicroRegion> get regionList;
}

class MicroRegionUpdateEvent extends MicroSdkEvent {
  MicroRegion region;
  String regionName;
  Element newContent;

  MicroRegionUpdateEvent({region, regionName, newContent}):super(module: 'microsdk', type: 'micro_region_update_event', detail: {'region': region, 'region_name': regionName, 'new_content':newContent});
}

class MicroRegion {
  final String name;
  Element node;

  updateNode(MicroRegionUpdateEvent event) {
    if (name == (event?.detail['region'] != null ? event?.detail['region']['name'] : event.detail['region_name'])) {
      node.children.clear();
      node.append(event.detail['new_content']);
    }
  }

  MicroRegion({this.name}) {
    this.node = Element.div()..id = name;
    listen(MicroRegionUpdateEvent(), updateNode);
  }
}
