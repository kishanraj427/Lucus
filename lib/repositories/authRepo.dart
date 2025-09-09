import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api/sessionHandler.dart';
import '../models/user.dart';

class AuthRepository {
  final SessionHandler _sessionHandler;

  AuthRepository(this._sessionHandler);

  Future<User> getUserProfile() async {
    try {
      // Mock API call; replace with real endpoint
      return await _sessionHandler.get<User>(
        '/profile',
        fromJson: (data) => User.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _sessionHandler.post('/logout');
    } catch (e) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final sessionHandler = ref.watch(sessionHandlerProvider);
  return AuthRepository(sessionHandler);
});
