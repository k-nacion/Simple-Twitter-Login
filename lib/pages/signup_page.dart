import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> loginFormState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const heightSpacing = SizedBox(height: 10);
    const contentPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    final requiredValidatorMessage = RequiredValidator(errorText: '* Required');

    final emailValidator = MultiValidator([
      requiredValidatorMessage,
      EmailValidator(errorText: 'Invalid email address'),
    ]);

    final passwordValidator = MultiValidator([
      requiredValidatorMessage,
      MinLengthValidator(
        8,
        errorText: 'Your password does not meet the minimum'
            ' length requirement of 8 characters.',
      ),
      PatternValidator(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$',
        errorText: 'Password must be at least 8 characters long and contain '
            'at least one uppercase letter, one lowercase letter, one number,'
            ' and one special character.',
      ),
    ]);

    return Scaffold(
      /*appBar: AppBar(
        title: Text(
          'Twitter Clone',
          style: TextStyle(color: colorScheme.onInverseSurface),
        ),
        backgroundColor: colorScheme.inversePrimary,
        centerTitle: true,
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Form(
            key: loginFormState,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTwitterLogo(colorScheme),
                const SizedBox(height: 100),
                _buildEmailTextFormField(emailValidator, contentPadding),
                heightSpacing,
                _buildPasswordTextFormField(passwordValidator, contentPadding),
                heightSpacing,
                _buildSignupButton(),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FilledButton _buildSignupButton() {
    return FilledButton.tonal(
      onPressed: () {
        final currentState = loginFormState.currentState;

        if (currentState != null && currentState.validate()) {
          debugPrint('Email: ${emailController.text}');
          debugPrint('Password: ${passwordController.text}');
        }
      },
      child: const Text('Sign Up'),
    );
  }

  TextFormField _buildPasswordTextFormField(
    MultiValidator passwordValidator,
    EdgeInsets contentPadding,
  ) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: passwordValidator.call,
      decoration: InputDecoration(
        label: const Text('Password'),
        contentPadding: contentPadding,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }

  TextFormField _buildEmailTextFormField(MultiValidator emailValidator, EdgeInsets contentPadding) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator.call,
      decoration: InputDecoration(
        label: const Text('Email'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(55),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: contentPadding,
      ),
    );
  }

  FaIcon _buildTwitterLogo(ColorScheme colorScheme) {
    return FaIcon(
      FontAwesomeIcons.twitter,
      color: colorScheme.inversePrimary,
      size: 55,
    );
  }

  TextButton _buildLoginButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Already have an account? Log in here'),
    );
  }
}
