import 'package:flutter/material.dart';
import 'package:offline_first/data/repositories/user_profile_repository.dart';
import 'package:offline_first/domain/model/user_profile.dart';

class UserProfileViewModel extends ChangeNotifier {
  UserProfileViewModel(this._userProfileRepository);

  final UserProfileRepository _userProfileRepository;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> load() async {
    await _userProfileRepository.getUserProfile().listen((userProfile) {
      _userProfile = userProfile;
      notifyListeners();
    }, onError: (error) {
      // handle error
    }).asFuture();
  }

  Future<void> save(String newName) async {
    final newUserProfile = _userProfile?.
    _userProfileRepository.updateUserProfile(_userProfile)
  }
}
