import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:http/http.dart' as http;

import 'physique_table_record.dart';
import 'table_definition.dart';

/// Thrown when `/tables` responds with a non-2xx status, carrying the
/// status code and validation issues (see `tables.route.ts`'s
/// `zodErrorResponse`) so callers see the real reason rather than treating
/// the request as having succeeded.
class PhysiqueApiException implements Exception {
  const PhysiqueApiException({required this.statusCode, this.message});

  final int statusCode;
  final String? message;

  @override
  String toString() =>
      'PhysiqueApiException($statusCode)${message != null ? ': $message' : ''}';
}

/// REST client for `modules/server`'s generic `/tables` endpoints. Every
/// method maps directly onto one of the CRUD endpoints described in
/// `tables.route.ts` — this client does not assemble rows into a table
/// shape, that is left to the caller. `type` selects which registered
/// table (see `TableDefinition`/`GET /tables/types`) a call operates on.
class PhysiquesApiClient {
  const PhysiquesApiClient(this._baseUrl);

  final Uri _baseUrl;

  /// Every registered table type (see `TableDefinitionEntity` on the
  /// server), so callers never hardcode which types exist.
  Future<List<TableDefinition>> fetchTypes() async {
    final response = await http.get(_baseUrl.replace(path: '/tables/types'));
    final body = await _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        TableDefinition.fromJson(row),
    ];
  }

  Future<List<PhysiqueTableRecord>> fetch({
    required String type,
    String? level,
    String? anntenaCategory,
    String? category,
  }) async {
    final response = await http.get(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
          'category': ?category,
        },
      ),
    );
    final body = await _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<List<PhysiqueTableRecord>> create(
    List<PhysiqueTableRecord> records,
  ) async {
    final response = await http.post(
      _baseUrl.replace(path: '/tables'),
      headers: _jsonHeaders,
      body: jsonEncode([for (final record in records) record.toJson()]),
    );
    final body = await _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<List<PhysiqueTableRecord>> update({
    required int lineOffset,
    required String type,
    required String level,
    required String anntenaCategory,
    required List<List<int?>> rowValues,
  }) async {
    final response = await http.put(
      _baseUrl.replace(path: '/tables'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'lineOffset': lineOffset,
        'type': type,
        'level': level,
        'anntenaCategory': anntenaCategory,
        'records': [
          for (final values in rowValues) {'values': values},
        ],
      }),
    );
    final body = await _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<void> delete({
    required String type,
    String? level,
    String? anntenaCategory,
  }) async {
    final response = await http.delete(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
        },
      ),
    );
    _requireSuccess(response);
  }

  /// Deletes only the rows at [lineOffsets] within one `type`/`level`/
  /// `anntenaCategory` table (server re-sequences the remaining rows'
  /// `lineOffset`s afterwards — see `deleteTableRows` in
  /// `tables.route.ts`), rather than the whole table.
  Future<void> deleteRows({
    required String type,
    required String level,
    required String anntenaCategory,
    required List<int> lineOffsets,
  }) async {
    final response = await http.delete(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': level,
          'anntenaCategory': anntenaCategory,
          'lineOffsets': lineOffsets.join(','),
        },
      ),
    );
    _requireSuccess(response);
  }

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };

  static List<dynamic> _decodeJsonList(String body) => jsonDecode(body) as List<dynamic>;

  Future<List<dynamic>> _decodeListOrThrow(http.Response response) async {
    _requireSuccess(response);
    return compute(_decodeJsonList, response.body);
  }

  void _requireSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    String? message;
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      message = body['error'] as String?;
    } catch (_) {
      message = null;
    }
    throw PhysiqueApiException(statusCode: response.statusCode, message: message);
  }
}
