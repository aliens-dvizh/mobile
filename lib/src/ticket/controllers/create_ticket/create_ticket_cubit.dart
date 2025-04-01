import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/ticket/data/exceptions/have_ticket_exception.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_data_source.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_repository.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit(this._repository) : super(CreateTicketInitialState());

  final TicketRepository _repository;

  Future<void> create({required int eventId}) async {
    emit(CreateTicketLoadingState());

    try {
      final result = await _repository.create(eventId: eventId);
      emit(CreateTicketLoadedState(ticket: result));
    } on HaveTicketException catch(err) {
      emit(CreateHaveTicketExceptionState(
        ticketId: err.ticketId
      ));
    } on Exception catch(err) {
      emit(CreateTicketExceptionState());
    }
  }
}
