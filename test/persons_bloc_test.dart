import 'package:block_for_managing_state/bloc/person.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';


const mockedPersons1 = [
  Person(name: 'Foo', age: 20,),
  Person(name: 'Bar', age: 30,),
];
const mockedPersons2 = [
  Person(name: 'Foo', age: 20,),
  Person(name: 'Bar', age: 30,),
];


Future<Iterable<Person>> mockedPersonOne(String _)  => Future.value(mockedPersons1);

Future<Iterable<Person>> mockedPersonTwo(String _) => Future.value(mockedPersons2);
