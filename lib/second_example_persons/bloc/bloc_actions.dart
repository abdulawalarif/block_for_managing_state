import 'package:block_for_managing_state/second_example_persons/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const persons1Url = 'http://10.0.2.2:5500/api/persons1.json';
const persons2Url = 'http://10.0.2.2:5500/api/persons2.json';

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
