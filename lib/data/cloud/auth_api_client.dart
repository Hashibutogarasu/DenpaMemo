import 'dart:convert';

import 'package:http/http.dart' as http;

/// Result of requesting an upload link from `modules/auth`.
class UploadLink {
  const UploadLink({
    required this.uploadUrl,
    required this.fileId,
    required this.filename,
  });

  final String uploadUrl;
  final String fileId;
  final String filename;
}

/// One entry of `GET /dmfiles`'s response.
class CloudFileDto {
  const CloudFileDto({
    required this.fileId,
    required this.filename,
    required this.uploaded,
  });

  final String fileId;
  final String filename;
  final DateTime uploaded;
}

/// Thrown when `modules/auth` responds with a non-2xx status, carrying the
/// status code and its `{ error, code }` body (see `app.ts`'s `onError`)
/// so callers see the real reason rather than treating the request as
/// having succeeded.
class AuthApiException implements Exception {
  const AuthApiException({
    required this.statusCode,
    required this.code,
    this.message,
  });

  final int statusCode;
  final String code;
  final String? message;

  @override
  String toString() =>
      'AuthApiException($statusCode): $code${message != null ? ' ($message)' : ''}';
}

/// Thin REST client for `modules/auth`'s endpoints. Every method requires
/// an already-obtained Firebase ID token as its Bearer credential.
class AuthApiClient {
  const AuthApiClient(this._baseUrl);

  final Uri _baseUrl;

  Future<UploadLink> requestUploadLink(String idToken, String filename) async {
    final response = await http.get(
      _baseUrl.replace(
        path: '/dmfile/link',
        queryParameters: {'filename': filename},
      ),
      headers: _authHeaders(idToken),
    );
    final body = _decodeOrThrow(response);
    return UploadLink(
      uploadUrl: body['uploadUrl'] as String,
      fileId: body['fileId'] as String,
      filename: body['filename'] as String,
    );
  }

  Future<String> requestDownloadLink(String idToken, String fileId) async {
    final response = await http.get(
      _baseUrl.replace(path: '/dmfile/download/$fileId'),
      headers: _authHeaders(idToken),
    );
    final body = _decodeOrThrow(response);
    return body['downloadUrl'] as String;
  }

  Future<void> deleteCloudFile(String idToken, String fileId) async {
    final response = await http.delete(
      _baseUrl.replace(path: '/dmfile', queryParameters: {'fileId': fileId}),
      headers: _authHeaders(idToken),
    );
    _requireSuccess(response);
  }

  /// Lists every cloud file the account has uploaded from any device, via
  /// GET /dmfiles.
  Future<List<CloudFileDto>> listDmFiles(String idToken) async {
    final response = await http.get(
      _baseUrl.replace(path: '/dmfiles'),
      headers: _authHeaders(idToken),
    );
    final body = _decodeOrThrow(response);
    final files = body['files'] as List<dynamic>;
    return [
      for (final file in files.cast<Map<String, dynamic>>())
        CloudFileDto(
          fileId: file['fileId'] as String,
          filename: file['filename'] as String,
          uploaded: DateTime.parse(file['uploaded'] as String),
        ),
    ];
  }

  Future<void> deleteAccount(String idToken) async {
    final response = await http.delete(
      _baseUrl.replace(path: '/account'),
      headers: _authHeaders(idToken),
    );
    _requireSuccess(response);
  }

  Map<String, String> _authHeaders(String idToken) => {
    'Authorization': 'Bearer $idToken',
  };

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    _requireSuccess(response);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  void _requireSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    Map<String, dynamic>? body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      body = null;
    }
    throw AuthApiException(
      statusCode: response.statusCode,
      code: body?['code'] as String? ?? 'unknown_error',
      message: body?['error'] as String?,
    );
  }
}
