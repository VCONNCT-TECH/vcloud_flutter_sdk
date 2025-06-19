/// Tests for recording functionality
library vcloud_recording_test;

import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_utils.dart';

/// Tests for recording functionality
void recordingTests(VCloudClient client) {
  group('Recording Tests', () {
    late String roomId;

    setUp(() async {
      // Create a room for recording tests
      roomId = await TestUtils.createTestRoom(
        client,
        name: 'Recording Test Room',
        clientRoomId: TestUtils.generateUniqueClientRoomId('recording'),
        isVideo: true,
        metadata: RoomMetadata(
          roomTitle: 'Analytics Test Room',
          welcomeMessage: 'Welcome to the Analytics Test Room',
        ),
      );
    });

    tearDown(() async {
      // Clean up the test room
      await client.endRoom(request: EndRoomRequest(roomId: roomId));
    });

    group('Get Room Recordings Tests', () {
      test('Get recordings for non-existent room', () async {
        expect(
          () => client.getRecording(roomId: 'non-existent-room'),
          throwsA(isA<VCloudException>()),
        );
      });

      test('Get recordings with invalid room ID format', () async {
        expect(
          () => client.getRecording(roomId: ''),
          throwsA(isA<VCloudException>()),
        );
      });
    });
  });
}
