// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_toolkit_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityToolkitAccountResponse _$IdentityToolkitAccountResponseFromJson(
  Map<String, dynamic> json,
) => IdentityToolkitAccountResponse(
  idToken: json['idToken'] as String,
  refreshToken: json['refreshToken'] as String,
  localId: json['localId'] as String,
  expiresIn: json['expiresIn'] as String,
  email: json['email'] as String?,
);

SecureTokenRefreshResponse _$SecureTokenRefreshResponseFromJson(
  Map<String, dynamic> json,
) => SecureTokenRefreshResponse(
  idToken: json['id_token'] as String,
  refreshToken: json['refresh_token'] as String,
  userId: json['user_id'] as String,
  expiresIn: json['expires_in'] as String,
);

IdentityToolkitSession _$IdentityToolkitSessionFromJson(
  Map<String, dynamic> json,
) => IdentityToolkitSession(
  idToken: json['idToken'] as String,
  refreshToken: json['refreshToken'] as String,
  localId: json['localId'] as String,
  email: json['email'] as String?,
  expiresAt: IdentityToolkitSession._dateTimeFromEpochMs(
    (json['expiresAt'] as num).toInt(),
  ),
);

Map<String, dynamic> _$IdentityToolkitSessionToJson(
  IdentityToolkitSession instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'refreshToken': instance.refreshToken,
  'localId': instance.localId,
  'email': instance.email,
  'expiresAt': IdentityToolkitSession._dateTimeToEpochMs(instance.expiresAt),
};

_GoogleTokenResponse _$GoogleTokenResponseFromJson(Map<String, dynamic> json) =>
    _GoogleTokenResponse(idToken: json['id_token'] as String);
