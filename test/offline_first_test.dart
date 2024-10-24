import 'package:flutter_test/flutter_test.dart';
import 'package:offline_first/data/repositories/user_profile_repository.dart';
import 'package:offline_first/data/services/api_client_service.dart';
import 'package:offline_first/data/services/database_service.dart';

void main() {
  final UserProfileRepository userProfileRepository = UserProfileRepository(
    apiClientService: ApiClientService(),
    databaseService: DatabaseService(),
  );

  test('calculate', () async {
    final Stopwatch stopwatch = Stopwatch()..start();
    await userProfileRepository.getUserProfile().listen(
      (userProfile) {
        // Here update the view model and call notifyListeners()
        print('${stopwatch.elapsed} User Profile: ${userProfile.name}');
      },
    ).asFuture();
  });
}
