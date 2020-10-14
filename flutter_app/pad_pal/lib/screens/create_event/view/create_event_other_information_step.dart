import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/generated/game_v1/game_service.pb.dart';
import 'package:pad_pal/components/components.dart';

import '../bloc/create_event_bloc.dart';

class CreateEventOtherInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CourtTypeInput(),
        const SizedBox(
          height: 48,
        ),
        _PriceInput(),
        const SizedBox(
          height: 48,
        ),
        _AdditionalInformation(),
      ],
    );
  }
}

class _AdditionalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.additionalInformation != current.additionalInformation,
      builder: (context, state) {
        return TextFormField(
          maxLines: 8, // TODO make some logging and check if this needs to be bigger!
          initialValue: state.additionalInformation,
          onChanged: (value) => context.bloc<CreateEventCubit>().additionalInformationChanged(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'Leave a message',
            hintText: "This text will not be visible to people outside of this event",
          ),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.additionalInformation != current.additionalInformation,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.pricePerPerson?.toString(),
          onChanged: (value) => context.bloc<CreateEventCubit>().pricePerPersonChanged(value),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "kr",
            border: OutlineInputBorder(),
            labelText: 'Price per person',
          ),
        );
      },
    );
  }
}

class _CourtTypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.courtType != current.courtType,
      builder: (context, state) {
        return Column(
          children: [
            RadioButtonInput<CourtType>(
              text: "Indoors",
              value: CourtType.INDOORS,
              groupValue: state.courtType,
              onChanged: (newValue) {
                if (newValue == null) return;
                context.bloc<CreateEventCubit>().courtTypeChanged(newValue);
              },
            ),
            const SizedBox(height: 12),
            RadioButtonInput<CourtType>(
              text: "Outdoors",
              value: CourtType.OUTDOORS,
              groupValue: state.courtType,
              onChanged: (newValue) {
                if (newValue == null) return;
                context.bloc<CreateEventCubit>().courtTypeChanged(newValue);
              },
            ),
          ],
        );
      },
    );
  }
}
