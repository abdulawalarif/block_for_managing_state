import 'package:equatable/equatable.dart';

abstract class CounterCubitState extends Equatable {
  const CounterCubitState();
}

class CounterInitiate extends CounterCubitState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CounterValueUpdated extends CounterCubitState {
  int counter;
  CounterValueUpdated({required this.counter});

  @override
  // TODO: implement props
  List<Object?> get props => [counter];

}