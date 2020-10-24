///
//  Generated code. Do not modify.
//  source: game_v1/game_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const CourtType$json = const {
  '1': 'CourtType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'INDOORS', '2': 1},
    const {'1': 'OUTDOORS', '2': 2},
  ],
};

const GameCreated$json = const {
  '1': 'GameCreated',
  '2': const [
    const {'1': 'publicGameInfo', '3': 1, '4': 1, '5': 11, '6': '.game.v1.PublicGameInfo', '10': 'publicGameInfo'},
    const {'1': 'invited_players', '3': 2, '4': 3, '5': 5, '10': 'invitedPlayers'},
  ],
  '7': const {},
};

const UserRequestedToJoinGame$json = const {
  '1': 'UserRequestedToJoinGame',
  '2': const [
    const {'1': 'game', '3': 1, '4': 1, '5': 11, '6': '.game.v1.PublicGameInfo', '10': 'game'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'user'},
  ],
  '7': const {},
};

const AcceptedToGame$json = const {
  '1': 'AcceptedToGame',
  '2': const [
    const {'1': 'game', '3': 1, '4': 1, '5': 11, '6': '.game.v1.PublicGameInfo', '10': 'game'},
    const {'1': 'user', '3': 2, '4': 1, '5': 5, '10': 'user'},
  ],
  '7': const {},
};

const AcceptRequestToJoinGameRequest$json = const {
  '1': 'AcceptRequestToJoinGameRequest',
  '2': const [
    const {'1': 'gameId', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    const {'1': 'userId', '3': 2, '4': 1, '5': 5, '10': 'userId'},
  ],
};

const AcceptRequestToJoinGameResponse$json = const {
  '1': 'AcceptRequestToJoinGameResponse',
};

const RequestToJoinGameRequest$json = const {
  '1': 'RequestToJoinGameRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const RequestToJoinGameResponse$json = const {
  '1': 'RequestToJoinGameResponse',
};

const GameFilter$json = const {
  '1': 'GameFilter',
  '2': const [
    const {'1': 'center', '3': 1, '4': 1, '5': 11, '6': '.game.v1.Point', '10': 'center'},
    const {'1': 'distance', '3': 2, '4': 1, '5': 5, '10': 'distance'},
    const {'1': 'timeOffset', '3': 3, '4': 1, '5': 11, '6': '.game.v1.GameFilter.TimeOffset', '10': 'timeOffset'},
  ],
  '3': const [GameFilter_TimeOffset$json],
};

const GameFilter_TimeOffset$json = const {
  '1': 'TimeOffset',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 3, '10': 'start'},
    const {'1': 'end', '3': 2, '4': 1, '5': 3, '10': 'end'},
  ],
};

const FindGamesRequest$json = const {
  '1': 'FindGamesRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.game.v1.GameFilter', '10': 'filter'},
  ],
};

const FindGamesResponse$json = const {
  '1': 'FindGamesResponse',
  '2': const [
    const {'1': 'games', '3': 1, '4': 3, '5': 11, '6': '.game.v1.PublicGameInfo', '10': 'games'},
  ],
};

const PublicGameInfo$json = const {
  '1': 'PublicGameInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.game.v1.PadelCenter', '10': 'location'},
    const {'1': 'start_time', '3': 3, '4': 1, '5': 3, '10': 'startTime'},
    const {'1': 'duration_in_minutes', '3': 4, '4': 1, '5': 5, '10': 'durationInMinutes'},
    const {'1': 'price_per_person', '3': 5, '4': 1, '5': 5, '10': 'pricePerPerson'},
    const {'1': 'court_type', '3': 6, '4': 1, '5': 14, '6': '.game.v1.CourtType', '10': 'courtType'},
    const {'1': 'creator', '3': 7, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'creator'},
    const {'1': 'playerRequestedToJoin', '3': 8, '4': 3, '5': 11, '6': '.common.v1.User', '10': 'playerRequestedToJoin'},
    const {'1': 'players', '3': 9, '4': 3, '5': 11, '6': '.common.v1.User', '10': 'players'},
  ],
};

const PrivateGameInfo$json = const {
  '1': 'PrivateGameInfo',
  '2': const [
    const {'1': 'courtName', '3': 1, '4': 1, '5': 9, '10': 'courtName'},
    const {'1': 'additional_information', '3': 2, '4': 1, '5': 9, '10': 'additionalInformation'},
  ],
};

const Point$json = const {
  '1': 'Point',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

const PadelCenter$json = const {
  '1': 'PadelCenter',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'point', '3': 2, '4': 1, '5': 11, '6': '.game.v1.Point', '10': 'point'},
  ],
};

const CreateGameRequest$json = const {
  '1': 'CreateGameRequest',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 11, '6': '.game.v1.PadelCenter', '10': 'location'},
    const {'1': 'start_time', '3': 2, '4': 1, '5': 3, '10': 'startTime'},
    const {'1': 'duration_in_minutes', '3': 3, '4': 1, '5': 5, '10': 'durationInMinutes'},
    const {'1': 'price_per_person', '3': 4, '4': 1, '5': 5, '10': 'pricePerPerson'},
    const {'1': 'court_type', '3': 5, '4': 1, '5': 14, '6': '.game.v1.CourtType', '10': 'courtType'},
    const {'1': 'Creator', '3': 6, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'Creator'},
    const {'1': 'courtName', '3': 7, '4': 1, '5': 9, '10': 'courtName'},
    const {'1': 'additional_information', '3': 8, '4': 1, '5': 9, '10': 'additionalInformation'},
    const {'1': 'players_to_invite', '3': 9, '4': 3, '5': 5, '10': 'playersToInvite'},
  ],
};

const CreateGameResponse$json = const {
  '1': 'CreateGameResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

