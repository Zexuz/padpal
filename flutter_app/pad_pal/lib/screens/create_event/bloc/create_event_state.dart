part of 'create_event_bloc.dart';

class CreateEventState extends Equatable {
  const CreateEventState({
    @required this.isNextEnabled,
    @required this.currentStep,
  });

  final bool isNextEnabled;
  final int currentStep;

  @override
  List<Object> get props => [isNextEnabled, currentStep];

  CreateEventState copyWith({
    bool isNextEnabled,
    int currentStep,
  }) {
    return CreateEventState(
      isNextEnabled: isNextEnabled ?? this.isNextEnabled,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}
