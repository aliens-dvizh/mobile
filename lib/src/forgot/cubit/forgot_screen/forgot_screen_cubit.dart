// 📦 Package imports:
import 'package:bloc/bloc.dart';

part 'forgot_screen_state.dart';

class ForgotScreenCubit extends Cubit<ForgotScreenState> {
  ForgotScreenCubit() : super(SendCodeScreenState());

  void to(ForgotScreenState state) => emit(state);
}
