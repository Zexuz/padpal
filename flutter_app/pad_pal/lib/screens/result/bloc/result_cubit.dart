import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultState());
}
