import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';
import 'package:micro_sdk/src/micro_element.dart';
import 'package:micro_sdk/src/micro_sdk.dart';

abstract class MicroContainer {
  List<MicroRegion> get regionList;
  final String configUrl;
  dynamic containerConfig;
  MicroContainer([this.configUrl]) {
    http
      .get(Uri.parse(configUrl))
      .then((response) => containerConfig = jsonDecode(response.body));
  }

}

class MicroRegionUpdateEvent extends MicroSdkEvent {
  MicroRegion get region => detail['region'];
  String get regionName => detail['region_name'];
  Element get newContent => detail['new_content'];

  MicroRegionUpdateEvent({region, regionName, newContent}):super(module: 'microsdk', type: 'micro_region_update_event', detail: {'region': region, 'region_name': regionName, 'new_content':newContent});
}

class MicroRegion {
  MicroRegion(this.name, { this.root }) {
    if (root == null) {
      defineMicroElement(tag, (e) => (root = e));
    }
    listen(MicroRegionUpdateEvent(), updateRegion);
  }

  final String name;
  ShadowRoot root;
  String get tag => 'micro-' + name.paramCase;

  updateRegion(MicroRegionUpdateEvent event) {
    if (name == (event.region != null ? event.region.name : event.regionName)) {
      root.children.clear();
      root.append(event.newContent);
    }
  }
}
