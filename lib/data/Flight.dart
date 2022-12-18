import 'package:json_annotation/json_annotation.dart';

part 'Flight.g.dart';

@JsonSerializable()
class Flight {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'dst_city')
  String destinationCity;
  @JsonKey(name: 'min_price')
  int minPrice;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'flight_length')
  String flightLength;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: 'departure_time')
  String departureTime;
  @JsonKey(name: 'dst_country')
  String? destinationCountry;

  Flight(
      {required this.id,
      required this.destinationCity,
      required this.minPrice,
      required this.imgUrl,
      required this.flightLength,
      required this.date,
      required this.departureTime,
      this.destinationCountry});

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
