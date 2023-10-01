import 'package:block_for_managing_state/cubit/counter_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  int counter = 0;
  CounterCubit():super(CounterInitiate());


  void counterIncrement(){
    counter ++;
    emit(CounterValueUpdated(counter: counter));
  }
  void counterDecrement(){
    counter --;
    emit(CounterValueUpdated(counter: counter));
  }

}