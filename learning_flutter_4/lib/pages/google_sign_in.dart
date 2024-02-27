import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> handleSignIn() async {
  try {
    await googleSignIn.signIn();
    // Successfully signed in
  } catch (error) {
    print('Error signing in: $error');
    // Handle sign in failed
  }
}

Future<void> handleSignOut() async {
  await googleSignIn.signOut();
  print('User signed out');
}
