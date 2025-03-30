import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_repository.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit(this._repository) : super(TicketInitialState());

  final TicketRepository _repository;

  Future<void> fetch(int id) async {
    if (state case TicketLoadedState loadedState) {
      if (loadedState.ticket.id == id) return;
    }

    emit(TicketLoadingState());
    try {
      final result = await _repository.getById(id);

      emit(TicketLoadedState(ticket: result));
    } on Exception catch (err) {
      emit(TicketExceptionState());
    }
  }
}
