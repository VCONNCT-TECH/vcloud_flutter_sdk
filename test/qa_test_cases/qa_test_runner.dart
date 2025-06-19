import 'package:test/test.dart';
import 'package:vcloud/vcloud.dart';

import '../helpers/test_config.dart';
import 'quick_audio_room_test.dart' as quick_audio_room;
import 'quick_video_room_test.dart' as quick_video_room;
import 'room_joining_test.dart' as room_joining;
import 'room_management_test.dart' as room_management;

void main() {
  group('VCloud QA Test Cases', () {
    test('VCloud API Connection Test', () {
      final client = VCloudClient(apiKey: TestConfig.apiKey);
      expect(client, isNotNull);
      client.close();
    });
    
    group('Quick Audio Room Tests', quick_audio_room.main);
    group('Quick Video Room Tests', quick_video_room.main);
    group('Room Joining Tests', room_joining.main);
    // group('Room Management Tests', room_management.main);
  });
}