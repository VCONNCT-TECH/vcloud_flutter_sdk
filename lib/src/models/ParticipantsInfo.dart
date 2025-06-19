/// identity : "e98113ba-2a51-4241-94ae-a3f1a802dec3"
/// is_publisher : false
/// joined_at : "1750152561"
/// kind : "STANDARD"
/// metadata : {"is_admin":true,"record_webcam":true,"is_presenter":true,"raised_hand":false,"wait_for_approval":false,"lock_settings":{"lock_microphone":false,"lock_webcam":false,"lock_screen_sharing":false,"lock_chat":false,"lock_chat_send_message":false,"lock_chat_file_share":false,"lock_private_chat":false,"lock_whiteboard":false,"lock_shared_notepad":false},"metadata_id":"d4eece17-b1c1-41f8-8213-af4984d66226"}
/// name : "eslam"
/// permission : {"agent":false,"can_publish":true,"can_publish_data":true,"can_publish_sources":[],"can_subscribe":true,"can_update_metadata":false,"hidden":false,"recorder":false}
/// region : ""
/// sid : "PA_okwtCoS7iRnc"
/// state : "ACTIVE"
/// tracks : []
/// version : 2

class ParticipantsInfo {
  ParticipantsInfo({
      String? identity, 
      bool? isPublisher, 
      String? joinedAt, 
      String? kind, 
      Metadata? metadata, 
      String? name, 
      Permission? permission, 
      String? region, 
      String? sid, 
      String? state, 
      num? version,}){
    _identity = identity;
    _isPublisher = isPublisher;
    _joinedAt = joinedAt;
    _kind = kind;
    _metadata = metadata;
    _name = name;
    _permission = permission;
    _region = region;
    _sid = sid;
    _state = state;
    _version = version;
}

  ParticipantsInfo.fromJson(dynamic json) {
    _identity = json['identity'];
    _isPublisher = json['is_publisher'];
    _joinedAt = json['joined_at'];
    _kind = json['kind'];
    _metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    _name = json['name'];
    _permission = json['permission'] != null ? Permission.fromJson(json['permission']) : null;
    _region = json['region'];
    _sid = json['sid'];
    _state = json['state'];
    _version = json['version'];
  }
  String? _identity;
  bool? _isPublisher;
  String? _joinedAt;
  String? _kind;
  Metadata? _metadata;
  String? _name;
  Permission? _permission;
  String? _region;
  String? _sid;
  String? _state;
  num? _version;

  String? get identity => _identity;
  bool? get isPublisher => _isPublisher;
  String? get joinedAt => _joinedAt;
  String? get kind => _kind;
  Metadata? get metadata => _metadata;
  String? get name => _name;
  Permission? get permission => _permission;
  String? get region => _region;
  String? get sid => _sid;
  String? get state => _state;
  num? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identity'] = _identity;
    map['is_publisher'] = _isPublisher;
    map['joined_at'] = _joinedAt;
    map['kind'] = _kind;
    if (_metadata != null) {
      map['metadata'] = _metadata?.toJson();
    }
    map['name'] = _name;
    if (_permission != null) {
      map['permission'] = _permission?.toJson();
    }
    map['region'] = _region;
    map['sid'] = _sid;
    map['state'] = _state;
    map['version'] = _version;
    return map;
  }

}

/// agent : false
/// can_publish : true
/// can_publish_data : true
/// can_publish_sources : []
/// can_subscribe : true
/// can_update_metadata : false
/// hidden : false
/// recorder : false

class Permission {
  Permission({
      bool? agent, 
      bool? canPublish, 
      bool? canPublishData, 
      List<dynamic>? canPublishSources, 
      bool? canSubscribe, 
      bool? canUpdateMetadata, 
      bool? hidden, 
      bool? recorder,}){
    _agent = agent;
    _canPublish = canPublish;
    _canPublishData = canPublishData;
    _canSubscribe = canSubscribe;
    _canUpdateMetadata = canUpdateMetadata;
    _hidden = hidden;
    _recorder = recorder;
}

  Permission.fromJson(dynamic json) {
    _agent = json['agent'];
    _canPublish = json['can_publish'];
    _canPublishData = json['can_publish_data'];
    _canSubscribe = json['can_subscribe'];
    _canUpdateMetadata = json['can_update_metadata'];
    _hidden = json['hidden'];
    _recorder = json['recorder'];
  }
  bool? _agent;
  bool? _canPublish;
  bool? _canPublishData;
  bool? _canSubscribe;
  bool? _canUpdateMetadata;
  bool? _hidden;
  bool? _recorder;

  bool? get agent => _agent;
  bool? get canPublish => _canPublish;
  bool? get canPublishData => _canPublishData;
  bool? get canSubscribe => _canSubscribe;
  bool? get canUpdateMetadata => _canUpdateMetadata;
  bool? get hidden => _hidden;
  bool? get recorder => _recorder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agent'] = _agent;
    map['can_publish'] = _canPublish;
    map['can_publish_data'] = _canPublishData;
    map['can_subscribe'] = _canSubscribe;
    map['can_update_metadata'] = _canUpdateMetadata;
    map['hidden'] = _hidden;
    map['recorder'] = _recorder;
    return map;
  }

}

/// is_admin : true
/// record_webcam : true
/// is_presenter : true
/// raised_hand : false
/// wait_for_approval : false
/// lock_settings : {"lock_microphone":false,"lock_webcam":false,"lock_screen_sharing":false,"lock_chat":false,"lock_chat_send_message":false,"lock_chat_file_share":false,"lock_private_chat":false,"lock_whiteboard":false,"lock_shared_notepad":false}
/// metadata_id : "d4eece17-b1c1-41f8-8213-af4984d66226"

class Metadata {
  Metadata({
      bool? isAdmin, 
      bool? recordWebcam, 
      bool? isPresenter, 
      bool? raisedHand, 
      bool? waitForApproval, 
      LockSettings? lockSettings, 
      String? metadataId,}){
    _isAdmin = isAdmin;
    _recordWebcam = recordWebcam;
    _isPresenter = isPresenter;
    _raisedHand = raisedHand;
    _waitForApproval = waitForApproval;
    _lockSettings = lockSettings;
    _metadataId = metadataId;
}

  Metadata.fromJson(dynamic json) {
    _isAdmin = json['is_admin'];
    _recordWebcam = json['record_webcam'];
    _isPresenter = json['is_presenter'];
    _raisedHand = json['raised_hand'];
    _waitForApproval = json['wait_for_approval'];
    _lockSettings = json['lock_settings'] != null ? LockSettings.fromJson(json['lock_settings']) : null;
    _metadataId = json['metadata_id'];
  }
  bool? _isAdmin;
  bool? _recordWebcam;
  bool? _isPresenter;
  bool? _raisedHand;
  bool? _waitForApproval;
  LockSettings? _lockSettings;
  String? _metadataId;

  bool? get isAdmin => _isAdmin;
  bool? get recordWebcam => _recordWebcam;
  bool? get isPresenter => _isPresenter;
  bool? get raisedHand => _raisedHand;
  bool? get waitForApproval => _waitForApproval;
  LockSettings? get lockSettings => _lockSettings;
  String? get metadataId => _metadataId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_admin'] = _isAdmin;
    map['record_webcam'] = _recordWebcam;
    map['is_presenter'] = _isPresenter;
    map['raised_hand'] = _raisedHand;
    map['wait_for_approval'] = _waitForApproval;
    if (_lockSettings != null) {
      map['lock_settings'] = _lockSettings?.toJson();
    }
    map['metadata_id'] = _metadataId;
    return map;
  }

}

/// lock_microphone : false
/// lock_webcam : false
/// lock_screen_sharing : false
/// lock_chat : false
/// lock_chat_send_message : false
/// lock_chat_file_share : false
/// lock_private_chat : false
/// lock_whiteboard : false
/// lock_shared_notepad : false

class LockSettings {
  LockSettings({
      bool? lockMicrophone, 
      bool? lockWebcam, 
      bool? lockScreenSharing, 
      bool? lockChat, 
      bool? lockChatSendMessage, 
      bool? lockChatFileShare, 
      bool? lockPrivateChat, 
      bool? lockWhiteboard, 
      bool? lockSharedNotepad,}){
    _lockMicrophone = lockMicrophone;
    _lockWebcam = lockWebcam;
    _lockScreenSharing = lockScreenSharing;
    _lockChat = lockChat;
    _lockChatSendMessage = lockChatSendMessage;
    _lockChatFileShare = lockChatFileShare;
    _lockPrivateChat = lockPrivateChat;
    _lockWhiteboard = lockWhiteboard;
    _lockSharedNotepad = lockSharedNotepad;
}

  LockSettings.fromJson(dynamic json) {
    _lockMicrophone = json['lock_microphone'];
    _lockWebcam = json['lock_webcam'];
    _lockScreenSharing = json['lock_screen_sharing'];
    _lockChat = json['lock_chat'];
    _lockChatSendMessage = json['lock_chat_send_message'];
    _lockChatFileShare = json['lock_chat_file_share'];
    _lockPrivateChat = json['lock_private_chat'];
    _lockWhiteboard = json['lock_whiteboard'];
    _lockSharedNotepad = json['lock_shared_notepad'];
  }
  bool? _lockMicrophone;
  bool? _lockWebcam;
  bool? _lockScreenSharing;
  bool? _lockChat;
  bool? _lockChatSendMessage;
  bool? _lockChatFileShare;
  bool? _lockPrivateChat;
  bool? _lockWhiteboard;
  bool? _lockSharedNotepad;

  bool? get lockMicrophone => _lockMicrophone;
  bool? get lockWebcam => _lockWebcam;
  bool? get lockScreenSharing => _lockScreenSharing;
  bool? get lockChat => _lockChat;
  bool? get lockChatSendMessage => _lockChatSendMessage;
  bool? get lockChatFileShare => _lockChatFileShare;
  bool? get lockPrivateChat => _lockPrivateChat;
  bool? get lockWhiteboard => _lockWhiteboard;
  bool? get lockSharedNotepad => _lockSharedNotepad;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lock_microphone'] = _lockMicrophone;
    map['lock_webcam'] = _lockWebcam;
    map['lock_screen_sharing'] = _lockScreenSharing;
    map['lock_chat'] = _lockChat;
    map['lock_chat_send_message'] = _lockChatSendMessage;
    map['lock_chat_file_share'] = _lockChatFileShare;
    map['lock_private_chat'] = _lockPrivateChat;
    map['lock_whiteboard'] = _lockWhiteboard;
    map['lock_shared_notepad'] = _lockSharedNotepad;
    return map;
  }

}