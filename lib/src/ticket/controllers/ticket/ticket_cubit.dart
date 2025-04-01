import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_data_source.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_repository.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit(this._repository) : super(TicketInitialState()) {
    _streamSubscription = _repository.stream.listen(_listen);
  }

  final TicketRepository _repository;
  late StreamSubscription<TicketEvent> _streamSubscription;
  
  void _listen(TicketEvent event) {
    switch(event) {
      
      case CancelTicketEvent(): _cancel(event.ticketId);
    }
  }
  
  void _cancel(int id) {
    if(state case TicketLoadedState state) {
      emit(TicketLoadedState(ticket: state.ticket.copyWith(status: TicketStatus.canceled)));
    };
  }

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
  
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
