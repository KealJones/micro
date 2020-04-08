import 'package:micro_sdk/micro_sdk.dart' as MicroSdk;

class _ShellRegions {
  MicroSdk.MicroRegion app = MicroSdk.MicroRegion('App');
  MicroSdk.MicroRegion sidebar = MicroSdk.MicroRegion('Sidebar');
}
_ShellRegions ShellRegions = _ShellRegions();
