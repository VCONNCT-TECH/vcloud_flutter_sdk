import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'models/common.dart';
import 'models/participant_models.dart';
import 'models/recording_models.dart';
import 'models/room_models.dart';

/// Main client class for interacting with V.cloud API
class VCloudClient {
  final String apiKey;
  final Dio _dio;
  final String baseUrl;
  final Interceptor? interceptor;
  final PrettyDioLogger? prettyDioLogger;
  final bool isDebug;

  VCloudClient({
    Dio? dio,
    String? baseUrl,
    required this.apiKey,
    this.interceptor,
    this.prettyDioLogger,
    this.isDebug = true,
  })  : _dio = dio ?? Dio(),
        baseUrl = baseUrl ?? vCloudBaseUrl {
    // Add pretty logger
    if (isDebug) {
      _dio.interceptors.add(
        prettyDioLogger ??
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
            ),
      );
    }

    // Add custom interceptor if provided
    if (interceptor != null) {
      _dio.interceptors.add(interceptor!);
    }

    // Set base options
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'key': apiKey,
    };
    _dio.options.baseUrl = this.baseUrl;
  }

  /// set the base URL for the API
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  /// set api key for the API
  void setApiKey(String key) {
    _dio.options.headers['key'] = key;
  }

  /// Helper method for room creation endpoints
  Future<RoomCreationResponse> _createRoom(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    if (endpoint.contains('schedule')) {
      if (!body.containsKey('start_at')) {
        throw VCloudException('start_at is required for scheduled rooms');
      }
    }

    try {
      final response = await _dio.post(
        endpoint,
        data: body,
      );

      return RoomCreationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to create room',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Creates a quick audio room
  Future<RoomCreationResponse> createQuickAudioRoom({
    required RoomCreationRequest request,
  }) async {
    return _createRoom(
        '/api/v3/rooms/create_quick_audio_room', request.toJson());
  }

  /// Creates a quick video room
  Future<RoomCreationResponse> createQuickVideoRoom({
    required RoomCreationRequest request,
  }) async {
    return _createRoom(
        '/api/v3/rooms/create_quick_video_room', request.toJson());
  }



  /// Creates a scheduled audio room
  Future<RoomCreationResponse> createScheduledAudioRoom({
    required RoomCreationRequest request,
    required DateTime startAt,
  }) async {
    final body = request.toJson();

    body['start_at'] = startAt.toIso8601String().substring(0, 16);
    return _createRoom('/api/v3/rooms/create_schedule_audio_room', body);
  }

  /// Creates a scheduled video room
  Future<RoomCreationResponse> createScheduledVideoRoom({
    required RoomCreationRequest request,
    required DateTime startAt,
  }) async {
    if (startAt.isBefore(DateTime.now())) {
      throw VCloudException('Start time must be in the future');
    }

    final body = request.toJson();
    body['start_at'] = startAt.toIso8601String().substring(0, 16);

    return _createRoom('/api/v3/rooms/create_schedule_video_room', body);
  }

  /// Gets the current status of a room
  Future<RoomStatusResponse> getRoomStatus({
    required String roomId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v3/rooms/room_status',
        queryParameters: {'room_id': roomId},
      );

      return RoomStatusResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to get room status',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Starts a scheduled room
  Future<StartRoomResponse> startScheduledRoom({
    required StartRoomRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v3/rooms/start_schedule_room',
        data: request.toJson(),
      );

      return StartRoomResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to start scheduled room',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Joins an existing room
  Future<JoinRoomResponse> joinRoom({
    required JoinRoomRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v3/rooms/join_room',
        data: request.toJson(),
      );

      return JoinRoomResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to join room',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Creates an invitation link for a room
  Future<InvitationResponse> createInvitationLink({
    required CreateInvitationRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v3/rooms/create_invitation_link',
        data: request.toJson(),
      );

      return InvitationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to create invitation link',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Gets detailed information about an active room
  Future<ActiveRoomResponse> getActiveRoomInfo({
    required String roomId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v3/rooms/get_active_room_info',
        queryParameters: {'room_id': roomId},
      );

      return ActiveRoomResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to get active room information',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Gets information about all active rooms in the project
  Future<ActiveRoomsResponse> getActiveRoomsInfo() async {
    try {
      final response = await _dio.get(
        '/api/v3/rooms/get_active_rooms_info',
      );

      return ActiveRoomsResponse.fromJson(
        response.data['response'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to get active rooms information',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Ends an active room
  Future<EndRoomResponse> endRoom({
    required EndRoomRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v3/rooms/end_room',
        data: request.toJson(),
      );

      return EndRoomResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to end room',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Fetches information about past rooms
  Future<FetchPastRoomsResponse> fetchPastRooms({
    required FetchPastRoomsRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v3/rooms/fetch_past_rooms',
        data: request.toJson(),
      );

      return FetchPastRoomsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to fetch past rooms',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Gets recording information for a room
  Future<GetRecordingResponse> getRecording({
    required String roomId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v3/recordings/get_record',
        queryParameters: {'room_id': roomId},
      );

      return GetRecordingResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to get recording information',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Gets analytics data for a room
  Future<Map<String, dynamic>?> getAnalytics({
    required String roomId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v3/analytics/get_analytics',
        queryParameters: {'room_id': roomId},
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw VCloudException(
        e.response?.data['message'] ?? 'Failed to get analytics information',
        statusCode: e.response?.statusCode,
        response: e.response?.data.toString(),
      );
    }
  }

  /// Closes the Dio client
  void close() {
    _dio.close();
  }
}
