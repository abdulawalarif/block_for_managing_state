import 'package:bloc/bloc.dart';
import 'package:block_for_managing_state/third_example/apis/login_api.dart';
import 'package:block_for_managing_state/third_example/apis/notes_api.dart';
import 'package:block_for_managing_state/third_example/bloc/actions.dart';
import 'package:block_for_managing_state/third_example/bloc/app_state.dart';
import 'package:block_for_managing_state/third_example/model.dart';

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

        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );

    on<LoadNotesAction>(
        // start loading
        (event, emit) async {
      // start loading
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );

      // get the login handle
      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.fooBar()) {
        // invalid loginHandle cannot fetch notes
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );
      }

      // we have a valid login handle and want to fetch notes
      final notes = await notesApi.getNotes(
        loginHandle: loginHandle!,
      );

           emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
    });
  }
}
