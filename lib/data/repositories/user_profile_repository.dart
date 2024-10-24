import 'package:offline_first/data/services/api_client_service.dart';
import 'package:offline_first/data/services/database_service.dart';

import '../../domain/model/user_profile.dart';

class UserProfileRepository {
  UserProfileRepository({
    required ApiClientService apiClientService,
    required DatabaseService databaseService,
  })  : _apiClientService = apiClientService,
        _databaseService = databaseService;

  final ApiClientService _apiClientService;
  final DatabaseService _databaseService;

  Stream<UserProfile> getUserProfile() async* {
    // Fetch the user profile from the database
    final userProfile = await _databaseService.fetchUserProfile();
    // Returns the database result if it exists
    if (userProfile != null) {
      yield userProfile;
    }

    // Fetch the user profile from the API
    try {
      final apiUserProfile = await _apiClientService.getUserProfile();
      //Update the database with the API result
      await _databaseService.updateUserProfile(apiUserProfile);
      // Return the API result
      yield apiUserProfile;
    } catch (e) {
      // Handle the error
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      // Update the API with the user profile
      await _apiClientService.putUserProfile(userProfile);

      // Only if the API call was successful
      // update the database with the user profile
      await _databaseService.updateUserProfile(userProfile);
    } catch (e) {
      // Handle the error
    }
  }
}
