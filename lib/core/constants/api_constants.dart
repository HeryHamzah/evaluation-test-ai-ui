/// Holds all API endpoint constants used throughout the application.
///
/// This class helps maintain a single source of truth for API URLs,
/// making it easier to update endpoints if the backend changes.
class ApiConstants {
  /// Base URL for the backend API.
  /// Currently pointing to localhost for development.
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  /// Endpoint for uploading documents.
  static const String uploadEndpoint = '/documents/upload';

  /// Endpoint for indexing documents into the vector database.
  static const String indexEndpoint = '/documents/index';

  /// Endpoint for sending chat messages.
  static const String chatEndpoint = '/chat/';

  /// Base endpoint for retrieving document metadata.
  static const String documentsEndpoint = '/documents/';
}
