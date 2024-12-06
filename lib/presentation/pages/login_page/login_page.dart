import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(children: [
        verticalSpace(100),
        Center(
          child: Image.asset(
            'assets/flix_logo.png',
            width: 150,
          ),
        ),
        verticalSpace(100),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              FlixTextField(
                labelText: 'Email',
                controller: emailController,
              ),
              verticalSpace(24),
              FlixTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              switch (ref.watch(userDataProvider)) {
                AsyncData(:final value) => value == null
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              ref.read(userDataProvider.notifier).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            child: Text(
                              'login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                _ => const Center(
                    child: CircularProgressIndicator(),
                  )
              },
              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('register');
                      },
                      child: Text(
                        'Register here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
