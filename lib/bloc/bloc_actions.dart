import 'package:block_for_managing_state/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const persons1Url = 'http://192.168.0.108:5500/api/persons1.json';
const persons2Url = 'http://192.168.0.108:5500/api/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
