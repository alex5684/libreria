import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService
{
  //google sign in
  signInWithGoogle() async
  {
    //begin the interactiv esign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain the details for the request
    final GoogleSignInAuthentication gAuth=await gUser!.authentication;
    //create a new credential for the user
    final credential=GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}