import 'package:block_for_managing_state/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const personOneUrl = 'http://192.168.0.108:5500/api/persons1.json';
const personTwoUrl = 'http://192.168.0.108:5500/api/persons2.json';

@immutable
abstract class LoadAction {
  const LoadAction();
}

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonLoader personLoader;
  const LoadPersonsAction({required this.url, required this.personLoader}) : super();
}
PersonLoader personLoader = PersonLoader();