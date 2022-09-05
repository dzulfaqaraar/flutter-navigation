import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../common/loading_indicator.dart';
import '../../common/navigation.dart';
import '../../common/state_enum.dart';
import '../provider/home_notifier.dart';
import '../provider/login_notifier.dart';
import 'home_page.dart';

final locator = GetIt.instance;

class LoginPage extends StatefulWidget {
  final bool isFromLogout;
  const LoginPage({Key? key, required this.isFromLogout}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<LoginNotifier>(context, listen: false).isLoggedIn(() {
        Navigation.pushReplacement(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<HomeNotifier>(
              create: (_) => HomeNotifier(logoutUser: locator()),
              child: const HomePage(),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Login Page'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<LoginNotifier>(
                    builder: (context, notifier, child) {
                      return TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        enabled: true,
                        validator: (value) =>
                            value != null && !value.contains('@')
                                ? 'Enter a valid email'
                                : null,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Consumer<LoginNotifier>(
                    builder: (context, notifier, child) {
                      return TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter password'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Consumer<LoginNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.state == RequestState.error) {
                        return Text(
                          notifier.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        Provider.of<LoginNotifier>(context, listen: false)
                            .login(
                          context,
                          _usernameController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer<LoginNotifier>(builder: (context, notifier, child) {
          return LoadingIndicator(
            isLoading:
                !widget.isFromLogout && notifier.state == RequestState.loading,
          );
        }),
      ],
    );
  }
}
