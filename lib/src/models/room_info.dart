/// creation_time : "1750153684"
/// is_active_rtmp : 0
/// is_breakout_room : 0
/// is_recording : 0
/// is_running : 1
/// joined_participants : "0"
/// metadata : "{\"room_title\":\"room audio_ID3333\", \"welcome_message\":\"Welcome to our room!\", \"is_recording\":false, \"is_active_rtmp\":false, \"parent_room_id\":\"\", \"is_breakout_room\":false, \"webhook_url\":\"https://v.cloudapi.vconnct.me/api/v3/webhook/callback\", \"started_at\":\"1750153684\", \"logout_url\":\"https://vconnct.me\", \"room_features\":{\"allow_webcams\":false, \"mute_on_start\":false, \"allow_screen_share\":true, \"allow_rtmp\":false, \"allow_view_other_webcams\":false, \"allow_view_other_users_list\":true, \"admin_only_webcams\":false, \"allow_polls\":true, \"room_duration\":\"0\", \"enable_analytics\":true, \"allow_virtual_bg\":true, \"allow_raise_hand\":true, \"recording_features\":{\"is_allow\":true, \"is_allow_cloud\":true, \"enable_auto_cloud_recording\":false, \"is_allow_local\":true, \"only_record_admin_webcams\":false}, \"chat_features\":{\"allow_chat\":true, \"allow_file_upload\":true, \"allowed_file_types\":[\"jpg\", \"png\", \"jpeg\", \"svg\", \"pdf\", \"docx\", \"txt\", \"xlsx\", \"pptx\", \"zip\", \"mp4\", \"webm\", \"mp3\"], \"max_file_size\":\"2048\"}, \"shared_note_pad_features\":{\"allowed_shared_note_pad\":true, \"is_active\":false, \"visible\":false, \"node_id\":\"\", \"host\":\"\", \"note_pad_id\":\"\", \"read_only_pad_id\":\"\"}, \"whiteboard_features\":{\"allowed_whiteboard\":true, \"visible\":false, \"whiteboard_file_id\":\"\", \"file_name\":\"\", \"file_path\":\"\", \"total_pages\":0}, \"external_media_player_features\":{\"allowed_external_media_player\":true, \"is_active\":false}, \"waiting_room_features\":{\"is_active\":false, \"waiting_room_msg\":\"\"}, \"breakout_room_features\":{\"is_allow\":true, \"is_active\":false, \"allowed_number_rooms\":2}, \"display_external_link_features\":{\"is_allow\":true, \"is_active\":false}, \"ingress_features\":{\"is_allow\":true, \"input_type\":\"RTMP_INPUT\", \"url\":\"\", \"stream_key\":\"\"}, \"speech_to_text_translation_features\":{\"is_allow\":true, \"is_allow_translation\":false, \"is_enabled\":false, \"is_enabled_translation\":false, \"max_num_tran_langs_allow_selecting\":2, \"allowed_speech_langs\":[], \"allowed_speech_users\":[], \"allowed_trans_langs\":[]}, \"end_to_end_encryption_features\":{\"is_enabled\":false, \"included_chat_messages\":false, \"included_whiteboard\":false}}, \"default_lock_settings\":{\"lock_microphone\":false, \"lock_webcam\":true, \"lock_screen_sharing\":true, \"lock_chat\":false, \"lock_chat_send_message\":false, \"lock_chat_file_share\":false, \"lock_private_chat\":false, \"lock_whiteboard\":true, \"lock_shared_notepad\":true}, \"copyright_conf\":{\"display\":true, \"text\":\"\"}, \"metadata_id\":\"22022b75-28a9-4d0d-9b9a-86c6cae29b3b\"}"
/// parent_room_id : ""
/// room_id : "ed5d4055-fe25-43d3-99d2-aa0c40a27d72"
/// room_title : "room audio_ID3333"
/// sid : "RM_Mmieb3gXgTAs"
/// webhook_url : "https://v.cloudapi.vconnct.me/api/v3/webhook/callback"

class RoomInfoData {
  RoomInfoData({
      String? creationTime, 
      num? isActiveRtmp, 
      num? isBreakoutRoom, 
      num? isRecording, 
      num? isRunning, 
      String? joinedParticipants, 
      String? metadata, 
      String? parentRoomId, 
      String? roomId, 
      String? roomTitle, 
      String? sid, 
      String? webhookUrl,}){
    _creationTime = creationTime;
    _isActiveRtmp = isActiveRtmp;
    _isBreakoutRoom = isBreakoutRoom;
    _isRecording = isRecording;
    _isRunning = isRunning;
    _joinedParticipants = joinedParticipants;
    _metadata = metadata;
    _parentRoomId = parentRoomId;
    _roomId = roomId;
    _roomTitle = roomTitle;
    _sid = sid;
    _webhookUrl = webhookUrl;
}

  RoomInfoData.fromJson(dynamic json) {
    _creationTime = json['creation_time'];
    _isActiveRtmp = json['is_active_rtmp'];
    _isBreakoutRoom = json['is_breakout_room'];
    _isRecording = json['is_recording'];
    _isRunning = json['is_running'];
    _joinedParticipants = json['joined_participants'];
    _metadata = json['metadata'];
    _parentRoomId = json['parent_room_id'];
    _roomId = json['room_id'];
    _roomTitle = json['room_title'];
    _sid = json['sid'];
    _webhookUrl = json['webhook_url'];
  }
  String? _creationTime;
  num? _isActiveRtmp;
  num? _isBreakoutRoom;
  num? _isRecording;
  num? _isRunning;
  String? _joinedParticipants;
  String? _metadata;
  String? _parentRoomId;
  String? _roomId;
  String? _roomTitle;
  String? _sid;
  String? _webhookUrl;

  String? get creationTime => _creationTime;
  num? get isActiveRtmp => _isActiveRtmp;
  num? get isBreakoutRoom => _isBreakoutRoom;
  num? get isRecording => _isRecording;
  num? get isRunning => _isRunning;
  String? get joinedParticipants => _joinedParticipants;
  String? get metadata => _metadata;
  String? get parentRoomId => _parentRoomId;
  String? get roomId => _roomId;
  String? get roomTitle => _roomTitle;
  String? get sid => _sid;
  String? get webhookUrl => _webhookUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['creation_time'] = _creationTime;
    map['is_active_rtmp'] = _isActiveRtmp;
    map['is_breakout_room'] = _isBreakoutRoom;
    map['is_recording'] = _isRecording;
    map['is_running'] = _isRunning;
    map['joined_participants'] = _joinedParticipants;
    map['metadata'] = _metadata;
    map['parent_room_id'] = _parentRoomId;
    map['room_id'] = _roomId;
    map['room_title'] = _roomTitle;
    map['sid'] = _sid;
    map['webhook_url'] = _webhookUrl;
    return map;
  }

}