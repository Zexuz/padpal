part of 'create_event_bloc.dart';

class CreateEventState extends Equatable {
  const CreateEventState({
    @required this.isNextEnabled,
    @required this.currentStep,
    this.status = FormzStatus.pure,
    this.matchStartDate,
    this.matchDuration,
    this.locationName,
    this.locationLatLng,
    this.courtNumber,
    this.courtType,
    this.pricePerPerson,
    this.additionalInformation,
  });

  final FormzStatus status;
  final bool isNextEnabled;
  final int currentStep;
  final DateTime matchStartDate;
  final Duration matchDuration;
  final String locationName;
  final LatLng locationLatLng;
  final String courtNumber;
  final CourtType courtType;
  final int pricePerPerson;
  final String additionalInformation;

  @override
  List<Object> get props => [
        status,
        isNextEnabled,
        currentStep,
        matchStartDate,
        matchDuration,
        locationName,
        locationLatLng,
        courtNumber,
        courtType,
        pricePerPerson,
        additionalInformation
      ];

  CreateEventState copyWith({
    FormzStatus status,
    bool isNextEnabled,
    int currentStep,
    DateTime matchStartDate,
    Duration matchDuration,
    String locationName,
    LatLng locationLatLng,
    String courtNumber,
    CourtType courtType,
    int pricePerPerson,
    String additionalInformation,
  }) {
    return CreateEventState(
      status: status ?? this.status,
      isNextEnabled: isNextEnabled ?? this.isNextEnabled,
      currentStep: currentStep ?? this.currentStep,
      matchStartDate: matchStartDate ?? this.matchStartDate,
      matchDuration: matchDuration ?? this.matchDuration,
      locationName: locationName ?? this.locationName,
      locationLatLng: locationLatLng ?? this.locationLatLng,
      courtNumber: courtNumber ?? this.courtNumber,
      courtType: courtType ?? this.courtType,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      additionalInformation: additionalInformation ?? this.additionalInformation,
    );
  }
}
