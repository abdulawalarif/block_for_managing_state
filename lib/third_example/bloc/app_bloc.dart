import 'package:bloc/bloc.dart';
import 'package:block_for_managing_state/third_example/apis/login_api.dart';
import 'package:block_for_managing_state/third_example/apis/notes_api.dart';
import 'package:block_for_managing_state/third_example/bloc/actions.dart';
import 'package:block_for_managing_state/third_example/bloc/app_state.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      // start loading
      (event, emit) async {
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );
        // log the user in
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
      },
    );
  }
}
