import 'package:json_annotation/json_annotation.dart';

part 'google_oauth_client_config.g.dart';

/// Google OAuth 2.0 "Desktop app" client configuration, in the shape
/// Google Cloud Console exports it (the `{"installed": {...}}` JSON).
/// Used by the REST backend's Google sign-in loopback flow; not needed by
/// the native backend, which gets its own client configuration through
/// `google_sign_in`'s platform-specific setup.
@JsonSerializable(createToJson: false)
class GoogleOAuthClientConfig {
  const GoogleOAuthClientConfig({
    required this.clientId,
    required this.clientSecret,
    required this.authUri,
    required this.tokenUri,
    required this.redirectUris,
  });

  factory GoogleOAuthClientConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthClientConfigFromJson(json);

  factory GoogleOAuthClientConfig.fromInstalledAppJson(Map<String, dynamic> json) =>
      GoogleOAuthClientConfig.fromJson(json['installed'] as Map<String, dynamic>);

  @JsonKey(name: 'client_id')
  final String clientId;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'auth_uri')
  final String authUri;

  @JsonKey(name: 'token_uri')
  final String tokenUri;

  @JsonKey(name: 'redirect_uris')
  final List<String> redirectUris;

  String get redirectUri => redirectUris.first;
}
