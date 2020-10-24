///
//  Generated code. Do not modify.
//  source: game_v1/game_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CourtType extends $pb.ProtobufEnum {
  static const CourtType UNKNOWN = CourtType._(0, 'UNKNOWN');
  static const CourtType INDOORS = CourtType._(1, 'INDOORS');
  static const CourtType OUTDOORS = CourtType._(2, 'OUTDOORS');

  static const $core.List<CourtType> values = <CourtType> [
    UNKNOWN,
    INDOORS,
    OUTDOORS,
  ];

  static final $core.Map<$core.int, CourtType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CourtType valueOf($core.int value) => _byValue[value];

  const CourtType._($core.int v, $core.String n) : super(v, n);
}

