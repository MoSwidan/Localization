import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success').tr(),
        content: const Text('MSG1').tr(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
               _navigateWithFade();
            },
            child: const Text('Close').tr(),
          ),
        ],
      ),
    );
  }
   void _navigateWithFade() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1), // Set the duration of the fade animation
      ),
    );
  }
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }else{
      _showErrorSnackbar("error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp').tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(onPressed: () {context.setLocale(context.locale == const Locale('ar','EG') ? const Locale('en','US') : const Locale('ar','EG'));}, child: const Icon(Icons.language)),
              TextFormField(
                controller: _fullNameController,
                decoration:  InputDecoration(labelText: tr('FullName')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('MSG2');
                  } else if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                    return tr('MSG3');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: tr('Email')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('MSG4');
                  } else if (!value.contains('@')) {
                    return tr('MSG5');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: tr('Password')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('MSG6');
                  } else if (value.length < 6) {
                    return tr('MSG7');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: tr('ConfirmPassword')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('MSG8');
                  } else if (value != _passwordController.text) {
                    return tr('MSG9');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndSubmit,
                child: const Text('SignUp').tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}