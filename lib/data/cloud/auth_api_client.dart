import 'dart:convert';

import 'package:http/http.dart' as http;

/// Result of requesting an upload link from `modules/auth`.
class UploadLink {
  const UploadLink({required this.uploadUrl, required this.fileId, required this.filename});

  final String uploadUrl;
  final String fileId;
  final String filename;
}

/// Thin REST client for `modules/auth`'s endpoints. Every method requires
/// an already-obtained Firebase ID token as its Bearer credential.
class AuthApiClient {
  const AuthApiClient(this._baseUrl);

  final Uri _baseUrl;

  Future<UploadLink> requestUploadLink(String idToken, String filename) async {
    final response = await http.get(
      _baseUrl.replace(path: '/dmfile/link', queryParameters: {'filename': filename}),
      headers: _authHeaders(idToken),
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
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
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['downloadUrl'] as String;
  }

  Future<void> deleteCloudFile(String idToken, String fileId) async {
    await http.delete(
      _baseUrl.replace(path: '/dmfile', queryParameters: {'fileId': fileId}),
      headers: _authHeaders(idToken),
    );
  }

  Future<void> deleteAccount(String idToken) async {
    await http.delete(_baseUrl.replace(path: '/account'), headers: _authHeaders(idToken));
  }

  Map<String, String> _authHeaders(String idToken) => {'Authorization': 'Bearer $idToken'};
}
