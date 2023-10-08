import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_application/shared/components/components.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscure = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      label: "Email Address",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your Email address';
                        }
                        return null;
                      },
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      label: "password",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                        return null;
                      },
                      prefix: Icons.lock,
                      suffix: obscure? Icons.visibility : Icons.visibility_off,
                      suffixpressed: (){
                        setState(() {
                          obscure =! obscure ;
                        });
                      },
                      obsecuretext: obscure),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultButton(
                        text: 'Login',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            print(emailController);
                            print(passwordController);
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ? "),
                      TextButton(
                          onPressed: () {}, child: const Text("Register Now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
