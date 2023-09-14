
import 'Place.dart';

class Data{
  Data({
    this.postCode,
    this.country,
    this.countryAbbreviation,
    this.places,
  });

  String? postCode;
  String? country;
  String? countryAbbreviation;
  List<Place>? places;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    postCode: json["post code"],
    country: json["country"],
    countryAbbreviation: json["country abbreviation"],
    places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post code": postCode,
    "country": country,
    "country abbreviation": countryAbbreviation,
    "places": List<dynamic>.from(places!.map((x) => x.toJson())),
  };
}