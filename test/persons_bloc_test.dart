import 'package:block_for_managing_state/bloc/bloc_actions.dart';
import 'package:block_for_managing_state/bloc/person.dart';
import 'package:block_for_managing_state/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'dart:ui';

const mockedPersons1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];
const mockedPersons2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];

Future<Iterable<Person>> mockedGetPersonOne(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockedGetPersonTwo(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Persons bloc test', () {
    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Testing initial state',
      build: () => bloc,
      verify: (bloc) => bloc.state == null,
    );

    /// fetch mock data (personOne) and compare it with FetchResult

    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: "dummy_first_url",
            personLoader: mockedGetPersonOne,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: "dummy_first_url",
            personLoader: mockedGetPersonOne,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons1,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons1,
          isRetrievedFromCache: true,
        ),
      ],
    );

    /// fetch mock data (personTwo) and compare it with FetchResult

    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: "dummy_second_url",
            personLoader: mockedGetPersonTwo,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: "dummy_second_url",
            personLoader: mockedGetPersonTwo,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons2,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons2,
          isRetrievedFromCache: true,
        ),
      ],
    );
  });
}
