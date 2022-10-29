import 'package:crypto_wallet/net/flutter_fire.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.lightBlueAccent),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, bottom: 50, top: 80),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ), // email
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 80),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
              ), // password
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: MaterialButton(
                        onPressed: () async {
                          bool shouldNavigate = await register(
                              _emailController.text, _passwordController.text);
                          if (shouldNavigate) {
                            // Navigate
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homeview(),
                              ),
                            );
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: MaterialButton(
                          onPressed: () async {
                            bool shouldNavigate = await signIn(
                                _emailController.text,
                                _passwordController.text);
                            if (shouldNavigate) {
                              // Navigate
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homeview(),
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                  ),
                ],
              ), // 2 containers for buttons
            ],
          ),
        ),
      )),
    );
  }
}
