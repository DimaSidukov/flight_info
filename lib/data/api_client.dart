import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'flight.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://6394e57686829c49e829e0c5.mockapi.io/flights/v1/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/international")
  Future<List<Flight>?> getInternationalFlights();

  @GET("/local")
  Future<List<Flight>?> getLocalFlights();
}
