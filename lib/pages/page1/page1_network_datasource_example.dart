import 'package:mobile_app_skeleton/core/connectivity_checker.dart';
import 'package:mobile_app_skeleton/core/exceptions.dart';
import 'package:mobile_app_skeleton/core/http_client.dart';
import 'package:mobile_app_skeleton/core/logger.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_item_entity.dart';

/// Example of a network-enabled datasource using the HTTP client.
///
/// This demonstrates best practices for implementing a datasource that:
/// - Uses the HTTP client for API calls
/// - Checks connectivity before making requests
/// - Properly handles errors and exceptions
/// - Logs operations for debugging
/// - Converts JSON responses to entities
///
/// This is a reference implementation - copy this pattern when implementing
/// your own network-enabled datasources.
class Page1NetworkDataSource {
  final HttpClient _client;
  final ConnectivityChecker _connectivity;

  Page1NetworkDataSource({
    HttpClient? client,
    ConnectivityChecker? connectivity,
  })  : _client = client ?? HttpClient(),
        _connectivity = connectivity ?? ConnectivityChecker();

  /// Fetch items from the API.
  ///
  /// Throws [NoConnectionException] if no network connection.
  /// Throws [ServerException] if the server returns an error.
  /// Throws [ParseException] if the response cannot be parsed.
  Future<List<Page1ItemEntity>> fetchItems({String? query}) async {
    // 1. Check connectivity first
    final hasConnection = await _connectivity.hasConnection;
    if (!hasConnection) {
      AppLogger.w('No network connection available');
      throw const NoConnectionException(
        message: 'No internet connection. Please check your network.',
      );
    }

    try {
      // 2. Build query parameters
      final queryParams = query != null && query.isNotEmpty
          ? {'search': query}
          : <String, dynamic>{};

      // 3. Make the API call
      AppLogger.d('Fetching items from API with query: $query');
      final response = await _client.get(
        '/api/v1/items',
        queryParameters: queryParams,
      );

      // 4. Parse and validate response
      if (response.data == null) {
        throw const EmptyResponseException(
          message: 'Server returned empty response',
        );
      }

      // 5. Convert JSON to entities
      final List<dynamic> jsonList = response.data as List<dynamic>;
      final items = jsonList
          .map((json) => Page1ItemEntity.fromJson(json as Map<String, dynamic>))
          .toList();

      AppLogger.i('Successfully fetched ${items.length} items');
      return items;
    } on ServerException {
      // Let server exceptions pass through
      rethrow;
    } on AuthenticationException {
      // Let auth exceptions pass through
      rethrow;
    } on NoConnectionException {
      // Let connection exceptions pass through
      rethrow;
    } catch (e, stackTrace) {
      // Wrap unexpected errors
      AppLogger.e('Failed to fetch items', error: e, stackTrace: stackTrace);
      throw const ParseException(
        message: 'Failed to parse items from server response',
      );
    }
  }

  /// Fetch a single item by ID.
  Future<Page1ItemEntity> fetchItemById(String id) async {
    final hasConnection = await _connectivity.hasConnection;
    if (!hasConnection) {
      throw const NoConnectionException();
    }

    try {
      AppLogger.d('Fetching item with id: $id');
      final response = await _client.get('/api/v1/items/$id');

      if (response.data == null) {
        throw const EmptyResponseException(
          message: 'Item not found',
        );
      }

      final item = Page1ItemEntity.fromJson(
        response.data as Map<String, dynamic>,
      );

      AppLogger.i('Successfully fetched item: ${item.id}');
      return item;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch item', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Create a new item on the server.
  Future<Page1ItemEntity> createItem({
    required String title,
    required String subtitle,
  }) async {
    final hasConnection = await _connectivity.hasConnection;
    if (!hasConnection) {
      throw const NoConnectionException();
    }

    try {
      final data = {
        'title': title,
        'subtitle': subtitle,
      };

      AppLogger.d('Creating new item: $data');
      final response = await _client.post('/api/v1/items', data: data);

      if (response.data == null) {
        throw const EmptyResponseException(message: 'Failed to create item');
      }

      final item = Page1ItemEntity.fromJson(
        response.data as Map<String, dynamic>,
      );

      AppLogger.i('Successfully created item: ${item.id}');
      return item;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to create item', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Update an existing item.
  Future<Page1ItemEntity> updateItem({
    required String id,
    String? title,
    String? subtitle,
  }) async {
    final hasConnection = await _connectivity.hasConnection;
    if (!hasConnection) {
      throw const NoConnectionException();
    }

    try {
      final data = <String, dynamic>{};
      if (title != null) data['title'] = title;
      if (subtitle != null) data['subtitle'] = subtitle;

      AppLogger.d('Updating item $id: $data');
      final response = await _client.patch('/api/v1/items/$id', data: data);

      if (response.data == null) {
        throw const EmptyResponseException(message: 'Failed to update item');
      }

      final item = Page1ItemEntity.fromJson(
        response.data as Map<String, dynamic>,
      );

      AppLogger.i('Successfully updated item: ${item.id}');
      return item;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to update item', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Delete an item from the server.
  Future<void> deleteItem(String id) async {
    final hasConnection = await _connectivity.hasConnection;
    if (!hasConnection) {
      throw const NoConnectionException();
    }

    try {
      AppLogger.d('Deleting item: $id');
      await _client.delete('/api/v1/items/$id');
      AppLogger.i('Successfully deleted item: $id');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to delete item', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Dispose of resources.
  void dispose() {
    _connectivity.dispose();
  }
}
