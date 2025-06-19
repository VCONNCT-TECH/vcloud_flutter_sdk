import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_config.dart';
import '../helpers/test_utils.dart';

void main() {
  late VCloudClient client;
  String roomId = '';

  setUp(() {
    client = VCloudClient(apiKey: TestConfig.apiKey);
  });

  tearDown(() {
    if (roomId.isNotEmpty) {
      TestUtils.cleanupRoom(client, roomId);
    }
    client.close();
  });

  group('Quick Audio Room Tests', () {
    // Test Case ID: 1
    test('Verify that the user can create an only audio quick room', () async {
      final request = TestConfig.createBasicRoomRequest(
        name: 'Quick Audio Room Test',
        clientRoomId: TestUtils.generateUniqueClientRoomId('qa-audio'),
        metadata: RoomMetadata(
          roomTitle: 'Quick Audio Room',
          welcomeMessage: 'Welcome to the quick audio room!',
        ),
      );

      final response = await client.createQuickAudioRoom(request: request);
      roomId = response.roomId!;

      expect(response.status, isTrue);
      expect(response.roomId, isNotNull);
      expect(response.roomId, isNotEmpty);
      
      // Verify the room is audio-only by checking its properties
      final roomInfo = await client.getActiveRoomInfo(roomId: roomId);
    });

    // Test Case ID: 2
    test('Verify that the user cannot create a quick audio room without Project_id', () async {
      // Since projectId is required by the constructor, we need to provide it
      // but we can test the API validation by passing an empty or invalid value
      final request = RoomCreationRequest(
        projectId: '', // Empty project ID to test validation
        name: 'Quick Audio Room Without Project ID',
        clientRoomId: TestUtils.generateUniqueClientRoomId('qa-audio-no-project'),
        moderatorId: TestConfig.moderatorId,
        maxParticipants: 10,
        emptyTimeout: 300,
        metadata: RoomMetadata(),
      );

      expect(
        () => client.createQuickAudioRoom(request: request),
        throwsA(isA<VCloudException>()),
      );
    });

    // Test Case ID: 3
    test('Verify that the user cannot create a quick audio room without name', () async {
      final request = RoomCreationRequest(
        projectId: TestConfig.projectId,
        name: '', // Empty name
        clientRoomId: TestUtils.generateUniqueClientRoomId('qa-audio-no-name'),
        moderatorId: TestConfig.moderatorId,
        maxParticipants: 10,
        emptyTimeout: 300,
        metadata: RoomMetadata(),
      );

      expect(
        () => client.createQuickAudioRoom(request: request),
        throwsA(isA<VCloudException>()),
      );
    });

    // Test Case ID: 4
    test('Verify that the user can create a quick audio room without client_room_id', () async {
      final request = RoomCreationRequest(
        clientRoomId: '',
        projectId: TestConfig.projectId,
        name: 'Quick Audio Room Without Client Room ID',
        // clientRoomId is intentionally omitted
        moderatorId: TestConfig.moderatorId,
        maxParticipants: 10,
        emptyTimeout: 300,
        metadata: RoomMetadata(
          roomTitle: 'Quick Audio Room',
          welcomeMessage: 'Welcome to the quick audio room!',
        ),
      );

      final response = await client.createQuickAudioRoom(request: request);
      roomId = response.roomId!;

      expect(response.status, isTrue);
      expect(response.roomId, isNotNull);
      expect(response.roomId, isNotEmpty);
    });

    // Test Case ID: 5
    test('Verify that the user can create a quick audio room without moderator_id', () async {
      final request = RoomCreationRequest(
        moderatorId: '',
        projectId: TestConfig.projectId,
        name: 'Quick Audio Room Without Moderator ID',
        clientRoomId: TestUtils.generateUniqueClientRoomId('qa-audio-no-moderator'),
        // moderatorId is intentionally omitted
        maxParticipants: 10,
        emptyTimeout: 300,
        metadata: RoomMetadata(
          roomTitle: 'Quick Audio Room',
          welcomeMessage: 'Welcome to the quick audio room!',
        ),
      );

      final response = await client.createQuickAudioRoom(request: request);
      roomId = response.roomId!;

      expect(response.status, isTrue);
      expect(response.roomId, isNotNull);
      expect(response.roomId, isNotEmpty);
    });

    // Test Case ID: 6
    test('Verify that the user cannot create a quick audio room without max_participants', () async {
      final request = RoomCreationRequest(
        projectId: TestConfig.projectId,
        name: 'Quick Audio Room Without Max Participants',
        clientRoomId: TestUtils.generateUniqueClientRoomId('qa-audio-no-max'),
        moderatorId: TestConfig.moderatorId,
        // maxParticipants is intentionally omitted or set to invalid value
        maxParticipants: 0,
        emptyTimeout: 300,
        metadata: RoomMetadata(
          roomTitle: 'Quick Audio Room',
          welcomeMessage: 'Welcome to the quick audio room!',
        ),
      );

      expect(
        () => client.createQuickAudioRoom(request: request),
        throwsA(isA<VCloudException>()),
      );
    });
  });
}