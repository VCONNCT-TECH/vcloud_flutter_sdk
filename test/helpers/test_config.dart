// /// Test configuration and common setup for V.cloud SDK tests
// library vcloud_test_config;
//
// import 'package:vcloud/vcloud.dart';
//
// /// Test configuration constants
// class TestConfig {
//   static const apiKey = 'test_api_key';
//   static const projectId = 'test_project_id';
//   static const moderatorId = 'test_moderator_id';
//
//   /// Creates a basic room creation request with the given parameters
//   static RoomCreationRequest createBasicRoomRequest({
//     required String name,
//     required String clientRoomId,
//     int maxParticipants = 10,
//     int emptyTimeout = 300,
//     RoomMetadata? metadata,
//   }) {
//     return RoomCreationRequest(
//       projectId: projectId,
//       name: name,
//       clientRoomId: clientRoomId,
//       moderatorId: moderatorId,
//       maxParticipants: maxParticipants,
//       emptyTimeout: emptyTimeout,
//       metadata: metadata ?? RoomMetadata(),
//     );
//   }
//
//   /// Creates a room metadata object with the given parameters
//   static RoomMetadata createRoomMetadata({
//     String? roomTitle,
//     String? welcomeMessage,
//   }) {
//     return RoomMetadata(
//       roomTitle: roomTitle,
//       welcomeMessage: welcomeMessage,
//     );
//   }
//
//   /// Creates a user info object with the given parameters
//   static UserInfo createUserInfo({
//     required String name,
//     bool? isAdmin,
//     bool? isHidden,
//   }) {
//     return UserInfo(
//       name: name,
//       isAdmin: isAdmin,
//       isHidden: isHidden,
//     );
//   }
// }