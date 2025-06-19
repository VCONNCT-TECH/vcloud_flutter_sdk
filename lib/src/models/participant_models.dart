/// User information for joining a room
class UserInfo {
  final String name;
  final bool? isHidden;
  final bool? isAdmin;

  UserInfo({
    required this.name,
    this.isHidden,
    this.isAdmin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'] as String,
      isHidden: json['is_hidden'] as bool?,
      isAdmin: json['is_admin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        if (isHidden != null) 'is_hidden': isHidden,
        if (isAdmin != null) 'is_admin': isAdmin,
      };
}

/// Request model for joining a room
class JoinRoomRequest {
  final String roomId;
  final UserInfo userInfo;

  JoinRoomRequest({
    required this.roomId,
    required this.userInfo,
  });

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'user_info': userInfo.toJson(),
      };
}

/// Response model for joining a room
class JoinRoomResponse {
  final bool status;
  final String? finalLink;

  JoinRoomResponse({
    required this.status,
    this.finalLink,
  });

  factory JoinRoomResponse.fromJson(Map<String, dynamic> json) {
    return JoinRoomResponse(
      status: json['status'] as bool,
      finalLink: json['final_link'] as String?,
    );
  }
}

/// Role for invitation link users
enum InvitationRole {
  /// Admin role - one-time use invitation
  admin,
  
  /// Viewer role - can be used multiple times
  viewer,
}

/// Request model for creating an invitation link
class CreateInvitationRequest {
  final String roomId;
  final InvitationRole role;

  CreateInvitationRequest({
    required this.roomId,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'role': role.name,
      };
}

/// Response model for invitation link creation
class InvitationResponse {
  final String? invitationUrl;

  InvitationResponse({
    this.invitationUrl,
  });

  factory InvitationResponse.fromJson(Map<String, dynamic> json) {
    return InvitationResponse(
      invitationUrl: json['invitation_url'] as String?,
    );
  }
} 