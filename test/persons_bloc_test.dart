import 'package:block_for_managing_state/bloc/bloc_actions.dart';
import 'package:block_for_managing_state/bloc/person.dart';
import 'package:block_for_managing_state/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(
    name: "Foo",
    age: 20,
  ),
  Person(
    name: "Bar",
    age: 30,
  ),
];

const mockedPersons2 = [
  Person(
    name: "Foo2",
    age: 202,
  ),
  Person(
    name: "Bar2",
    age: 302,
  ),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    // write out tests

    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => bloc.state == null,
    );

    // fetch mock data (persons1) and compare it with FetchResult

    blocTest<PersonsBloc, FetchResult?>(
        'Moc retriving persons from first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
          const  LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );

            bloc.add(
          const  LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );

        } 
        
        );
  });
}



/// Understanding the whole codebase first time then continueing the rest the test 2:15:41 / 11:29:38