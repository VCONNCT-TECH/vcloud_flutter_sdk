/// Common test utilities for V.cloud SDK tests
library vcloud_test_utils;

import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import 'test_config.dart';

/// Common test utilities
class TestUtils {
  /// Creates a test room and returns its ID
  static Future<String> createTestRoom(
    VCloudClient client, {
    required String name,
    required String clientRoomId,
    bool isVideo = true,
    required RoomMetadata? metadata,
  }) async {
    final request = TestConfig.createBasicRoomRequest(
      name: name,
      clientRoomId: clientRoomId,
      metadata: metadata,
    );

    final response = isVideo
        ? await client.createQuickVideoRoom(request: request)
        : await client.createQuickAudioRoom(request: request);

    expect(response.status, isTrue);
    expect(response.roomId, isNotNull);
    return response.roomId!;
  }

  /// Creates a test room and joins it with a user
  static Future<(String, String)> createAndJoinTestRoom(
    VCloudClient client, {
    required String name,
    required String clientRoomId,
    required String userName,
    bool isVideo = true,
    bool isAdmin = true,
    bool isHidden = false,
    RoomMetadata? metadata,
  }) async {
    final roomId = await createTestRoom(
      client,
      name: name,
      clientRoomId: clientRoomId,
      isVideo: isVideo,
      metadata: metadata,
    );

    final joinRequest = JoinRoomRequest(
      roomId: roomId,
      userInfo: TestConfig.createUserInfo(
        name: userName,
        isAdmin: isAdmin,
        isHidden: isHidden,
      ),
    );

    final joinResponse = await client.joinRoom(request: joinRequest);
    expect(joinResponse.status, isTrue);
    expect(joinResponse.finalLink, isNotNull);

    return (roomId, joinResponse.finalLink!);
  }

  /// Cleans up a room by ending it
  static Future<void> cleanupRoom(VCloudClient client, String roomId) async {
    try {
      await client.endRoom(request: EndRoomRequest(roomId: roomId));
    } catch (e) {
      print('Warning: Failed to clean up room $roomId: $e');
    }
  }

  /// Generates a unique client room ID
  static String generateUniqueClientRoomId(String prefix) {
    return '$prefix-${DateTime.now().millisecondsSinceEpoch}';
  }
}
