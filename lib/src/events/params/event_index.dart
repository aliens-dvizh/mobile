import '../../../core/models/params/params.dart';

class EventIndexParams extends Params {
  final int page;
  final int perPage;

  EventIndexParams({this.page = 1, this.perPage = 10});

  @override
  toData() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }
}
