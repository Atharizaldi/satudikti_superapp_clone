import 'package:app/common/internetCheck.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_kd_event.dart';
part 'login_kd_state.dart';

class LoginKdBloc extends Bloc<LoginKdEvent, LoginKdState> {
  InternetCheck internetCheck;
  LoginKdBloc({required this.internetCheck}) : super(LoginKdInitial()) {
    on<SignInKdEvent>(_onSignIn);
  }

  void _onSignIn(SignInKdEvent event, Emitter<LoginKdState> emit) async {
    final isConnected = await internetCheck.hasConnection();
    if (isConnected) {
      emit(LoggedInKdState());
    } else {
      emit(LoginKdNoInternet());
    }
  }
}
