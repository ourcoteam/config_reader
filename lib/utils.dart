extension MapX on Map {
  dynamic get(String key) => this[key];

  Map getMap(String key) {
    try {
      return this[key] as Map;
    } catch (e) {
      return null;
    }
  }
}
