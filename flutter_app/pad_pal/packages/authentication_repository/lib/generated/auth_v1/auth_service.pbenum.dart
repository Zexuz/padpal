///
//  Generated code. Do not modify.
//  source: auth_v1/auth_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class OAuthToken_TokenType extends $pb.ProtobufEnum {
  static const OAuthToken_TokenType Unknown = OAuthToken_TokenType._(0, 'Unknown');
  static const OAuthToken_TokenType Bearer = OAuthToken_TokenType._(1, 'Bearer');

  static const $core.List<OAuthToken_TokenType> values = <OAuthToken_TokenType> [
    Unknown,
    Bearer,
  ];

  static final $core.Map<$core.int, OAuthToken_TokenType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OAuthToken_TokenType valueOf($core.int value) => _byValue[value];

  const OAuthToken_TokenType._($core.int v, $core.String n) : super(v, n);
}

