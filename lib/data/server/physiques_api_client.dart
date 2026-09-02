import 'dart:convert';

import 'package:http/http.dart' as http;

import 'physique_table_record.dart';

/// Thrown when `/physiques` responds with a non-2xx status, carrying the
/// status code and validation issues (see `physiques.route.ts`'s
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

/// REST client for `modules/server`'s `/physiques` endpoints. Every
/// method maps directly onto one of the four CRUD endpoints described in
/// `PhysiqueTableEntity`/`physiques.route.ts` — this client does not
/// assemble rows into a table shape, that is left to the caller.
class PhysiquesApiClient {
  const PhysiquesApiClient(this._baseUrl);

  final Uri _baseUrl;

  Future<List<PhysiqueTableRecord>> fetch({
    String? level,
    String? anntenaCategory,
    String? category,
  }) async {
    final response = await http.get(
      _baseUrl.replace(
        path: '/physiques',
        queryParameters: {
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
          'category': ?category,
        },
      ),
    );
    final body = _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<List<PhysiqueTableRecord>> create(
    List<PhysiqueTableRecord> records,
  ) async {
    final response = await http.post(
      _baseUrl.replace(path: '/physiques'),
      headers: _jsonHeaders,
      body: jsonEncode([for (final record in records) record.toJson()]),
    );
    final body = _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<List<PhysiqueTableRecord>> update({
    required int lineOffset,
    required String level,
    required String anntenaCategory,
    required List<List<int>> rowValues,
  }) async {
    final response = await http.put(
      _baseUrl.replace(path: '/physiques'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'lineOffset': lineOffset,
        'level': level,
        'anntenaCategory': anntenaCategory,
        'records': [
          for (final values in rowValues) {'values': values},
        ],
      }),
    );
    final body = _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueTableRecord.fromJson(row),
    ];
  }

  Future<void> delete({String? level, String? anntenaCategory}) async {
    final response = await http.delete(
      _baseUrl.replace(
        path: '/physiques',
        queryParameters: {
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
        },
      ),
    );
    _requireSuccess(response);
  }

  /// Deletes only the rows at [lineOffsets] within one `level`/
  /// `anntenaCategory` table (server re-sequences the remaining rows'
  /// `lineOffset`s afterwards — see `deletePhysiqueTableRows` in
  /// `physiques.route.ts`), rather than the whole table.
  Future<void> deleteRows({
    required String level,
    required String anntenaCategory,
    required List<int> lineOffsets,
  }) async {
    final response = await http.delete(
      _baseUrl.replace(
        path: '/physiques',
        queryParameters: {
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

  List<dynamic> _decodeListOrThrow(http.Response response) {
    _requireSuccess(response);
    return jsonDecode(response.body) as List<dynamic>;
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
