import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:profile_repository/profile_repository.dart';

class ProfileRepository {
  final profilesCollection = FirebaseFirestore.instance.collection('profiles');

  Future<Profile> getProfileById(String id) async {
    DocumentSnapshot documentSnapshot = await profilesCollection.doc(id).get();
    return Profile.fromEntity(ProfileEntity.fromSnapshot(documentSnapshot));
  }

  Future<List<Profile>> getProfilesByListOfIds(List<String> ids) async {
    QuerySnapshot querySnapshot =
        await profilesCollection.where('id', whereIn: ids).get();
    return querySnapshot.docs
        .map((e) => Profile.fromEntity(ProfileEntity.fromSnapshot(e)))
        .toList();
  }

  Future<void> createProfile(Profile profile) async {
    DocumentReference ref = profilesCollection.doc(profile.id);
    await ref.set(profile.toEntity().toDocument());
  }

  Future<void> editProfile(Profile profile) async {
    await profilesCollection
        .doc(profile.id)
        .update(profile.toEntity().toDocument());
  }
}
