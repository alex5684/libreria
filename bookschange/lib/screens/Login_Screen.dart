import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../component/button.dart';
import '../constants.dart';
import 'Register_Screen.dart';
import '../pages/home_page.dart';
import '../component/enable_local_auth_modal_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Create storage
  final _storage = const FlutterSecureStorage();
  final String KEY_USERNAME = "KEY_USERNAME";
  final String KEY_PASSWORD = "KEY_PASSWORD";
  final String KEY_LOCAL_AUTH_ENABLED = "KEY_LOCAL_AUTH_ENABLED";

  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  bool passwordHidden = true;
  bool _savePassword = true;

  var localAuth = LocalAuthentication();
  // Read values
  Future<void> _readFromStorage() async {
    String isLocalAuthEnabled =
        await _storage.read(key: "KEY_LOCAL_AUTH_ENABLED") ?? "false";

    if ("true" == isLocalAuthEnabled) {
      bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to sign in');

      if (didAuthenticate) {
        _usernameController.text = await _storage.read(key: KEY_USERNAME) ?? '';
        _passwordController.text = await _storage.read(key: KEY_PASSWORD) ?? '';
      }
    } else {
      _usernameController.text = await _storage.read(key: KEY_USERNAME) ?? '';
      _passwordController.text = await _storage.read(key: KEY_PASSWORD) ?? '';
    }
  }

  _onFormSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_savePassword) {
        // reset fingerprint auth values. Only for demo purpose
        await _storage.write(key: KEY_LOCAL_AUTH_ENABLED, value: "false");

        // Write values
        await _storage.write(
            key: KEY_USERNAME, value: _usernameController.text);
        await _storage.write(
            key: KEY_PASSWORD, value: _passwordController.text);

        // check if biometric auth is supported
        if (await localAuth.canCheckBiometrics) {
          // Ask for enable biometric auth
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return EnableLocalAuthModalBottomSheet(
                  action: _onEnableLocalAuth);
            },
          );
        }
      }
    }
  }

  /// Method associated to UI Button in modalBottomSheet.
  /// It enables local_auth and saves data into storage
  _onEnableLocalAuth() async {
    // Save
    await _storage.write(key: KEY_LOCAL_AUTH_ENABLED, value: "true");

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          "Fingerprint authentication enabled.\nClose the app and restart it again"),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading ? const Center(
        child: CircularProgressIndicator(),
      ) : Form(
        key: formkey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        controller: _usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Email";
                          }
                          return null;
                        },
                        textAlign: TextAlign.left,
                        decoration: kTextFieldDecoration.copyWith(
                          //hintText: 'Email',
                          labelText: "Email",
                          labelStyle:
                              const TextStyle(color: Colors.deepOrange),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                        textInputAction: TextInputAction.done,
                        obscureText: passwordHidden,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.left,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.deepOrange),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepOrange,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                            child: Icon(
                              passwordHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.red,
                              size: 23,
                            ),
                          ),
                        ),
                        controller: _passwordController,
                        enableSuggestions: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: false,
                          paste: false,
                          cut: false,
                          selectAll: false,
                          //by default all are disabled 'false'
                        ),
                      ),
                      const SizedBox(height: 80),
                      LoginSignupButton(
                        title: 'Login',
                        ontapp: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              if (!mounted) return;
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => const HomeScreen(
                                    //title: 'URCA',
                                  ),
                                ),
                              );

                              setState(() {
                                isloading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Ops! Login Failed"),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Okay'),
                                    )
                                  ],
                                ),
                              );
                              print(e);
                            }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Don't have an Account ?",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.red),
                            ),
                            SizedBox(width: 10),
                            Hero(
                              tag: '1',
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
