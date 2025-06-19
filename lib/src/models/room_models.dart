import 'package:intl/intl.dart';
import 'package:vcloud/src/models/ParticipantsInfo.dart';
import 'package:vcloud/src/models/room_info.dart';

/// Metadata for room creation
class RoomMetadata {
  final String? roomTitle;
  final String? welcomeMessage;

  RoomMetadata({this.roomTitle, this.welcomeMessage});

  factory RoomMetadata.fromJson(Map<String, dynamic> json) {
    return RoomMetadata(
      roomTitle: json['room_title'] as String?,
      welcomeMessage: json['welcome_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (roomTitle != null) 'room_title': roomTitle,
        if (welcomeMessage != null) 'welcome_message': welcomeMessage,
      };
}

/// Base request model for room creation
class RoomCreationRequest {
  final String projectId;
  final String name;
  final String? clientRoomId;
  final String moderatorId;
  final int maxParticipants;
  final int emptyTimeout;
  final RoomMetadata metadata;

  RoomCreationRequest({
    required this.projectId,
    required this.name,
    this.clientRoomId,
    required this.moderatorId,
    required this.maxParticipants,
    required this.emptyTimeout,
    required this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'name': name,
        if (clientRoomId != null) 'client_room_id': clientRoomId,
        'moderator_id': moderatorId,
        'max_participants': maxParticipants,
        'empty_timeout': emptyTimeout,
        'metadata': metadata.toJson(),
      };
}

/// Response model for room creation
class RoomCreationResponse {
  final bool status;
  final String? finalLink;
  final String? roomId;
  final String? message;
  final String? roomType;
  final DateTime? startTime;

  RoomCreationResponse({
    required this.status,
    this.finalLink,
    this.roomId,
    this.message,
    this.roomType,
    this.startTime,
  });

  factory RoomCreationResponse.fromJson(Map<String, dynamic> json) {
    return RoomCreationResponse(
      status: json['status'] as bool,
      finalLink: json['final_link'] as String?,
      roomId: json['room_id'] as String?,
      message: json['message'] as String?,
      roomType: json['room_type'] as String?,
      startTime: json['start_time'] != null
          ? DateTime.tryParse(json['start_time'] as String) ??
              DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                  .parse(json['start_time'] as String, true)
                  .toUtc()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        if (finalLink != null) 'final_link': finalLink,
        if (roomId != null) 'room_id': roomId,
        if (message != null) 'message': message,
        if (roomType != null) 'room_type': roomType,
        if (startTime != null) 'start_time': startTime!.toIso8601String(),
      };
}

/// Request model for starting a scheduled room
class StartRoomRequest {
  final String roomId;
  final String name;

  StartRoomRequest({
    required this.roomId,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'name': name,
      };
}

/// Response model for starting a room
class StartRoomResponse {
  final bool status;
  final String? finalLink;
  final String? roomId;

  StartRoomResponse({
    required this.status,
    this.finalLink,
    this.roomId,
  });

  factory StartRoomResponse.fromJson(Map<String, dynamic> json) {
    return StartRoomResponse(
      status: json['status'] as bool,
      finalLink: json['final_link'] as String?,
      roomId: json['room_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        if (finalLink != null) 'final_link': finalLink,
        if (roomId != null) 'room_id': roomId,
      };
}

/// Information about a participant in the room

/// Information about the room
class RoomInfo {
  final List<ParticipantsInfo> participants;
  final RoomInfoData data;

  RoomInfo({
    required this.data,
    required this.participants,
  });

  factory RoomInfo.fromJson(Map<String, dynamic> json) {
    final room = json['room_info'] as Map<String, dynamic>;
    final participantsJson = json['participants_info'] as List<dynamic>;
    return RoomInfo(
      participants:
          participantsJson.map((p) => ParticipantsInfo.fromJson(p)).toList(),
      data: RoomInfoData.fromJson(room),
    );
  }
}

/// Response model for room status
class RoomStatusResponse {
  final bool status;
  final String message;

  RoomStatusResponse({
    required this.status,
    required this.message,
  });

  factory RoomStatusResponse.fromJson(Map<String, dynamic> json) {
    return RoomStatusResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}

/// Response model for active room information
class ActiveRoomResponse {
  final bool status;
  final String message;
  final RoomInfo? room;

  ActiveRoomResponse({
    required this.status,
    required this.message,
    this.room,
  });

  factory ActiveRoomResponse.fromJson(Map<String, dynamic> json) {
    return ActiveRoomResponse(
      status: json['status'] as bool,
      message: json['msg'] as String,
      room: json['result'] != null
          ? RoomInfo.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Response model for active rooms list
class ActiveRoomsResponse {
  final bool status;
  final String message;
  final List<RoomInfo> rooms;

  ActiveRoomsResponse({
    required this.status,
    required this.message,
    required this.rooms,
  });

  factory ActiveRoomsResponse.fromJson(Map<String, dynamic> json) {
    final roomsJson = json['rooms'] as List<dynamic>;
    return ActiveRoomsResponse(
      status: json['status'] as bool,
      message: json['msg'] as String,
      rooms: roomsJson.map((room) => RoomInfo.fromJson(room)).toList(),
    );
  }
}

/// Request model for ending a room
class EndRoomRequest {
  final String roomId;

  EndRoomRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
      };
}

/// Response model for ending a room
class EndRoomResponse {
  final bool status;
  final String message;

  EndRoomResponse({
    required this.status,
    required this.message,
  });

  factory EndRoomResponse.fromJson(Map<String, dynamic> json) {
    return EndRoomResponse(
      status: json['status'] as bool,
      message: json['msg'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'msg': message,
      };
}

/// Request model for fetching past rooms information
class FetchPastRoomsRequest {
  final List<String> roomIds;
  final int? from;
  final int? limit;
  final String? orderBy;

  FetchPastRoomsRequest({
    required this.roomIds,
    this.from,
    this.limit,
    this.orderBy,
  });

  Map<String, dynamic> toJson() => {
        'room_ids': roomIds,
        if (from != null) 'from': from,
        if (limit != null) 'limit': limit,
        if (orderBy != null) 'order_by': orderBy,
      };
}

/// Response model for fetching past rooms information
class FetchPastRoomsResponse {
  final bool status;
  final RoomsData rooms;

  FetchPastRoomsResponse({
    required this.status,
    required this.rooms,
  });

  factory FetchPastRoomsResponse.fromJson(Map<String, dynamic> json) {
    return FetchPastRoomsResponse(
      status: json['status'] as bool,
      rooms: RoomsData.fromJson(json['rooms'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'rooms': rooms.toJson(),
      };
}

/// Data structure containing room list and pagination information
class RoomsData {
  final int from;
  final int limit;
  final String orderBy;
  final List<PastRoomInfo> roomsList;
  final String totalRooms;

  RoomsData({
    required this.from,
    required this.limit,
    required this.orderBy,
    required this.roomsList,
    required this.totalRooms,
  });

  factory RoomsData.fromJson(Map<String, dynamic> json) {
    final roomsListJson = json['rooms_list'] as List<dynamic>;
    return RoomsData(
      from: int.parse(json['from'].toString()),
      limit: int.parse(json['limit'].toString()),
      orderBy: json['order_by'] as String,
      roomsList: roomsListJson
          .map((room) => PastRoomInfo.fromJson(room as Map<String, dynamic>))
          .toList(),
      totalRooms: json['total_rooms'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'from': from,
        'limit': limit,
        'order_by': orderBy,
        'rooms_list': roomsList.map((room) => room.toJson()).toList(),
        'total_rooms': totalRooms,
      };
}

/// Information about a past room
class PastRoomInfo {
  final String analyticsFileId;
  final String created;
  final String ended;
  final String joinedParticipants;
  final String roomId;
  final String roomSid;
  final String roomTitle;
  final String webhookUrl;

  PastRoomInfo({
    required this.analyticsFileId,
    required this.created,
    required this.ended,
    required this.joinedParticipants,
    required this.roomId,
    required this.roomSid,
    required this.roomTitle,
    required this.webhookUrl,
  });

  factory PastRoomInfo.fromJson(Map<String, dynamic> json) {
    return PastRoomInfo(
      analyticsFileId: json['analytics_file_id'] as String,
      created: json['created'] as String,
      ended: json['ended'] as String,
      joinedParticipants: json['joined_participants'] as String,
      roomId: json['room_id'] as String,
      roomSid: json['room_sid'] as String,
      roomTitle: json['room_title'] as String,
      webhookUrl: json['webhook_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'analytics_file_id': analyticsFileId,
        'created': created,
        'ended': ended,
        'joined_participants': joinedParticipants,
        'room_id': roomId,
        'room_sid': roomSid,
        'room_title': roomTitle,
        'webhook_url': webhookUrl,
      };
}
