///
//  Generated code. Do not modify.
//  source: auth_v1/auth_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const UserSignUpMessage$json = const {
  '1': 'UserSignUpMessage',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
  '7': const {},
};

const SignInRequest$json = const {
  '1': 'SignInRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const GetNewAccessTokenRequest$json = const {
  '1': 'GetNewAccessTokenRequest',
  '2': const [
    const {'1': 'refreshToken', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

const GetNewAccessTokenResponse$json = const {
  '1': 'GetNewAccessTokenResponse',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.OAuthToken', '10': 'token'},
  ],
};

const OAuthToken$json = const {
  '1': 'OAuthToken',
  '2': const [
    const {'1': 'accessToken', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'expires', '3': 2, '4': 1, '5': 3, '10': 'expires'},
    const {'1': 'refreshToken', '3': 3, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.auth.v1.OAuthToken.TokenType', '10': 'type'},
  ],
  '4': const [OAuthToken_TokenType$json],
};

const OAuthToken_TokenType$json = const {
  '1': 'TokenType',
  '2': const [
    const {'1': 'Unknown', '2': 0},
    const {'1': 'Bearer', '2': 1},
  ],
};

const SignInResponse$json = const {
  '1': 'SignInResponse',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.OAuthToken', '10': 'token'},
  ],
};

const NewUser$json = const {
  '1': 'NewUser',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dateOfBirth', '3': 4, '4': 1, '5': 11, '6': '.auth.v1.NewUser.Date', '10': 'dateOfBirth'},
  ],
  '3': const [NewUser_Date$json],
};

const NewUser_Date$json = const {
  '1': 'Date',
  '2': const [
    const {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    const {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
    const {'1': 'day', '3': 3, '4': 1, '5': 5, '10': 'day'},
  ],
};

const SignUpRequest$json = const {
  '1': 'SignUpRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.NewUser', '10': 'user'},
  ],
};

const SignUpResponse$json = const {
  '1': 'SignUpResponse',
};

const GetPublicJwtKeyRequest$json = const {
  '1': 'GetPublicJwtKeyRequest',
};

const GetPublicJwtKeyResponse$json = const {
  '1': 'GetPublicJwtKeyResponse',
  '2': const [
    const {'1': 'publicRsaKey', '3': 1, '4': 1, '5': 9, '10': 'publicRsaKey'},
  ],
};

