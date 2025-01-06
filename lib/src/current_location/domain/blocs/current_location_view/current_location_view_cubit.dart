import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_location_view_state.dart';

class CurrentLocationViewCubit extends Cubit<CurrentLocationViewState> {
  CurrentLocationViewCubit() : super(CurrentLocationViewInitial());

  void set(CurrentLocationViewState state) {
    emit(state);
  }
}
