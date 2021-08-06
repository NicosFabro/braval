import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_repository/profile_repository.dart';

class MockProfile extends Mock implements Profile {}

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const id = 'mock-id';
  final profile = MockProfile();

  group('ProfileRepository', () {
    late ProfileRepository profileRepository;

    setUp(() {
      profileRepository = MockProfileRepository();
    });

    test('succeeds when getProfileById succeeds', () async {
      expect(
        profileRepository.getProfileById(id),
        completes,
      );
    });

    test('succeeds when editProfile succeeds', () async {
      expect(
        profileRepository.editProfile(profile),
        completes,
      );
    });
  });
}
