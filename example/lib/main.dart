import 'package:example/ui.dart';
import 'package:flutter/material.dart';
import 'package:vcloud/vcloud.dart';

final VCloudClient client = VCloudClient(
  apiKey: 'your_api_key_here',
  baseUrl: 'your_base_url_here',
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VCloudHomeController(),
    );
  }
}

class VCloudHomeController extends StatefulWidget {
  const VCloudHomeController({super.key});

  @override
  State<VCloudHomeController> createState() => VCloudHomeState();
}

class VCloudHomeState extends State<VCloudHomeController> {
  @override
  Widget build(BuildContext context) {
    return VcloudHomeUi(state: this);
  }

  final TextEditingController clientRoomIdController = TextEditingController();

  final TextEditingController projectIDController =
      TextEditingController(text: 'exampleProjectID123');

  final TextEditingController moderatorIdController =
      TextEditingController(text: 'userID165');

  final TextEditingController apiKeyController =
      TextEditingController(text: client.apiKey);

  final TextEditingController baseUrlController =
      TextEditingController(text: client.baseUrl);

  final TextEditingController currentRoomIdController =
      TextEditingController(text: '');

  String? joinUrl;
  String statusMessage = '';
  bool isLoading = false;

  RoomCreationRequest request({
    required String kind,
  }) =>
      RoomCreationRequest(
        projectId: projectIDController.text,
        moderatorId: moderatorIdController.text,
        clientRoomId: clientRoomIdController.text.isNotEmpty
            ? clientRoomIdController.text
            : null,
        name: 'john doe',
        maxParticipants: 10,
        emptyTimeout: 300,
        metadata: RoomMetadata(
          roomTitle: 'room ${kind}ID3333',
          welcomeMessage: 'Welcome to our room!',
        ),
      );

  ///logic
  ///
  // 1 Create a quick audio room
  Future<void> createQuickAudioRoom() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Creating quick audio room...';
    });

    try {
      final response =
          await client.createQuickAudioRoom(request: request(kind: 'audio_'));
      // Inside createQuickAudioRoom method
      if (response.status) {
        setState(() {
          currentRoomIdController.text = response.roomId ?? '';
          joinUrl = response.finalLink;
          statusMessage =
              'Audio Room created successfully! Room ID: ${response.roomId}';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to create audio room: ${response.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - createQuickAudioRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 2 Create a quick video room
  Future<void> createQuickVideoRoom() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Creating quick video room...';
    });

    try {
      final response =
          await client.createQuickVideoRoom(request: request(kind: 'video_'));
      if (response.status) {
        setState(() {
          currentRoomIdController.text = response.roomId ?? '';
          joinUrl = response.finalLink;
          statusMessage =
              'Video Room created successfully! Room ID: ${response.roomId}';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to create video room: ${response.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - createQuickVideoRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 3 Create a scheduled audio room
  Future<void> createScheduledAudioRoom() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Creating scheduled audio room...';
    });

    // Schedule for 1 hour from now
    final startTime = DateTime.now().add(Duration(hours: 1));

    try {
      final response = await client.createScheduledAudioRoom(
        request: request(kind: 'scheduled_audio_'),
        startAt: startTime,
      );
      if (response.status) {
        setState(() {
          currentRoomIdController.text = response.roomId ?? '';
          statusMessage =
              'Scheduled Audio Room created successfully! Room ID: ${response.roomId}\nScheduled Start Time: $startTime';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to schedule audio room: ${response.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage =
            'VCloudException - createScheduledAudioRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 4 Create a scheduled video room
  Future<void> createScheduledVideoRoom() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Creating scheduled video room...';
    });

    // Schedule for 1 hour from now
    final startTime = DateTime.now().add(Duration(hours: 1));

    try {
      final response = await client.createScheduledVideoRoom(
        request: request(kind: 'scheduled_video_'),
        startAt: startTime,
      );
      if (response.status) {
        setState(() {
          currentRoomIdController.text = response.roomId ?? '';
          statusMessage =
              'Scheduled Video Room created successfully! Room ID: ${response.roomId}\nScheduled Start Time: $startTime';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to schedule video room: ${response.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage =
            'VCloudException - createScheduledVideoRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 5 Start a scheduled room
  Future<void> startScheduledRoom() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage =
            'No scheduled room to start. Create a scheduled room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Starting scheduled room...';
    });

    final startRequest = StartRoomRequest(
      roomId: currentRoomIdController.text,
      name: 'Moderator Name',
    );

    try {
      final response = await client.startScheduledRoom(request: startRequest);
      if (response.status) {
        setState(() {
          joinUrl = response.finalLink;
          statusMessage =
              'Scheduled Room started successfully! Room ID: ${response.roomId}\nJoin URL: ${response.finalLink}';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to start scheduled room: ${response.status}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - startScheduledRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 6 Join a room
  Future<void> joinRoom() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'No room to join. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Generating join link...';
    });

    final joinRequest = JoinRoomRequest(
      roomId: currentRoomIdController.text,
      userInfo: UserInfo(
        name: 'John Doe',
      ),
    );

    try {
      final response = await client.joinRoom(request: joinRequest);
      if (response.status) {
        setState(() {
          joinUrl = response.finalLink;
          statusMessage =
              'Successfully generated join link!\nJoin URL: ${response.finalLink}';
        });
      } else {
        setState(() {
          statusMessage = 'Failed to generate join link: ${response.status}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - joinRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 7 Create an invitation link
  Future<void> createInvitationLink() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage =
            'No room to create invitation for. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Creating invitation link...';
    });

    try {
      final viewerInviteRequest = CreateInvitationRequest(
        roomId: currentRoomIdController.text,
        role: InvitationRole.viewer,
      );
      final viewerInviteResponse =
          await client.createInvitationLink(request: viewerInviteRequest);
      setState(() {
        joinUrl = viewerInviteResponse.invitationUrl;
        statusMessage =
            'Viewer invitation link created successfully!\nInvitation URL: ${viewerInviteResponse.invitationUrl}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - createInvitationLink: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 8 End a room
  Future<void> endRoom() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'No room to end. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Ending room...';
    });

    final endRoomRequest = EndRoomRequest(
      roomId: currentRoomIdController.text,
    );

    try {
      final response = await client.endRoom(request: endRoomRequest);
      if (response.status) {
        setState(() {
          statusMessage = 'Room ended successfully: ${response.message}';
          currentRoomIdController.clear();
          joinUrl = null;
        });
      } else {
        setState(() {
          statusMessage = 'Failed to end room: ${response.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - endRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 9 Check room status
  Future<void> checkRoomStatus() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'No room to check status. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Checking room status...';
    });

    try {
      final statusResponse =
          await client.getRoomStatus(roomId: currentRoomIdController.text);
      if (statusResponse.status) {
        setState(() {
          statusMessage =
              'Room is active/exists.\nStatus message: ${statusResponse.message}';
        });
      } else {
        setState(() {
          statusMessage =
              'Room is not active or does not exist.\nStatus message: ${statusResponse.message}';
        });
      }
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - checkRoomStatus: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 10 get active room
  Future<void> getActiveRoom() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Fetching active room...';
    });

    try {
      final response =
          await client.getActiveRoomInfo(roomId: currentRoomIdController.text);
      setState(() {
        statusMessage =
            'Active Room fetched successfully! Room ID: ${response.message}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - getActiveRoom: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //11 get active rooms

  Future<void> getActiveRooms() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Fetching active rooms...';
    });

    try {
      final response = await client.getActiveRoomsInfo();
      setState(() {
        statusMessage =
            'Active Rooms fetched successfully! Total Rooms: ${response.rooms.length}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - getActiveRooms: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

//12 fetch past rooms
  Future<void> fetchPastRooms() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Fetching past rooms...';
    });

    try {
      final request = FetchPastRoomsRequest(
        roomIds: currentRoomIdController.text.isNotEmpty
            ? [currentRoomIdController.text]
            : [],
      );
      final response = await client.fetchPastRooms(request: request);
      setState(() {
        statusMessage =
            'Past Rooms fetched successfully! Total Rooms: ${response.rooms.roomsList.map((room) => room.roomTitle).join(', ')}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - fetchPastRooms: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

//13 get recording
  Future<void> getRecording() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'No room to get recording. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Fetching recording information...';
    });

    try {
      final response = await client.getRecording(
        roomId: currentRoomIdController.text,
      );
      setState(() {
        statusMessage =
            'Recording information fetched successfully! Recording URL: ${response.recordings.map((recording) => recording.url).join(', ')}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - getRecording: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

//14 get Analytics
  Future<void> getAnalytics() async {
    if (currentRoomIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'No room to get analytics. Create a room first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Fetching analytics information...';
    });

    try {
      final response = await client.getAnalytics(
        roomId: currentRoomIdController.text,
      );
      setState(() {
        statusMessage =
            'Analytics information fetched successfully! Analytics:\n ${response.toString()}';
      });
    } on VCloudException catch (e) {
      setState(() {
        statusMessage = 'VCloudException - getAnalytics: ${e.message}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
