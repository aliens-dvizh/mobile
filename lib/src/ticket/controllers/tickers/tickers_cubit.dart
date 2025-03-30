import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/ticket/data/ticker_repository.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

part 'tickers_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit(this._repository) : super(TickersInitialState());

  final TicketRepository _repository;

  Future<void> fetch() async {
    emit(TickersLoadingState());
    try {
      final result = await _repository.get();

      emit(TickersLoadedState(tickets: result));
    } on Exception catch(err) {
      emit(TickersExceptionState());

    }
  }
}
