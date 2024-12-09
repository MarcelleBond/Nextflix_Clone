import 'package:appwrite/appwrite.dart';

import '../constants/appwrite_config.dart';

class ApiClient {
  Client get _client {
    Client client = Client();
    
    client
    .setEndpoint(AppwriteConfig.projectEndpoint)
    .setProject(AppwriteConfig.projectId)
    .setSelfSigned(status: true);
     
    return client;
  }
  
  static Account get account  => Account(_instacne._client);
  static Databases get databases  => Databases(_instacne._client);
  static Storage get storage  => Storage(_instacne._client);
  
  static final ApiClient _instacne = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instacne;
}