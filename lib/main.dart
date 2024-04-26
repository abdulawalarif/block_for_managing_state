import 'package:block_for_managing_state/third_example/apis/login_api.dart';
import 'package:block_for_managing_state/third_example/apis/notes_api.dart';
import 'package:block_for_managing_state/third_example/bloc/actions.dart';
import 'package:block_for_managing_state/third_example/bloc/app_bloc.dart';
import 'package:block_for_managing_state/third_example/bloc/app_state.dart';
import 'package:block_for_managing_state/third_example/dialogs/generic_dialog.dart';
import 'package:block_for_managing_state/third_example/dialogs/loading_screen.dart';
import 'package:block_for_managing_state/third_example/model.dart';
import 'package:block_for_managing_state/third_example/views/iterable_list_view.dart';
import 'package:block_for_managing_state/third_example/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'third_example/strings.dart';

///4:34:27 / 11:29:38

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            // loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            // display possible errors
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {
                  ok: true,
                },
              );
            }
            // if we are logged in, but we have no fetched notes, fetch them now.
            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
