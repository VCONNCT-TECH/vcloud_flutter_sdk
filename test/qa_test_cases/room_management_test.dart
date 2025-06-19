import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_config.dart';
import '../helpers/test_utils.dart';

void main() {
  late VCloudClient client;
  late String roomId;

  setUp(() async {
    client = VCloudClient(apiKey: TestConfig.apiKey);

    // Create a test room for management tests
    roomId = await TestUtils.createTestRoom(
      client,
      name: 'Management Test Room',
      clientRoomId: TestUtils.generateUniqueClientRoomId('management-test'),
      isVideo: true,
      metadata: RoomMetadata(
        roomTitle: 'Management Test Room',
        welcomeMessage: 'Welcome to the management test room!',
      ),
    );
  });

  tearDown(() async {
    try {
      await TestUtils.cleanupRoom(client, roomId);
    } catch (e) {
      // Room might already be ended in the tests
    }
    client.close();
  });

  group('Room Management Tests', () {
    // Test for starting a room (Test Case ID: 34 adapted)
    test('Verify that the user can start a scheduled room', () async {
      // First create a scheduled room
      final scheduledRequest = TestConfig.createBasicRoomRequest(
        name: 'Scheduled Room for Starting',
        clientRoomId: TestUtils.generateUniqueClientRoomId('scheduled-start'),
      );

      final startTime = DateTime.now().add(const Duration(minutes: 30));
      final createResponse = await client.createScheduledVideoRoom(
        request: scheduledRequest,
        startAt: startTime,
      );

      final scheduledRoomId = createResponse.roomId!;

      try {
        // Now try to start the scheduled room
        // Using startScheduledRoom instead of startRoom
        final startResponse = await client.startScheduledRoom(
          request: StartRoomRequest(roomId:  scheduledRoomId , name: 'scheduled room'),
        );

        expect(startResponse.status, isTrue);

        // Verify the room is now active
        final statusResponse = await client.getRoomStatus(roomId: scheduledRoomId);
        expect(statusResponse.status, isTrue);
      } finally {
        await TestUtils.cleanupRoom(client, scheduledRoomId);
      }
    });

    // Test for ending a room
    test('Verify that the user can end an active room', () async {
      final endRequest = EndRoomRequest(roomId: roomId);
      final response = await client.endRoom(request: endRequest);

      expect(response.status, isTrue);
      expect(response.message, isNotEmpty);

      // Verify the room is no longer active
      final statusResponse = await client.getRoomStatus(roomId: roomId);
      expect(statusResponse.status, isFalse);
    });

    test('Verify that the user cannot end a non-existent room', () async {
      final endRequest = EndRoomRequest(roomId: 'non-existent-room-id');

      expect(
        () => client.endRoom(request: endRequest),
        throwsA(isA<VCloudException>()),
      );
    });
  });
}