// /// Tests for error handling functionality
// library vcloud_error_handling_test;
//
// import 'package:test/test.dart';
// import 'package:vcloud/vcloud.dart';
// import '../helpers/test_config.dart';
// import '../helpers/test_utils.dart';
//
// /// Tests for error handling functionality
// void errorHandlingTests(VCloudClient client) {
//   group('Error Handling Tests', () {
//     group('Invalid API Key Tests', () {
//       late VCloudClient invalidClient;
//
//       setUp(() {
//         invalidClient = VCloudClient(apiKey: 'invalid-api-key');
//       });
//
//       tearDown(() {
//         invalidClient.close();
//       });
//
//       test('Create room with invalid API key', () async {
//         final request = RoomCreationRequest(
//           projectId: TestConfig.projectId,
//           name: 'Invalid API Key Test',
//           clientRoomId: TestUtils.generateUniqueClientRoomId('invalid-api'),
//           moderatorId: TestConfig.moderatorId,
//           maxParticipants: 10,
//           emptyTimeout: 300,
//           metadata: RoomMetadata(),
//         );
//
//         expect(
//           () => invalidClient.createQuickVideoRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Get room status with invalid API key', () async {
//         expect(
//           () => invalidClient.getRoomStatus(roomId: 'any-room-id'),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Join room with invalid API key', () async {
//         final request = JoinRoomRequest(
//           roomId: 'any-room-id',
//           userInfo: UserInfo(name: 'Test User'),
//         );
//
//         expect(
//           () => invalidClient.joinRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//     });
//
//     group('Invalid Room ID Tests', () {
//       test('Get status of non-existent room', () async {
//          expect(
//           () => client.getRoomStatus(roomId: 'non-existent-room'),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Join non-existent room', () async {
//         final request = JoinRoomRequest(
//           roomId: 'non-existent-room',
//           userInfo: UserInfo(name: 'Test User'),
//         );
//
//         expect(
//           () => client.joinRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('End non-existent room', () async {
//         final request = EndRoomRequest(roomId: 'non-existent-room');
//         expect(
//           () => client.endRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Get analytics for non-existent room', () async {
//         expect(
//           () => client.getAnalytics(roomId: 'non-existent-room'),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Get recordings for non-existent room', () async {
//         expect(
//           () => client.getRecording(roomId: 'non-existent-room'),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//     });
//
//     group('Invalid Request Tests', () {
//       test('Create room with empty name', () async {
//         final request = RoomCreationRequest(
//           projectId: TestConfig.projectId,
//           name: '',
//           clientRoomId: TestUtils.generateUniqueClientRoomId('empty-name'),
//           moderatorId: TestConfig.moderatorId,
//           maxParticipants: 10,
//           emptyTimeout: 300,
//           metadata: RoomMetadata(),
//         );
//
//         expect(
//           () => client.createQuickVideoRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Create room with invalid max participants', () async {
//         final request = RoomCreationRequest(
//           projectId: TestConfig.projectId,
//           name: 'Invalid Max Participants Test',
//           clientRoomId: TestUtils.generateUniqueClientRoomId('invalid-max'),
//           moderatorId: TestConfig.moderatorId,
//           maxParticipants: 0, // Invalid value
//           emptyTimeout: 300,
//           metadata: RoomMetadata(),
//         );
//
//         expect(
//           () => client.createQuickVideoRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Create scheduled room with past start time', () async {
//         final request = RoomCreationRequest(
//           projectId: TestConfig.projectId,
//           name: 'Past Start Time Test',
//           clientRoomId: TestUtils.generateUniqueClientRoomId('past-start'),
//           moderatorId: TestConfig.moderatorId,
//           maxParticipants: 10,
//           emptyTimeout: 300,
//           metadata: RoomMetadata(),
//         );
//         expect(
//           () => client.createScheduledVideoRoom(
//             request: request,
//             startAt: DateTime.now().subtract(const Duration(hours: 1)),
//           ),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Join room with empty user name', () async {
//         final request = JoinRoomRequest(
//           roomId: 'any-room-id',
//           userInfo: UserInfo(name: ''),
//         );
//
//         expect(
//           () => client.joinRoom(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Create invitation link with invalid role', () async {
//         // Note: This test is not possible since InvitationRole is an enum
//         // and Dart's type system prevents invalid enum values at compile time.
//         // Instead, we'll test that both valid roles work correctly.
//         final adminRequest = CreateInvitationRequest(
//           roomId: 'any-room-id',
//           role: InvitationRole.admin,
//         );
//
//         final viewerRequest = CreateInvitationRequest(
//           roomId: 'any-room-id',
//           role: InvitationRole.viewer,
//         );
//
//         expect(
//           () => client.createInvitationLink(request: adminRequest),
//           throwsA(isA<VCloudException>()),
//         );
//
//         expect(
//           () => client.createInvitationLink(request: viewerRequest),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Fetch past rooms with empty ID list', () async {
//         final request = FetchPastRoomsRequest(roomIds: []);
//
//         expect(
//           () => client.fetchPastRooms(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//
//       test('Fetch past rooms with invalid pagination', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: ['any-room-id'],
//           from: -1, // Invalid value
//           limit: 0, // Invalid value
//         );
//
//         expect(
//           () => client.fetchPastRooms(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//     });
//
//   });
// }