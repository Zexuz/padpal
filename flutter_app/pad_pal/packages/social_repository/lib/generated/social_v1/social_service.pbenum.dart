///
//  Generated code. Do not modify.
//  source: social_v1/social_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class RespondToFriendRequestRequest_Action extends $pb.ProtobufEnum {
  static const RespondToFriendRequestRequest_Action UNKNOWN = RespondToFriendRequestRequest_Action._(0, 'UNKNOWN');
  static const RespondToFriendRequestRequest_Action ACCEPT = RespondToFriendRequestRequest_Action._(1, 'ACCEPT');
  static const RespondToFriendRequestRequest_Action DECLINE = RespondToFriendRequestRequest_Action._(2, 'DECLINE');

  static const $core.List<RespondToFriendRequestRequest_Action> values = <RespondToFriendRequestRequest_Action> [
    UNKNOWN,
    ACCEPT,
    DECLINE,
  ];

  static final $core.Map<$core.int, RespondToFriendRequestRequest_Action> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RespondToFriendRequestRequest_Action valueOf($core.int value) => _byValue[value];

  const RespondToFriendRequestRequest_Action._($core.int v, $core.String n) : super(v, n);
}

