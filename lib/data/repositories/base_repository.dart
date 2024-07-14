import 'package:online_store/data/requests/api_client.dart';

abstract class BaseRepository {
  final ApiClient apiClient;

  BaseRepository(this.apiClient);
}