import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show compute;

import 'legend_grid_request.dart';
import 'legend_grid_result.dart';
import 'physique_column_search_query.dart';
import 'physique_evasion_rate_category_row.dart';
import 'physique_search_result.dart';
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
/// method maps onto one CRUD endpoint from `tables.route.ts` — it does not
/// assemble rows into a table shape, that is left to the caller. `type`
/// selects which registered table a call operates on.
class PhysiquesApiClient {
  PhysiquesApiClient(this._baseUrl, {Dio? dio}) : _dio = dio ?? Dio();

  final Uri _baseUrl;
  final Dio _dio;

  /// Every registered table type (see `TableDefinitionEntity` on the
  /// server), so callers never hardcode which types exist.
  Future<List<TableDefinition>> fetchTypes() async {
    final response = await _dio.getUri<String>(
      _baseUrl.replace(path: '/tables/types'),
      options: _plainOptions,
    );
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
    final response = await _dio.getUri<String>(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
          'category': ?category,
        },
      ),
      options: _plainOptions,
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
    final response = await _dio.postUri<String>(
      _baseUrl.replace(path: '/tables'),
      data: jsonEncode([for (final record in records) record.toJson()]),
      options: _jsonOptions,
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
    final response = await _dio.putUri<String>(
      _baseUrl.replace(path: '/tables'),
      data: jsonEncode({
        'lineOffset': lineOffset,
        'type': type,
        'level': level,
        'anntenaCategory': anntenaCategory,
        'records': [
          for (final values in rowValues) {'values': values},
        ],
      }),
      options: _jsonOptions,
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
    final response = await _dio.deleteUri<String>(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': ?level,
          'anntenaCategory': ?anntenaCategory,
        },
      ),
      options: _plainOptions,
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
    final response = await _dio.deleteUri<String>(
      _baseUrl.replace(
        path: '/tables',
        queryParameters: {
          'type': type,
          'level': level,
          'anntenaCategory': anntenaCategory,
          'lineOffsets': lineOffsets.join(','),
        },
      ),
      options: _plainOptions,
    );
    _requireSuccess(response);
  }

  /// Finds every column where a `type`/`against` row pair both equal
  /// [evasionRate]/[hp] at that column — see `findEvasionRateMatches` on
  /// the server. [antenna] is an antenna id, resolved server-side to its
  /// `anntenaCategory`.
  Future<PhysiqueSearchResult> search({
    String type = 'evasionRate',
    String against = 'hp',
    required int evasionRate,
    required int hp,
    String? level,
    String? anntenaCategory,
    String? antenna,
  }) async {
    final query = PhysiqueColumnSearchQuery(
      type: type,
      against: against,
      evasionRate: evasionRate,
      hp: hp,
      level: level,
      anntenaCategory: anntenaCategory,
      antenna: antenna,
    );
    final response = await _dio.getUri<String>(
      _baseUrl.replace(
        path: '/tables/search',
        queryParameters: {
          for (final entry in query.toJson().entries)
            if (entry.value != null) entry.key: '${entry.value}',
        },
      ),
      options: _plainOptions,
    );
    final body = await _decodeMapOrThrow(response);
    return PhysiqueSearchResult.fromJson(body);
  }

  /// Fetches the "matching location" grid for one `level`/`anntenaCategory`
  /// pair, with the cell identified by [request]'s match fields flagged —
  /// see `GET /tables/legend-grid` on the server.
  Future<LegendGridResult> legendGrid(LegendGridRequest request) async {
    final response = await _dio.getUri<String>(
      _baseUrl.replace(
        path: '/tables/legend-grid',
        queryParameters: {
          for (final entry in request.toJson().entries)
            entry.key: '${entry.value}',
        },
      ),
      options: _plainOptions,
    );
    final body = await _decodeMapOrThrow(response);
    return LegendGridResult.fromJson(body);
  }

  /// Every raw physique-category legend row (`GET /tables/evasion-rate-categories`),
  /// untranslated, so a caller can cache them and run identification
  /// offline instead of only through `search`/`legendGrid`.
  Future<List<PhysiqueEvasionRateCategoryRow>>
  fetchEvasionRateCategories() async {
    final response = await _dio.getUri<String>(
      _baseUrl.replace(path: '/tables/evasion-rate-categories'),
      options: _plainOptions,
    );
    final body = await _decodeListOrThrow(response);
    return [
      for (final row in body.cast<Map<String, dynamic>>())
        PhysiqueEvasionRateCategoryRow.fromJson(row),
    ];
  }

  static final Options _plainOptions = Options(
    responseType: ResponseType.plain,
    validateStatus: (_) => true,
  );

  static final Options _jsonOptions = Options(
    contentType: 'application/json',
    responseType: ResponseType.plain,
    validateStatus: (_) => true,
  );

  static List<dynamic> _decodeJsonList(String body) =>
      jsonDecode(body) as List<dynamic>;

  static Map<String, dynamic> _decodeJsonMap(String body) =>
      jsonDecode(body) as Map<String, dynamic>;

  Future<List<dynamic>> _decodeListOrThrow(Response<String> response) async {
    _requireSuccess(response);
    return compute(_decodeJsonList, response.data!);
  }

  Future<Map<String, dynamic>> _decodeMapOrThrow(
    Response<String> response,
  ) async {
    _requireSuccess(response);
    return compute(_decodeJsonMap, response.data!);
  }

  void _requireSuccess(Response<String> response) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      return;
    }
    String? message;
    try {
      final body = jsonDecode(response.data!) as Map<String, dynamic>;
      message = body['error'] as String?;
    } catch (_) {
      message = null;
    }
    throw PhysiqueApiException(statusCode: statusCode, message: message);
  }
}
