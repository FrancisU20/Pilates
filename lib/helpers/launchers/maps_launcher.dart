import 'dart:developer';

import 'package:map_launcher/map_launcher.dart';

class MapAppLauncher {
  Future<void> openMaps(
      {required double latitude,
      required double longitude,
      required String name}) async {
    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(latitude, longitude),
        title: name,
      );
    } else {
      log('No maps available');
    }
  }
}

MapAppLauncher mapServices = MapAppLauncher();
