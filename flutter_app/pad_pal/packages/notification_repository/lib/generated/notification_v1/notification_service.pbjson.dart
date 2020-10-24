///
//  Generated code. Do not modify.
//  source: notification_v1/notification_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const PushNotification$json = const {
  '1': 'PushNotification',
  '2': const [
    const {'1': 'utcTimestamp', '3': 1, '4': 1, '5': 3, '10': 'utcTimestamp'},
    const {'1': 'chatMessageReceived', '3': 10, '4': 1, '5': 11, '6': '.notification.v1.PushNotification.ChatMessageReceived', '9': 0, '10': 'chatMessageReceived'},
    const {'1': 'friendRequestReceived', '3': 11, '4': 1, '5': 11, '6': '.notification.v1.PushNotification.FriendRequestReceived', '9': 0, '10': 'friendRequestReceived'},
    const {'1': 'friendRequestAccepted', '3': 12, '4': 1, '5': 11, '6': '.notification.v1.PushNotification.FriendRequestAccepted', '9': 0, '10': 'friendRequestAccepted'},
    const {'1': 'invitedToGame', '3': 13, '4': 1, '5': 11, '6': '.notification.v1.PushNotification.InvitedToGame', '9': 0, '10': 'invitedToGame'},
    const {'1': 'requested_to_join_game', '3': 14, '4': 1, '5': 11, '6': '.notification.v1.PushNotification.RequestedToJoinGame', '9': 0, '10': 'requestedToJoinGame'},
  ],
  '3': const [PushNotification_ChatMessageReceived$json, PushNotification_FriendRequestReceived$json, PushNotification_FriendRequestAccepted$json, PushNotification_InvitedToGame$json, PushNotification_RequestedToJoinGame$json],
  '8': const [
    const {'1': 'notification'},
  ],
};

const PushNotification_ChatMessageReceived$json = const {
  '1': 'ChatMessageReceived',
  '2': const [
    const {'1': 'roomId', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
  '7': const {},
};

const PushNotification_FriendRequestReceived$json = const {
  '1': 'FriendRequestReceived',
  '2': const [
    const {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'player'},
  ],
  '7': const {},
};

const PushNotification_FriendRequestAccepted$json = const {
  '1': 'FriendRequestAccepted',
  '2': const [
    const {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'player'},
  ],
  '7': const {},
};

const PushNotification_InvitedToGame$json = const {
  '1': 'InvitedToGame',
  '2': const [
    const {'1': 'GameInfo', '3': 1, '4': 1, '5': 11, '6': '.game.v1.PublicGameInfo', '10': 'GameInfo'},
  ],
  '7': const {},
};

const PushNotification_RequestedToJoinGame$json = const {
  '1': 'RequestedToJoinGame',
  '2': const [
    const {'1': 'gameId', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'user'},
  ],
  '7': const {},
};

const RemoveNotificationRequest$json = const {
  '1': 'RemoveNotificationRequest',
};

const RemoveNotificationResponse$json = const {
  '1': 'RemoveNotificationResponse',
};

const GetNotificationRequest$json = const {
  '1': 'GetNotificationRequest',
};

const GetNotificationResponse$json = const {
  '1': 'GetNotificationResponse',
  '2': const [
    const {'1': 'notifications', '3': 1, '4': 3, '5': 11, '6': '.notification.v1.PushNotification', '10': 'notifications'},
  ],
};

const AppendFcmTokenToUserRequest$json = const {
  '1': 'AppendFcmTokenToUserRequest',
  '2': const [
    const {'1': 'fcmToken', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

const AppendFcmTokenToUserResponse$json = const {
  '1': 'AppendFcmTokenToUserResponse',
};

