/// Tests for room creation functionality
library vcloud_room_creation_test;

import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_config.dart';
import '../helpers/test_utils.dart';

// Test group for room creation
void main() {
  late VCloudClient client;
  String roomId = '';

  setUp(() {
    client = VCloudClient(apiKey: TestConfig.apiKey);
    roomId = TestUtils.generateUniqueClientRoomId('test-room');
  });

  tearDown(() {
    client.close();
  });

  // Run room creation tests
  group('Room Creation Tests', () {
    tearDown(() async {
      if (roomId.isNotEmpty) {
        try {
          await TestUtils.cleanupRoom(client, roomId);
        } catch (e) {
          // Ignore cleanup errors if room doesn't exist
          if (e is VCloudException && e.statusCode == 404) {
            print('Warning: Room $roomId not found during cleanup');
          } else {
            rethrow;
          }
        }
      }
    });

    group('Quick Audio Room Tests', () {
      test('Create quick audio room with minimal settings', () async {
        final request = TestConfig.createBasicRoomRequest(
          name: 'Quick Audio Room',
          clientRoomId: TestUtils.generateUniqueClientRoomId('quick-audio'),
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

      test('Create quick audio room with full settings', () async {
        final metadata = TestConfig.createRoomMetadata(
          roomTitle: 'Test Audio Room',
          welcomeMessage: 'Welcome to the test room!',
        );

        final request = TestConfig.createBasicRoomRequest(
          name: 'Quick Audio Room Full',
          clientRoomId:
              TestUtils.generateUniqueClientRoomId('quick-audio-full'),
          maxParticipants: 20,
          emptyTimeout: 600,
          metadata: metadata,
        );

        final response = await client.createQuickAudioRoom(request: request);
        roomId = response.roomId!;

        expect(response.status, isTrue);
        expect(response.roomId, isNotNull);
        expect(response.roomId, isNotEmpty);
      });
    });

    group('Quick Video Room Tests', () {
      test('Create quick video room with minimal settings', () async {
        final request = TestConfig.createBasicRoomRequest(
          name: 'Quick Video Room',
          clientRoomId: TestUtils.generateUniqueClientRoomId('quick-video'),
          metadata: RoomMetadata(
            roomTitle: 'Quick Video Room',
            welcomeMessage: 'Welcome to the quick video room!',
          ),
        );

        final response = await client.createQuickVideoRoom(request: request);
        roomId = response.roomId!;

        expect(response.status, isTrue);
        expect(response.roomId, isNotNull);
        expect(response.roomId, isNotEmpty);
      });

      test('Create quick video room with full settings', () async {
        final metadata = TestConfig.createRoomMetadata(
          roomTitle: 'Test Video Room',
          welcomeMessage: 'Welcome to the video test room!',
        );

        final request = TestConfig.createBasicRoomRequest(
          name: 'Quick Video Room Full',
          clientRoomId:
              TestUtils.generateUniqueClientRoomId('quick-video-full'),
          maxParticipants: 20,
          emptyTimeout: 600,
          metadata: metadata,
        );

        final response = await client.createQuickVideoRoom(request: request);
        roomId = response.roomId!;

        expect(response.status, isTrue);
        expect(response.roomId, isNotNull);
        expect(response.roomId, isNotEmpty);
      });
    });

    group('Scheduled Room Tests', () {
      test('Create scheduled audio room with immediate start', () async {
        final request = TestConfig.createBasicRoomRequest(
          name: 'Scheduled Audio Room',
          clientRoomId: TestUtils.generateUniqueClientRoomId('scheduled-audio'),
          metadata: RoomMetadata(
            roomTitle: 'Scheduled Audio Room',
            welcomeMessage: 'Welcome to the scheduled audio room!',
          ),
        );

        final startTime = DateTime.now().add(const Duration(minutes: 1));
        final response = await client.createScheduledAudioRoom(
          request: request,
          startAt: startTime,
        );
        roomId = response.roomId!;

        expect(response.status, isTrue);
        expect(response.roomId, isNotNull);
        expect(response.roomId, isNotEmpty);
        expect(response.startTime?.year, equals(startTime.year));
        expect(response.startTime?.month, equals(startTime.month));
        expect(response.startTime?.day, equals(startTime.day));
        expect(response.startTime?.hour, equals(startTime.hour));
        expect(response.startTime?.minute, equals(startTime.minute));
      });

      test('Create scheduled video room with future start time', () async {
        final request = TestConfig.createBasicRoomRequest(
          name: 'Future Video Room',
          clientRoomId: TestUtils.generateUniqueClientRoomId('scheduled-video'),
          metadata: RoomMetadata(
            roomTitle: 'Future Video Room',
            welcomeMessage: 'Welcome to the future video room!',
          ),
        );

        final startTime = DateTime.now().add(const Duration(hours: 1));
        final response = await client.createScheduledVideoRoom(
          request: request,
          startAt: startTime,
        );
        roomId = response.roomId!;

        expect(response.status, isTrue);
        expect(response.roomId, isNotNull);
        expect(response.roomId, isNotEmpty);
        expect(response.startTime?.add(Duration(hours: 1)).year,
            equals(startTime.year));
      });

      test('Create scheduled room with past start time should fail', () async {
        final request = TestConfig.createBasicRoomRequest(
          name: 'Past Video Room',
          clientRoomId: TestUtils.generateUniqueClientRoomId('past-video'),
        );

        expect(
          () => client.createScheduledVideoRoom(
            request: request,
            startAt: DateTime.now().subtract(const Duration(hours: 1)),
          ),
          throwsA(isA<VCloudException>().having(
            (e) => e.message,
            'message',
            'Start time must be in the future',
          )),
        );
      });
    });
  });
}
