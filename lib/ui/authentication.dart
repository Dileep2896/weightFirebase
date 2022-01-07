import 'package:flutter/material.dart';
import 'package:practise/net/flutterfire.dart';
import 'package:practise/ui/home_view.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  String? error;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
              backgroundColor: Colors.red,
            ),
          )
        : Scaffold(
            body: Container(
            // file the entire screen using MediaQuery
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _emailField,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _passwordField,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      bool shouldNavigate =
                          await register(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        // Navigate
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        loading == true;
                      });
                      String? shouldNavigate =
                          await signIn(_emailField.text, _passwordField.text);
                      if (shouldNavigate == null) {
                        // Navigate
                        setState(() {
                          error = null;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      } else {
                        setState(() {
                          error = shouldNavigate;
                          loading = false;
                        });
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  error == null ? "" : error!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ));
  }
}
