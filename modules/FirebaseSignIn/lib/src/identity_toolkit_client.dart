import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cloud_account_state.dart';
import 'exceptions.dart';
import 'google_oauth_client_config.dart';

part 'identity_toolkit_client.g.dart';

/// Response shape shared by `accounts:signInWithPassword`,
/// `accounts:signUp`, and `accounts:signInWithIdp`.
@JsonSerializable(createToJson: false)
class IdentityToolkitAccountResponse {
  const IdentityToolkitAccountResponse({
    required this.idToken,
    required this.refreshToken,
    required this.localId,
    required this.expiresIn,
    this.email,
  });

  factory IdentityToolkitAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentityToolkitAccountResponseFromJson(json);

  final String idToken;
  final String refreshToken;
  final String localId;
  final String expiresIn;
  final String? email;
}

/// Response shape of Secure Token's `/token` refresh-grant endpoint
/// (snake_case, unlike Identity Toolkit's own endpoints).
@JsonSerializable(createToJson: false)
class SecureTokenRefreshResponse {
  const SecureTokenRefreshResponse({
    required this.idToken,
    required this.refreshToken,
    required this.userId,
    required this.expiresIn,
  });

  factory SecureTokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$SecureTokenRefreshResponseFromJson(json);

  @JsonKey(name: 'id_token')
  final String idToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'expires_in')
  final String expiresIn;
}

/// A Firebase Identity Toolkit session: the token set returned by any
/// sign-in/sign-up/refresh call, plus enough to know when it needs
/// refreshing. Also the shape persisted to secure storage.
@JsonSerializable()
class IdentityToolkitSession {
  IdentityToolkitSession({
    required this.idToken,
    required this.refreshToken,
    required this.localId,
    required this.email,
    required this.expiresAt,
  });

  factory IdentityToolkitSession.fromJson(Map<String, dynamic> json) =>
      _$IdentityToolkitSessionFromJson(json);

  factory IdentityToolkitSession.fromAccountResponse(
    IdentityToolkitAccountResponse response,
  ) => IdentityToolkitSession(
    idToken: response.idToken,
    refreshToken: response.refreshToken,
    localId: response.localId,
    email: response.email,
    expiresAt: DateTime.now().add(
      Duration(seconds: int.parse(response.expiresIn)),
    ),
  );

  factory IdentityToolkitSession.fromRefreshResponse(
    SecureTokenRefreshResponse response, {
    required String? email,
  }) => IdentityToolkitSession(
    idToken: response.idToken,
    refreshToken: response.refreshToken,
    localId: response.userId,
    email: email,
    expiresAt: DateTime.now().add(
      Duration(seconds: int.parse(response.expiresIn)),
    ),
  );

  final String idToken;
  final String refreshToken;
  final String localId;
  final String? email;

  @JsonKey(fromJson: _dateTimeFromEpochMs, toJson: _dateTimeToEpochMs)
  final DateTime expiresAt;

  Map<String, dynamic> toJson() => _$IdentityToolkitSessionToJson(this);

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  CloudAccountState toState() =>
      CloudAccountState(isSignedIn: true, email: email, uid: localId);

  static DateTime _dateTimeFromEpochMs(int epochMs) =>
      DateTime.fromMillisecondsSinceEpoch(epochMs);

  static int _dateTimeToEpochMs(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;
}

/// Encapsulates every raw HTTP call against the Firebase Identity Toolkit
/// and Secure Token REST APIs, so callers never build these requests by
/// hand. [signInWithIdp] is the token-issuance unit (turns a third-party
/// ID token into a Firebase session); [refresh] is the token-refresh unit.
class IdentityToolkitClient {
  IdentityToolkitClient({required this.apiKey, Dio? dio}) : _dio = dio ?? Dio();

  static const _identityToolkitBase =
      'https://identitytoolkit.googleapis.com/v1';
  static const _secureTokenBase = 'https://securetoken.googleapis.com/v1';

  final String apiKey;
  final Dio _dio;

  Future<IdentityToolkitSession> signInWithPassword(
    String email,
    String password,
  ) =>
      _request('accounts:signInWithPassword', {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }).then(
        (json) => IdentityToolkitSession.fromAccountResponse(
          IdentityToolkitAccountResponse.fromJson(json),
        ),
      );

  Future<IdentityToolkitSession> signUp(String email, String password) =>
      _request('accounts:signUp', {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }).then(
        (json) => IdentityToolkitSession.fromAccountResponse(
          IdentityToolkitAccountResponse.fromJson(json),
        ),
      );

  /// Exchanges a third-party (e.g. Google) ID token for a Firebase session
  /// — the token-issuance unit.
  Future<IdentityToolkitSession> signInWithIdp({
    required String googleIdToken,
    required String requestUri,
  }) =>
      _request('accounts:signInWithIdp', {
        'postBody': 'id_token=$googleIdToken&providerId=google.com',
        'requestUri': requestUri,
        'returnSecureToken': true,
      }).then(
        (json) => IdentityToolkitSession.fromAccountResponse(
          IdentityToolkitAccountResponse.fromJson(json),
        ),
      );

  /// Exchanges a refresh token for a new ID token — the token-refresh
  /// unit.
  Future<IdentityToolkitSession> refresh({
    required String refreshToken,
    String? email,
  }) async {
    final response = await _dio.postUri<Map<String, dynamic>>(
      Uri.parse('$_secureTokenBase/token?key=$apiKey'),
      data: {'grant_type': 'refresh_token', 'refresh_token': refreshToken},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (_) => true,
      ),
    );
    return IdentityToolkitSession.fromRefreshResponse(
      SecureTokenRefreshResponse.fromJson(_decodeOrThrow(response)),
      email: email,
    );
  }

  Future<void> deleteAccount(String idToken) =>
      _request('accounts:delete', {'idToken': idToken});

  Future<Map<String, dynamic>> _request(
    String method,
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.postUri<Map<String, dynamic>>(
      Uri.parse('$_identityToolkitBase/$method?key=$apiKey'),
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
        validateStatus: (_) => true,
      ),
    );
    return _decodeOrThrow(response);
  }

  Map<String, dynamic> _decodeOrThrow(Response<Map<String, dynamic>> response) {
    final decoded = response.data!;
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      return decoded;
    }
    final error = decoded['error'] as Map<String, dynamic>?;
    final errors = error?['errors'] as List<dynamic>?;
    final errorCode = (errors?.isNotEmpty ?? false)
        ? (errors!.first as Map<String, dynamic>)['message'] as String?
        : null;
    throw RestAuthException(
      statusCode: statusCode,
      errorCode: errorCode ?? error?['message'] as String? ?? 'UNKNOWN_ERROR',
      rawMessage: error?['message'] as String?,
    );
  }
}

/// Exchanges a Google OAuth authorization code for a Google ID token —
/// distinct from Firebase's own token issuance/refresh, since it talks to
/// Google's OAuth token endpoint rather than Identity Toolkit.
@JsonSerializable(createToJson: false)
class _GoogleTokenResponse {
  const _GoogleTokenResponse({required this.idToken});

  factory _GoogleTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleTokenResponseFromJson(json);

  @JsonKey(name: 'id_token')
  final String idToken;
}

class GoogleOAuthTokenClient {
  GoogleOAuthTokenClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<String> exchangeAuthorizationCode({
    required GoogleOAuthClientConfig config,
    required String code,
    required String redirectUri,
  }) async {
    final response = await _dio.postUri<Map<String, dynamic>>(
      Uri.parse(config.tokenUri),
      data: {
        'client_id': config.clientId,
        'client_secret': config.clientSecret,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (_) => true,
      ),
    );
    final decoded = response.data!;
    final statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode >= 300) {
      throw RestAuthException(
        statusCode: statusCode,
        errorCode: decoded['error'] as String? ?? 'UNKNOWN_ERROR',
        rawMessage: decoded['error_description'] as String?,
      );
    }
    return _GoogleTokenResponse.fromJson(decoded).idToken;
  }
}
