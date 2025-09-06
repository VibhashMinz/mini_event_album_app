import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_event_album_app/core/dio_client.dart';

import '../../../../core/api_exceptions.dart';
import '../../domain/entities/event.dart';
import 'events_api_base.dart';

class EventsApi implements EventsApiBase {
  EventsApi({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<List<Event>> getEvents({int page = 1, int limit = 10}) async {
    try {
      final response = await _dioClient.dio.get(
        '/events',
        queryParameters: {'page': page, 'limit': limit},
      );
      final List<dynamic> data = response.data;
      //  log('Response: $data');
      return data.map((json) => Event.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } catch (e) {
      throw ApiException(message: 'Unexpected error: $e', originalError: e);
    }
  }
}
