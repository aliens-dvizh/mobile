import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/theme/domain/models/theme_type.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(type: ThemeType.light));

  void switchTheme(ThemeType type) {
    emit(ThemeState(type: type));
  }
}
