import 'package:chat_app/model/user_email.dart';
import 'package:chat_app/utils/network_util/api_client.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

final SecureStorage _secureStorage = GetIt.I.get<SecureStorage>();
final ApiClient _apiClient = GetIt.I.get<ApiClient>();

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio = new Dio();
  final _logger = Logger();

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _logger.d(googleAuth.idToken);
    await _apiClient.sendTokenToServer(userToken: googleAuth.idToken);
  }

  Future<void> signInWithEmail(String email, String password) async {
    _apiClient.loginUser(
        userEmail: new UserEmail(email: email, password: password));
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isGoogleSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  getUser() async {
    String emailUser = "";
    User googleUser;
    if (isGoogleSignedIn() == true) {
      googleUser = (await _firebaseAuth.currentUser)!;
      return googleUser.email;
    }
    await _secureStorage
        .readValue(App.SECURE_STORAGE_EMAIL)
        .then((value) => emailUser = value);
    return emailUser;
  }
}
