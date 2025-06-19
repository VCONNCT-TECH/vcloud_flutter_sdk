/// Information about a recording
class RecordingInfo {
  final String roomId;
  final String? url;

  RecordingInfo({
    required this.roomId,
    this.url,
  });

  factory RecordingInfo.fromJson(Map<String, dynamic> json) {
    return RecordingInfo(
      roomId: json['room_id'] as String,
      url: json['url'] as String?,
    );
  }
}

/// Response model for getting recording information
class GetRecordingResponse {
  final bool status;
  final List<RecordingInfo> recordings;

  GetRecordingResponse({
    required this.status,
    required this.recordings,
  });

  factory GetRecordingResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;
    return GetRecordingResponse(
      status: json['status'] as bool,
      recordings: data
          .map((recording) =>
              RecordingInfo.fromJson(recording as Map<String, dynamic>))
          .toList(),
    );
  }
}
