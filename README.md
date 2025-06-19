# V.cloud Flutter SDK

A Flutter SDK for the V.cloud API, providing tools for building virtual collaboration solutions.
This SDK simplifies integration with V.cloud services,
allowing developers to easily manage audio/video conferencing rooms, monitor status, 
and handle API interactions with type-safe objects and proper error handling.


## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Initialize the Client](#initialize-the-client)
- [Usage](#usage)
  - [Room Management](#room-management)
    - [Create a Quick Audio Room](#create-a-quick-audio-room)
    - [Create a Quick Video Room](#create-a-quick-video-room)
    - [Create a Scheduled Audio Room](#create-a-scheduled-audio-room)
    - [Create a Scheduled Video Room](#create-a-scheduled-video-room)
    - [Start a Scheduled Room](#start-a-scheduled-room)
    - [Join a Room](#join-a-room)
    - [Create an Invitation Link](#create-an-invitation-link)
    - [End a Room](#end-a-room)
  - [Room Information](#room-information)
    - [Check Room Status](#check-room-status)
    - [Get Active Room Information](#get-active-room-information)
    - [Get All Active Rooms Information](#get-all-active-rooms-information)
    - [Fetch Past Rooms Information](#fetch-past-rooms-information)
  - [Recordings and Analytics](#recordings-and-analytics)
    - [Get Room Recordings](#get-room-recordings)
    - [Get Room Analytics](#get-room-analytics)
- [Error Handling](#error-handling)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Comprehensive Room Management**: Create, schedule, start, and end audio/video conferencing rooms
- **Real-time Monitoring**: Check room status and get active room information
- **Participant Management**: Join rooms, create invitation links, and manage participant roles
- **Data Retrieval**: Fetch information about past rooms, recordings, and analytics
- **Type-Safe API Client**: Ensures compile-time checks and reduces runtime errors
- **Simplified Error Handling**: Custom exception class `VCloudException` for easier error management
- **Asynchronous Operations**: All API calls return `Future` objects for non-blocking execution

## Getting Started

### Prerequisites

- Flutter SDK installed
- A V.cloud API Key (obtain from your V.cloud dashboard)

### Installation

1. Add the `vcloud` package to your `pubspec.yaml`:

```yaml
dependencies:
  vcloud: ^latest # Replace with the latest version
```

2. Install the package:

```bash
flutter pub get
```

### Initialize the Client

Create a single instance of `VCloudClient` to use throughout your application:

```dart
import 'package:vcloud/vcloud.dart';

final VCloudClient client = VCloudClient(
  apiKey: 'YOUR_API_KEY_HERE',
  baseUrl: 'https://v.cloudapi.vconnct.me', // Optional: if you have a custom endpoint
);
```

## Usage

### Room Management

#### Create a Quick Audio Room

```dart
final request = RoomCreationRequest(
  projectId: 'your-project-id',
  name: 'Instant Audio Meet',
  clientRoomId: 'audio-room-001', // Optional: unique ID for your reference
  moderatorId: 'user-moderator-id',
  maxParticipants: 10,
  emptyTimeout: 300, // Room closes after 5 minutes if empty
  metadata: RoomMetadata(
    roomTitle: 'Quick Sync',
    welcomeMessage: 'Welcome to our quick audio sync!',
  ),
);

try {
  final response = await client.createQuickAudioRoom(request: request);
  if (response.status) {
    print('Audio Room created successfully!');
    print('Room ID: ${response.roomId}');
    print('Join URL: ${response.finalLink}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Create a Quick Video Room

```dart
final request = RoomCreationRequest(
  projectId: 'your-project-id',
  name: 'Instant Video Meet',
  clientRoomId: 'video-room-001',
  moderatorId: 'user-moderator-id',
  maxParticipants: 15,
  emptyTimeout: 600,
  metadata: RoomMetadata(
    roomTitle: 'Project Brainstorm',
    welcomeMessage: 'Welcome! Let's brainstorm.',
  ),
);

try {
  final response = await client.createQuickVideoRoom(request: request);
  if (response.status) {
    print('Video Room created successfully!');
    print('Room ID: ${response.roomId}');
    print('Join URL: ${response.finalLink}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Create a Scheduled Audio/Video Room

```dart
// Schedule for 1 hour from now
final startTime = DateTime.now().add(Duration(hours: 1));

final request = RoomCreationRequest(
  projectId: 'your-project-id',
  name: 'Scheduled Meeting',
  clientRoomId: 'scheduled-room-001',
  moderatorId: 'user-moderator-id',
  maxParticipants: 20,
  metadata: RoomMetadata(
    roomTitle: 'Team Meeting',
    welcomeMessage: 'Welcome to our scheduled meeting!',
  ),
);

try {
  // For audio room
  final audioResponse = await client.createScheduledAudioRoom(
    request: request,
    startAt: startTime,
  );
  
  // For video room
  final videoResponse = await client.createScheduledVideoRoom(
    request: request,
    startAt: startTime,
  );
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Start a Scheduled Room

```dart
final startRequest = StartRoomRequest(
  roomId: 'scheduled-room-id',
  name: 'Moderator Name',
);

try {
  final response = await client.startScheduledRoom(request: startRequest);
  if (response.status) {
    print('Room started successfully!');
    print('Join URL: ${response.finalLink}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Join a Room

```dart
final joinRequest = JoinRoomRequest(
  roomId: 'room-id',
  userInfo: UserInfo(
    name: 'John Doe',
    // Optional: clientUserId: 'unique-user-id'
  ),
);

try {
  final response = await client.joinRoom(request: joinRequest);
  if (response.status) {
    print('Join URL: ${response.finalLink}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Create an Invitation Link

```dart
try {
  // Create a viewer invitation (reusable)
  final viewerInviteRequest = CreateInvitationRequest(
    roomId: 'room-id',
    role: InvitationRole.viewer,
  );
  final viewerResponse = await client.createInvitationLink(request: viewerInviteRequest);
  
  // Create an admin invitation (one-time use)
  final adminInviteRequest = CreateInvitationRequest(
    roomId: 'room-id',
    role: InvitationRole.admin,
  );
  final adminResponse = await client.createInvitationLink(request: adminInviteRequest);
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### End a Room

```dart
final endRoomRequest = EndRoomRequest(
  roomId: 'room-id',
);

try {
  final response = await client.endRoom(request: endRoomRequest);
  if (response.status) {
    print('Room ended successfully');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

### Room Information

#### Check Room Status

```dart
try {
  final statusResponse = await client.getRoomStatus(roomId: 'room-id');
  if (statusResponse.status) {
    print('Room is active/exists');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Get Active Room Information

```dart
try {
  final response = await client.getActiveRoomInfo(roomId: 'room-id');
  if (response.status && response.room != null) {
    final room = response.room!;
    print('Room Name: ${room.name}');
    print('Participants: ${room.currentParticipants}/${room.maxParticipants}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Get All Active Rooms

```dart
try {
  final response = await client.getActiveRoomsInfo();
  if (response.status) {
    print('Total active rooms: ${response.rooms.length}');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Fetch Past Rooms

```dart
final fetchRequest = FetchPastRoomsRequest(
  roomIds: ['room-id-1', 'room-id-2'], // Optional
);

try {
  final response = await client.fetchPastRooms(request: fetchRequest);
  if (response.status) {
    print('Fetched ${response.rooms.length} past rooms');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

### Recordings and Analytics

#### Get Room Recordings

```dart
try {
  final response = await client.getRecording(roomId: 'room-id');
  if (response.status && response.recordings.isNotEmpty) {
    for (final recording in response.recordings) {
      print('Recording URL: ${recording.url}');
    }
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

#### Get Room Analytics

```dart
try {
  final analytics = await client.getAnalytics(roomId: 'room-id');
  if (analytics != null) {
    // Analytics data is returned as a Map<String, dynamic>
    print('Analytics Data:');

    // Access participant details if available
    if (analytics['participant_durations'] != null) {
      print('\nParticipant Details:');
      final participantDurations = analytics['participant_durations'] as Map<String, dynamic>;
      participantDurations.forEach((participantId, duration) {
        print('Participant $participantId: $duration seconds');
      });
    }
  } else {
    print('No analytics data available for this room');
  }
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
}
```

## Error Handling

All API calls can throw a `VCloudException`. Handle errors appropriately:

```dart
try {
  // Make an API call
  final response = await client.someApiCall(...);
  // Process successful response
} on VCloudException catch (e) {
  print('API Error: ${e.message}');
  if (e.statusCode != null) {
    print('Status Code: ${e.statusCode}');
  }
  if (e.response != null) {
    print('Server Response: ${e.response}');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This SDK is distributed under the MIT License. See `LICENSE` file for more information.
