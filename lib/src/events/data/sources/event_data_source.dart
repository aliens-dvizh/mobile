import 'package:dvizh_mob/core/services/dio_service.dart';

class EventDataSource {
  final DioService _dioService;

  EventDataSource(this._dioService);

  Future getEvents() async {
    final response = await _dioService.I.get('/event/event/', data: {
      'page': 0,
      'per_page': 10,
    });
    return response.data;
  }
}
