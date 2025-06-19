/// Base URL for the V.cloud API
const String vCloudBaseUrl = 'https://v.cloudapi.vconnct.me';

/// Exception thrown when API requests fail
class VCloudException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic response;

  VCloudException(this.message, {this.statusCode, this.response}) {
    print('VCloudException: $message (Status: $statusCode) ${response ?? ''}');
  }

  @override
  String toString() =>
      'VCloudException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
