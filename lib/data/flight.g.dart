// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
      id: json['id'] as String,
      destinationCity: json['dst_city'] as String,
      minPrice: json['min_price'] as int,
      imgUrl: json['img_url'] as String,
      flightLength: json['flight_length'] as String,
      date: json['date'] as String,
      departureTime: json['departure_time'] as String,
      destinationCountry: json['dst_country'] as String?,
    );

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
      'id': instance.id,
      'dst_city': instance.destinationCity,
      'min_price': instance.minPrice,
      'img_url': instance.imgUrl,
      'flight_length': instance.flightLength,
      'date': instance.date,
      'departure_time': instance.departureTime,
      'dst_country': instance.destinationCountry,
    };
