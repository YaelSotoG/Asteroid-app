// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class Asteroides {
  Asteroides({
    this.links,
    this.elementCount,
    this.nearEarthObjects,
  });

  WelcomeLinks links;
  int elementCount;
  Map<String, List<NearEarthObject>> nearEarthObjects;

  factory Asteroides.fromJson(Map<String, dynamic> json) => Asteroides(
        links: WelcomeLinks.fromJson(json["links"]),
        elementCount: json["element_count"],
        nearEarthObjects: Map.from(json["near_earth_objects"]).map((k, v) =>
            MapEntry<String, List<NearEarthObject>>(
                k,
                List<NearEarthObject>.from(
                    v.map((x) => NearEarthObject.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "element_count": elementCount,
        "near_earth_objects": Map.from(nearEarthObjects).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class WelcomeLinks {
  WelcomeLinks({
    this.next,
    this.prev,
    this.self,
  });

  String next;
  String prev;
  String self;

  factory WelcomeLinks.fromJson(Map<String, dynamic> json) => WelcomeLinks(
        next: json["next"],
        prev: json["prev"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "prev": prev,
        "self": self,
      };
}

class NearEarthObject {
  NearEarthObject({
    this.links,
    this.id,
    this.neoReferenceId,
    this.name,
    this.nasaJplUrl,
    this.absoluteMagnitudeH,
    this.estimatedDiameter,
    this.isPotentiallyHazardousAsteroid,
    this.closeApproachData,
    this.isSentryObject,
  });

  NearEarthObjectLinks links;
  String id;
  String neoReferenceId;
  String name;
  String nasaJplUrl;
  double absoluteMagnitudeH;
  EstimatedDiameter estimatedDiameter;
  bool isPotentiallyHazardousAsteroid;
  List<CloseApproachDatum> closeApproachData;
  bool isSentryObject;

  factory NearEarthObject.fromJson(Map<String, dynamic> json) =>
      NearEarthObject(
        links: NearEarthObjectLinks.fromJson(json["links"]),
        id: json["id"],
        neoReferenceId: json["neo_reference_id"],
        name: json["name"],
        nasaJplUrl: json["nasa_jpl_url"],
        absoluteMagnitudeH: json["absolute_magnitude_h"].toDouble(),
        estimatedDiameter:
            EstimatedDiameter.fromJson(json["estimated_diameter"]),
        isPotentiallyHazardousAsteroid:
            json["is_potentially_hazardous_asteroid"],
        closeApproachData: List<CloseApproachDatum>.from(
            json["close_approach_data"]
                .map((x) => CloseApproachDatum.fromJson(x))),
        isSentryObject: json["is_sentry_object"],
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "id": id,
        "neo_reference_id": neoReferenceId,
        "name": name,
        "nasa_jpl_url": nasaJplUrl,
        "absolute_magnitude_h": absoluteMagnitudeH,
        "estimated_diameter": estimatedDiameter.toJson(),
        "is_potentially_hazardous_asteroid": isPotentiallyHazardousAsteroid,
        "close_approach_data":
            List<dynamic>.from(closeApproachData.map((x) => x.toJson())),
        "is_sentry_object": isSentryObject,
      };
}

class CloseApproachDatum {
  CloseApproachDatum({
    this.closeApproachDate,
    this.closeApproachDateFull,
    this.epochDateCloseApproach,
    this.relativeVelocity,
    this.missDistance,
    this.orbitingBody,
  });

  DateTime closeApproachDate;
  String closeApproachDateFull;
  int epochDateCloseApproach;
  RelativeVelocity relativeVelocity;
  MissDistance missDistance;
  OrbitingBody orbitingBody;

  factory CloseApproachDatum.fromJson(Map<String, dynamic> json) =>
      CloseApproachDatum(
        closeApproachDate: DateTime.parse(json["close_approach_date"]),
        closeApproachDateFull: json["close_approach_date_full"],
        epochDateCloseApproach: json["epoch_date_close_approach"],
        relativeVelocity: RelativeVelocity.fromJson(json["relative_velocity"]),
        missDistance: MissDistance.fromJson(json["miss_distance"]),
        orbitingBody: orbitingBodyValues.map[json["orbiting_body"]],
      );

  Map<String, dynamic> toJson() => {
        "close_approach_date":
            "${closeApproachDate.year.toString().padLeft(4, '0')}-${closeApproachDate.month.toString().padLeft(2, '0')}-${closeApproachDate.day.toString().padLeft(2, '0')}",
        "close_approach_date_full": closeApproachDateFull,
        "epoch_date_close_approach": epochDateCloseApproach,
        "relative_velocity": relativeVelocity.toJson(),
        "miss_distance": missDistance.toJson(),
        "orbiting_body": orbitingBodyValues.reverse[orbitingBody],
      };
}

class MissDistance {
  MissDistance({
    this.astronomical,
    this.lunar,
    this.kilometers,
    this.miles,
  });

  String astronomical;
  String lunar;
  String kilometers;
  String miles;

  factory MissDistance.fromJson(Map<String, dynamic> json) => MissDistance(
        astronomical: json["astronomical"],
        lunar: json["lunar"],
        kilometers: json["kilometers"],
        miles: json["miles"],
      );

  Map<String, dynamic> toJson() => {
        "astronomical": astronomical,
        "lunar": lunar,
        "kilometers": kilometers,
        "miles": miles,
      };
}

enum OrbitingBody { EARTH }

final orbitingBodyValues = EnumValues({"Earth": OrbitingBody.EARTH});

class RelativeVelocity {
  RelativeVelocity({
    this.kilometersPerSecond,
    this.kilometersPerHour,
    this.milesPerHour,
  });

  String kilometersPerSecond;
  String kilometersPerHour;
  String milesPerHour;

  factory RelativeVelocity.fromJson(Map<String, dynamic> json) =>
      RelativeVelocity(
        kilometersPerSecond: json["kilometers_per_second"],
        kilometersPerHour: json["kilometers_per_hour"],
        milesPerHour: json["miles_per_hour"],
      );

  Map<String, dynamic> toJson() => {
        "kilometers_per_second": kilometersPerSecond,
        "kilometers_per_hour": kilometersPerHour,
        "miles_per_hour": milesPerHour,
      };
}

class EstimatedDiameter {
  EstimatedDiameter({
    this.kilometers,
    this.meters,
    this.miles,
    this.feet,
  });

  Diametro kilometers;
  Diametro meters;
  Diametro miles;
  Diametro feet;

  factory EstimatedDiameter.fromJson(Map<String, dynamic> json) =>
      EstimatedDiameter(
        kilometers: Diametro.fromJson(json["kilometers"]),
        meters: Diametro.fromJson(json["meters"]),
        miles: Diametro.fromJson(json["miles"]),
        feet: Diametro.fromJson(json["feet"]),
      );

  Map<String, dynamic> toJson() => {
        "kilometers": kilometers.toJson(),
        "meters": meters.toJson(),
        "miles": miles.toJson(),
        "feet": feet.toJson(),
      };
}

class Diametro {
  Diametro({
    this.estimatedDiameterMin,
    this.estimatedDiameterMax,
  });

  double estimatedDiameterMin;
  double estimatedDiameterMax;

  factory Diametro.fromJson(Map<String, dynamic> json) => Diametro(
        estimatedDiameterMin: json["estimated_diameter_min"].toDouble(),
        estimatedDiameterMax: json["estimated_diameter_max"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "estimated_diameter_min": estimatedDiameterMin,
        "estimated_diameter_max": estimatedDiameterMax,
      };
}

class NearEarthObjectLinks {
  NearEarthObjectLinks({
    this.self,
  });

  String self;

  factory NearEarthObjectLinks.fromJson(Map<String, dynamic> json) =>
      NearEarthObjectLinks(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
