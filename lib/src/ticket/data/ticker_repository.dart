import 'package:dvizh_mob/src/ticket/data/ticker_data_source.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

class TicketRepository {
  TicketRepository({required TicketDataSource dataSource}) : _dataSource = dataSource;

  final TicketDataSource _dataSource;

  Future<TicketModel> create({required int eventId}) {
    return _dataSource.create(eventId: eventId);
  }

  Future<List<TicketModel>> get() => _dataSource.get();

  Future<TicketModel> getById(int id) => _dataSource.getById(id);


}