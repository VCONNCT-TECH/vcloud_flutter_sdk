/// V.cloud API SDK
///
/// A Dart SDK for the V.cloud API that provides tools for building virtual
/// collaboration solutions with features like audio/video conferencing,
/// meeting management, participant control, and more.
library vcloud;

// Core client
export 'src/vcloud_client.dart' show VCloudClient;

// Common models and utilities
export 'src/models/common.dart' show 
    VCloudException,
    vCloudBaseUrl;

// Room-related models
export 'src/models/room_models.dart' show
    RoomMetadata,
    RoomCreationRequest,
    RoomCreationResponse,
    StartRoomRequest,
    StartRoomResponse,
    RoomInfo,
    RoomStatusResponse,
    ActiveRoomResponse,
    ActiveRoomsResponse,
    EndRoomRequest,
    EndRoomResponse,
    FetchPastRoomsRequest,
    FetchPastRoomsResponse;

// Participant-related models
export 'src/models/participant_models.dart' show
    UserInfo,
    JoinRoomRequest,
    JoinRoomResponse,
    InvitationRole,
    CreateInvitationRequest,
    InvitationResponse;

// Recording-related models
export 'src/models/recording_models.dart' show
    RecordingInfo,
    GetRecordingResponse;
