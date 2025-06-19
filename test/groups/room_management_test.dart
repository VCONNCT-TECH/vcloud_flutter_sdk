/// Tests for room management functionality
library vcloud_room_management_test;

import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_config.dart';
import '../helpers/test_utils.dart';

void main() {
  late VCloudClient client;

  setUp(() {
    client = VCloudClient(apiKey: TestConfig.apiKey);
  });

  tearDown(() {
    client.close();
  });
  group('Room Management Tests', () {
    late String roomId;

    setUp(() async {
      // Create a room for testing management operations
      final (id, url) = await TestUtils.createAndJoinTestRoom(
        client,
        name: 'Management Test Room',
        clientRoomId: TestUtils.generateUniqueClientRoomId('management-test'),
        userName: 'Test Admin',
        isAdmin: true,
        metadata: TestConfig.createRoomMetadata(
          roomTitle: 'Management Test Room',
          welcomeMessage: 'Welcome to the management test room!',
        ),
      );
      roomId = id;
    });

    tearDown(() async {
      await TestUtils.cleanupRoom(client, roomId);
    });

    group('Room Status Tests', () {
      test('Get room status for active room', () async {
        final response = await client.getRoomStatus(roomId: roomId);
        expect(response.status, isTrue);
        expect(response.message, isNotEmpty);
      });

      test('Get room status for non-existent room', () async {
        expect(
          () => client.getRoomStatus(roomId: 'non-existent-room'),
          throwsA(isA<VCloudException>()),
        );
      });
    });

    group('Room Joining Tests', () {
      test('Join room as admin', () async {
        final request = JoinRoomRequest(
          roomId: roomId,
          userInfo: TestConfig.createUserInfo(
            name: 'Admin User',
            isAdmin: true,
          ),
        );

        final response = await client.joinRoom(request: request);
        expect(response.status, isTrue);
        expect(response.finalLink, isNotNull);
       });

      test('Join room as viewer', () async {
        final request = JoinRoomRequest(
          roomId: roomId,
          userInfo: TestConfig.createUserInfo(
            name: 'Viewer User',
            isAdmin: false,
          ),
        );

        final response = await client.joinRoom(request: request);
        expect(response.status, isTrue);
        expect(response.finalLink, isNotNull);
       });

      test('Join room as hidden user', () async {
        final request = JoinRoomRequest(
          roomId: roomId,
          userInfo: TestConfig.createUserInfo(
            name: 'Hidden User',
            isHidden: true,
          ),
        );

        final response = await client.joinRoom(request: request);
        expect(response.status, isTrue);
        expect(response.finalLink, isNotNull);
      });
    });

    group('Invitation Link Tests', () {
      test('Create admin invitation link', () async {
        final request = CreateInvitationRequest(
          roomId: roomId,
          role: InvitationRole.admin,
        );

        final response = await client.createInvitationLink(request: request);
         expect(response.invitationUrl, isNotNull);
       });

      test('Create viewer invitation link', () async {
        final request = CreateInvitationRequest(
          roomId: roomId,
          role: InvitationRole.viewer,
        );

        final response = await client.createInvitationLink(request: request);
         expect(response.invitationUrl, isNotNull);
       });
    });

    group('Room Information Tests', () {
      test('Get active room info', () async {
        final response = await client.getActiveRoomInfo(roomId: roomId);
        expect(response.status, isTrue);
        expect(response.room, isNotNull);
        expect(response.room!.participants, isNotEmpty);
        expect(response.room!.participants.first.name, equals('Test Admin'));
       });

      test('Get all active rooms info', () async {
        final response = await client.getActiveRoomsInfo();
        expect(response.status, isTrue);
        expect(response.rooms, isNotNull);
        expect(response.rooms, isNotEmpty);
      });
    });

    group('Room Ending Tests', () {
      test('End active room', () async {
        final request = EndRoomRequest(roomId: roomId);
        final response = await client.endRoom(request: request);
        expect(response.status, isTrue);
        expect(response.message, isNotEmpty);

        // Verify room is no longer active
        final statusResponse = await client.getRoomStatus(roomId: roomId);
        expect(statusResponse.status, isFalse);
      });

      test('End non-existent room', () async {
        final request = EndRoomRequest(roomId: 'non-existent-room');
        expect(
          () => client.endRoom(request: request),
          throwsA(isA<VCloudException>()),
        );
      });
    });
  });
}
