// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_oauth_client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleOAuthClientConfig _$GoogleOAuthClientConfigFromJson(
  Map<String, dynamic> json,
) => GoogleOAuthClientConfig(
  clientId: json['client_id'] as String,
  clientSecret: json['client_secret'] as String,
  authUri: json['auth_uri'] as String,
  tokenUri: json['token_uri'] as String,
  redirectUris: (json['redirect_uris'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);
