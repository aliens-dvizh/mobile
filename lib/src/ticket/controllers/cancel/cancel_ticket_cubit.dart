import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_repository.dart';
import 'package:meta/meta.dart';

part 'cancel_ticket_state.dart';

class CancelTicketCubit extends Cubit<CancelTicketState> {
  CancelTicketCubit(this._repository) : super(CancelTicketInitialState());

  final TicketRepository _repository;

  Future<void> cancel(int ticketId) async {
    emit(CancelTicketLoadingState());

    try {
      await _repository.cancel(ticketId);
      emit(CancelTicketLoadedState());
    } on Exception catch(err) {
      emit(CancelTicketExceptionState());
    }
  }
}
