import 'package:bloc/bloc.dart';
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
    } on Exception catch(err) {
      print(err);
      emit(CreateTicketExceptionState());
    }
  }
}
