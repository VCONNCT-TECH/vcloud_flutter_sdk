// import 'package:test/test.dart';
// import 'package:vcloud/vcloud.dart';
//
// import '../helpers/test_config.dart';
// import '../helpers/test_utils.dart';
//
// void main() {
//   late VCloudClient client;
//   late String roomId;
//
//   setUp(() async {
//     client = VCloudClient(apiKey: TestConfig.apiKey);
//
//     // Create a test room for joining tests
//     roomId = await TestUtils.createTestRoom(
//       client,
//       name: 'Join Test Room',
//       clientRoomId: TestUtils.generateUniqueClientRoomId('join-test'),
//       isVideo: true,
//       metadata: RoomMetadata(
//         roomTitle: 'Join Test Room',
//         welcomeMessage: 'Welcome to the join test room!',
//       ),
//     );
//   });
//
//   tearDown(() async {
//     await TestUtils.cleanupRoom(client, roomId);
//     client.close();
//   });
//
//   group('Room Joining Tests', () {
//     // Test Case ID: 37
//     test('Verify that the user can join the room with submitting name and not hidden', () async {
//       final request = JoinRoomRequest(
//         roomId: roomId,
//         userInfo: UserInfo(
//           name: 'Test User',
//           isHidden: false,
//         ),
//       );
//
//       final response = await client.joinRoom(request: request);
//
//       expect(response.status, isTrue);
//       expect(response.finalLink, isNotNull);
//       expect(response.finalLink, isNotEmpty);
//
//       // Verify the user appears in the room participants list
//       final roomInfo = await client.getActiveRoomInfo(roomId: roomId);
//       expect(
//         roomInfo.room!.participants.any((p) => p.name == 'Test User'),
//         isTrue,
//       );
//     });
//
//     // Additional test cases for joining rooms
//     test('Verify that the user can join the room as hidden user', () async {
//       final request = JoinRoomRequest(
//         roomId: roomId,
//         userInfo: UserInfo(
//           name: 'Hidden User',
//           isHidden: true,
//         ),
//       );
//
//       final response = await client.joinRoom(request: request);
//
//       expect(response.status, isTrue);
//       expect(response.finalLink, isNotNull);
//       expect(response.finalLink, isNotEmpty);
//
//       // Verify the hidden user doesn't appear in the room participants list
//       final roomInfo = await client.getActiveRoomInfo(roomId: roomId);
//       expect(
//         roomInfo.room!.participants.any((p) => p.name == 'Hidden User'),
//         isFalse,
//       );
//     });
//
//     test('Verify that the user cannot join a non-existent room', () async {
//       final request = JoinRoomRequest(
//         roomId: 'non-existent-room-id',
//         userInfo: UserInfo(
//           name: 'Test User',
//         ),
//       );
//
//       expect(
//         () => client.joinRoom(request: request),
//         throwsA(isA<VCloudException>()),
//       );
//     });
//   });
// }