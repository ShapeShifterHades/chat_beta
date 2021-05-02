// import 'package:meta/meta.dart';
// import 'package:void_chat_beta/core/constants/app_keys.dart';
// import 'package:void_chat_beta/data/models/app_user/app_user.dart';
// import 'package:void_chat_beta/data/services/firebase_service_firedart.dart';
// import 'package:void_chat_beta/data/services/firebase_service_native.dart';
// import 'package:void_chat_beta/data/utils/device_info.dart';

// class FireIds {
//   static const String users = "users";
//   static const String pages = "pages";
//   static const String pageBoxes = "boxes";
// }

// // Returns the correct Firebase instance depending on platform
// class FirebaseFactory {
//   static bool _initComplete = false;

//   // Determine which platforms we can use the native sdk on
//   static bool get useNative =>
//       DeviceOS.isMobileOrWeb; // || UniversalPlatform.isMacOS;

//   static FirebaseService create() {
//     FirebaseService service = useNative
//         ? NativeFirebaseService()
//         : DartFirebaseService(
//             apiKey: AppKeys.firebaseApiKey,
//             projectId: AppKeys.firestoreProjectId,
//           );
//     if (_initComplete == false) {
//       _initComplete = true;
//       service.init();
//     }
//     print("firestore-${useNative ? "NATIVE" : "DART"} Initialized");
//     return service;
//   }
// }

// abstract class FirebaseService {
//   String? _userId;
//   String? get userId => _userId;
//   set userId(String? value) => _userId = value;
//   List<String> get userPath => [FireIds.users, userId ?? ""];
//   // Helper method for getting a path from keys, and optionally prepending the scope (users/email)
//   String getPathFromKeys(List<String> keys, {bool addUserPath = true}) {
//     String path =
//         addUserPath ? userPath.followedBy(keys).join("/") : keys.join("/");
//     if (FirebaseFactory.useNative) {
//       return path.replaceAll("//", "/");
//     }
//     return path;
//   }
//   /////////////////////////////////////////////////////////
//   // USERS
//   /////////////////////////////////////////////////////////

//   Future<AppUser?> getUser() async {
//     try {
//       Map<String, dynamic>? data = await getDoc([]);
//       return data == null ? null : AppUser.fromJson(data);
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<String> addUser(AppUser value) async {
//     return await addDoc([FireIds.users], value.toJson(),
//         documentId: value.documentId);
//   }

//   Future<void> setUserData(AppUser value) async {
//     await updateDoc(["/"], value.toJson());
//   }

//   ///////////////////////////////////////////////////
//   // Abstract Methods
//   //////////////////////////////////////////////////
//   void init();

//   // Auth
//   Future<AppUser?> signIn(
//       {required String email,
//       required String password,
//       bool createAccount = false});
//   bool get isSignedIn;
//   @mustCallSuper
//   Future<void> signOut() async {
//     userId = null;
//   }

//   Stream<Map<String, dynamic>>? getDocStream(List<String> keys);
//   Stream<List<Map<String, dynamic>>>? getListStream(List<String> keys);

//   Future<Map<String, dynamic>?> getDoc(List<String> keys);
//   Future<List<Map<String, dynamic>>?> getCollection(List<String> keys);

//   Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
//       {String documentId, bool addUserPath = true});
//   Future<void> updateDoc(List<String> keys, Map<String, dynamic> json);
//   Future<void> deleteDoc(List<String> keys);
// }

// bool checkKeysForNull(List<String> keys) {
//   if (keys.contains(null)) {
//     print("ERROR: invalid key was passed to firestore: $keys");
//     return false;
//   }
//   return true;
// }
