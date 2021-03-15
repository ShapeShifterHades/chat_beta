import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firestore_repository/firestore_repository.dart';

class MockFireStore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  FirebaseFirestore instance;

  setUp(() {
    assert(true == false, 'This shit must`nt work');

    // act

    // assert
  });
}
