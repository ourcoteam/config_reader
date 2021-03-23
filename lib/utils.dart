extension MapX on Map {
  dynamic get(String key) => this[key];

  Map getMap(String key) => this[key] as Map;
}
