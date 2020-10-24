///
//  Generated code. Do not modify.
//  source: social_v1/social_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ChatMessageReceived$json = const {
  '1': 'ChatMessageReceived',
  '2': const [
    const {'1': 'roomId', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'participants', '3': 2, '4': 3, '5': 5, '10': 'participants'},
  ],
  '7': const {},
};

const FriendRequestReceived$json = const {
  '1': 'FriendRequestReceived',
  '2': const [
    const {'1': 'toUser', '3': 1, '4': 1, '5': 5, '10': 'toUser'},
    const {'1': 'fromUser', '3': 2, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'fromUser'},
  ],
  '7': const {},
};

const FriendRequestAccepted$json = const {
  '1': 'FriendRequestAccepted',
  '2': const [
    const {'1': 'userThatAccepted', '3': 1, '4': 1, '5': 11, '6': '.common.v1.User', '10': 'userThatAccepted'},
    const {'1': 'userThatRequested', '3': 2, '4': 1, '5': 5, '10': 'userThatRequested'},
  ],
  '7': const {},
};

const GetProfileRequest$json = const {
  '1': 'GetProfileRequest',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
  ],
};

const GetProfileResponse$json = const {
  '1': 'GetProfileResponse',
  '2': const [
    const {'1': 'profile', '3': 1, '4': 1, '5': 11, '6': '.social.v1.Profile', '10': 'profile'},
  ],
};

const ChangeProfilePictureRequest$json = const {
  '1': 'ChangeProfilePictureRequest',
  '2': const [
    const {'1': 'imgData', '3': 1, '4': 1, '5': 12, '10': 'imgData'},
  ],
};

const ChangeProfilePictureResponse$json = const {
  '1': 'ChangeProfilePictureResponse',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

const MyProfileRequest$json = const {
  '1': 'MyProfileRequest',
};

const MyProfileResponse$json = const {
  '1': 'MyProfileResponse',
  '2': const [
    const {'1': 'me', '3': 1, '4': 1, '5': 11, '6': '.social.v1.Profile', '10': 'me'},
  ],
};

const RespondToFriendRequestRequest$json = const {
  '1': 'RespondToFriendRequestRequest',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'action', '3': 2, '4': 1, '5': 14, '6': '.social.v1.RespondToFriendRequestRequest.Action', '10': 'action'},
  ],
  '4': const [RespondToFriendRequestRequest_Action$json],
};

const RespondToFriendRequestRequest_Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ACCEPT', '2': 1},
    const {'1': 'DECLINE', '2': 2},
  ],
};

const RespondToFriendRequestResponse$json = const {
  '1': 'RespondToFriendRequestResponse',
};

const SendFriendRequestRequest$json = const {
  '1': 'SendFriendRequestRequest',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
  ],
};

const SendFriendRequestResponse$json = const {
  '1': 'SendFriendRequestResponse',
};

const SearchForProfileRequest$json = const {
  '1': 'SearchForProfileRequest',
  '2': const [
    const {'1': 'searchTerm', '3': 1, '4': 1, '5': 9, '10': 'searchTerm'},
    const {'1': 'options', '3': 2, '4': 1, '5': 11, '6': '.social.v1.SearchForProfileRequest.SearchOptions', '10': 'options'},
  ],
  '3': const [SearchForProfileRequest_SearchOptions$json],
};

const SearchForProfileRequest_SearchOptions$json = const {
  '1': 'SearchOptions',
  '2': const [
    const {'1': 'onlyMyFriends', '3': 1, '4': 1, '5': 8, '10': 'onlyMyFriends'},
  ],
};

const SearchForProfileResponse$json = const {
  '1': 'SearchForProfileResponse',
  '2': const [
    const {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.social.v1.Profile', '10': 'profiles'},
  ],
};

const Profile$json = const {
  '1': 'Profile',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'imgUrl', '3': 3, '4': 1, '5': 9, '10': 'imgUrl'},
    const {'1': 'friends', '3': 4, '4': 3, '5': 5, '10': 'friends'},
    const {'1': 'friendRequests', '3': 5, '4': 3, '5': 5, '10': 'friendRequests'},
  ],
};

const SendMessageRequest$json = const {
  '1': 'SendMessageRequest',
  '2': const [
    const {'1': 'roomId', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

const SendMessageResponse$json = const {
  '1': 'SendMessageResponse',
};

const CreateRoomRequest$json = const {
  '1': 'CreateRoomRequest',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'participants', '3': 2, '4': 3, '5': 5, '10': 'participants'},
  ],
};

const CreateRoomResponse$json = const {
  '1': 'CreateRoomResponse',
  '2': const [
    const {'1': 'roomId', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const GetRoomsWhereUserIsParticipatingRequest$json = const {
  '1': 'GetRoomsWhereUserIsParticipatingRequest',
};

const GetRoomsWhereUserIsParticipatingResponse$json = const {
  '1': 'GetRoomsWhereUserIsParticipatingResponse',
  '2': const [
    const {'1': 'roomIds', '3': 1, '4': 3, '5': 9, '10': 'roomIds'},
  ],
};

const GetRoomRequest$json = const {
  '1': 'GetRoomRequest',
  '2': const [
    const {'1': 'roomId', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const GetRoomResponse$json = const {
  '1': 'GetRoomResponse',
  '2': const [
    const {'1': 'room', '3': 1, '4': 1, '5': 11, '6': '.social.v1.ChatRoom', '10': 'room'},
  ],
};

const ChatRoom$json = const {
  '1': 'ChatRoom',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'admin', '3': 2, '4': 1, '5': 5, '10': 'admin'},
    const {'1': 'participants', '3': 3, '4': 3, '5': 5, '10': 'participants'},
    const {'1': 'messages', '3': 4, '4': 3, '5': 11, '6': '.social.v1.Message', '10': 'messages'},
  ],
};

const GetMessagesRequest$json = const {
  '1': 'GetMessagesRequest',
  '2': const [
    const {'1': 'afterTimestamp', '3': 1, '4': 1, '5': 3, '10': 'afterTimestamp'},
  ],
};

const GetMessagesResponse$json = const {
  '1': 'GetMessagesResponse',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.social.v1.Message', '10': 'messages'},
  ],
};

const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'author', '3': 2, '4': 1, '5': 5, '10': 'author'},
    const {'1': 'utcTimestamp', '3': 3, '4': 1, '5': 3, '10': 'utcTimestamp'},
  ],
};

