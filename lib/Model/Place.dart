
class Place {
  Place({
    this.placeName,
    this.longitude,
    this.state,
    this.stateAbbreviation,
    this.latitude,
  });

  String? placeName;
  String? longitude;
  String? state;
  String? stateAbbreviation;
  String? latitude;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    placeName: json["place name"],
    longitude: json["longitude"],
    state: json["state"],
    stateAbbreviation: json["state abbreviation"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "place name": placeName,
    "longitude": longitude,
    "state": state,
    "state abbreviation": stateAbbreviation,
    "latitude": latitude,
  };
}