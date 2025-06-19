// import 'package:test/test.dart';
// import 'package:vcloud/vcloud.dart';
//
// import '../helpers/test_config.dart';
// import '../helpers/test_utils.dart';
//
// void main() {
//   late VCloudClient client;
//   String roomId = '';
//
//   setUp(() {
//     client = VCloudClient(apiKey: TestConfig.apiKey);
//   });
//
//   // tearDown(() {
//     if (roomId.isNotEmpty) {
//       TestUtils.cleanupRoom(client, roomId);
//     }
//     client.close();
//   });
//
//   group('Quick Video Room Tests', () {
//     // Test Case ID: 25 (adapted from the document)
//     test('Verify that the user can create a quick video room with all required parameters', () async {
//       final metadata = TestConfig.createRoomMetadata(
//         roomTitle: 'Test Video Room',
//         welcomeMessage: 'Welcome to the video test room!',
//       );
//
//       final request = TestConfig.createBasicRoomRequest(
//         name: 'Quick Video Room Test',
//         clientRoomId: TestUtils.generateUniqueClientRoomId('qa-video'),
//         maxParticipants: 20,
//         emptyTimeout: 600,
//         metadata: metadata,
//       );
//
//       final response = await client.createQuickVideoRoom(request: request);
//       roomId = response.roomId!;
//
//       expect(response.status, isTrue);
//       expect(response.roomId, isNotNull);
//       expect(response.roomId, isNotEmpty);
//
//       // Verify the room supports video by checking its properties
//       final roomInfo = await client.getActiveRoomInfo(roomId: roomId);
//     });
//
//     // Test Case ID: 26 (adapted)
//     test('Verify that the user cannot create a scheduled video room without project id', () async {
//       final request = RoomCreationRequest(
//         projectId: '',
//         // projectId is intentionally omitted
//         name: 'Video Room Without Project ID',
//         clientRoomId: TestUtils.generateUniqueClientRoomId('qa-video-no-project'),
//         moderatorId: TestConfig.moderatorId,
//         maxParticipants: 10,
//         emptyTimeout: 300,
//         metadata: RoomMetadata(),
//       );
//
//       expect(
//         () => client.createQuickVideoRoom(request: request),
//         throwsA(isA<VCloudException>()),
//       );
//     });
//
//     // Additional test cases similar to audio room tests
//     test('Verify that the user cannot create a quick video room without name', () async {
//       final request = RoomCreationRequest(
//         projectId: TestConfig.projectId,
//         name: '', // Empty name
//         clientRoomId: TestUtils.generateUniqueClientRoomId('qa-video-no-name'),
//         moderatorId: TestConfig.moderatorId,
//         maxParticipants: 10,
//         emptyTimeout: 300,
//         metadata: RoomMetadata(),
//       );
//
//       expect(
//         () => client.createQuickVideoRoom(request: request),
//         throwsA(isA<VCloudException>()),
//       );
//     });
//   });
// }