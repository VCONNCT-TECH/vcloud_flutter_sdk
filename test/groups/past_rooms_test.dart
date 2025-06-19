// /// Tests for past rooms functionality
// library vcloud_past_rooms_test;
//
// import 'package:test/test.dart';
// import 'package:vcloud/vcloud.dart';
//
// import '../helpers/test_utils.dart';
//
// /// Tests for past rooms functionality
// void pastRoomsTests(VCloudClient client) {
//   group('Past Rooms Tests', () {
//     late List<String> roomIds;
//
//     setUp(() async {
//       // Create a few rooms that we'll end to test past rooms functionality
//       roomIds = [];
//
//       // Create and end a quick audio room
//       final audioRoomId = await TestUtils.createTestRoom(
//         client,
//         name: 'Past Audio Room',
//         clientRoomId: TestUtils.generateUniqueClientRoomId('past-audio'),
//         isVideo: false,
//         metadata: RoomMetadata(
//           roomTitle: 'Past Audio Room',
//           welcomeMessage: 'Welcome to the past audio room',
//         ),
//       );
//       await TestUtils.cleanupRoom(client, audioRoomId);
//       roomIds.add(audioRoomId);
//
//       // Create and end a quick video room
//       final videoRoomId = await TestUtils.createTestRoom(
//         client,
//         name: 'Past Video Room',
//         clientRoomId: TestUtils.generateUniqueClientRoomId('past-video'),
//         isVideo: true,
//         metadata: RoomMetadata(
//           roomTitle: 'Past Video Room',
//           welcomeMessage: 'Welcome to the past video room',
//         ),
//       );
//       await TestUtils.cleanupRoom(client, videoRoomId);
//       roomIds.add(videoRoomId);
//
//       // Create and end a scheduled room
//       final scheduledRoomId = await TestUtils.createTestRoom(
//         client,
//         name: 'Past Scheduled Room',
//         clientRoomId: TestUtils.generateUniqueClientRoomId('past-scheduled'),
//         isVideo: true,
//         metadata: RoomMetadata(
//           roomTitle: 'Past Scheduled Room',
//           welcomeMessage: 'Welcome to the past scheduled room',
//         ),
//       );
//       await TestUtils.cleanupRoom(client, scheduledRoomId);
//       roomIds.add(scheduledRoomId);
//     });
//
//     group('Fetch Past Rooms Tests', () {
//       test('Fetch past rooms by IDs', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: roomIds,
//         );
//
//         final response = await client.fetchPastRooms(request: request);
//         expect(response.status, isTrue);
//         expect(response.rooms.roomsList, isNotEmpty);
//         expect(response.rooms.roomsList.length, equals(roomIds.length));
//
//         // Verify each room is in the response
//         for (final roomId in roomIds) {
//           expect(
//             response.rooms.roomsList.any((room) => room.roomId == roomId),
//             isTrue,
//             reason: 'Room $roomId should be in the past rooms list',
//           );
//         }
//       });
//
//       test('Fetch past rooms with pagination', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: roomIds,
//           from: 0,
//           limit: 2,
//         );
//
//         final response = await client.fetchPastRooms(request: request);
//         expect(response.status, isTrue);
//         expect(response.rooms.roomsList, isNotEmpty);
//         expect(response.rooms.roomsList.length, lessThanOrEqualTo(2));
//       });
//
//       test('Fetch past rooms with ordering', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: roomIds,
//           orderBy: 'DESC',
//         );
//
//         final response = await client.fetchPastRooms(request: request);
//         expect(response.status, isTrue);
//         expect(response.rooms.roomsList, isNotEmpty);
//
//         // Verify rooms are ordered by creation time (newest first)
//         for (int i = 0; i < response.rooms.roomsList.length - 1; i++) {
//           final currentCreatedTime =
//               DateTime.parse(response.rooms.roomsList[i].created);
//           final nextCreatedTime =
//               DateTime.parse(response.rooms.roomsList[i + 1].created);
//           expect(
//             currentCreatedTime.isAfter(nextCreatedTime) ||
//                 currentCreatedTime.isAtSameMomentAs(nextCreatedTime),
//             isTrue,
//             reason: 'Rooms should be ordered by creation time (newest first)',
//           );
//         }
//       });
//
//       test('Fetch past rooms with invalid IDs', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: ['non-existent-room-1', 'non-existent-room-2'],
//         );
//
//         expect(
//           () => client.fetchPastRooms(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//         expect(
//           () => client.fetchPastRooms(request: request),
//           throwsA(predicate<VCloudException>((e) => e.statusCode == 404)),
//         );
//       });
//
//       test('Fetch past rooms with empty ID list', () async {
//         final request = FetchPastRoomsRequest(
//           roomIds: [],
//         );
//
//         expect(
//           () => client.fetchPastRooms(request: request),
//           throwsA(isA<VCloudException>()),
//         );
//       });
//     });
//   });
// }
