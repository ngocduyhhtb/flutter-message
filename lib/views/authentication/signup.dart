import 'package:bot_toast/bot_toast.dart';
import 'package:chat_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:chat_app/bloc/register_bloc/register_bloc.dart';
import 'package:chat_app/bloc/register_bloc/register_state.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/views/authentication/signin.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  SignUp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Sign Up", false, false),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpForm(
                userRepository: _userRepository,
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(
                        userRepository: _userRepository,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account? ",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "Sign in now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  @override
  _SignUpFormState createState() => _SignUpFormState();

  SignUpForm({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  bool formValidate() {
    return formKey.currentState!.validate();
  }

  void _onFormSubmitted() {
    if (formValidate()) {
      _registerBloc.add(RegisterSubmitted(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }
        if (state.isSubmitting) {
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Registering...'),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            ),
            backgroundColor: Color(0xffffae88),
          );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(EmailLoggedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (validator) {
                      if (validator!.isEmpty || validator.length == 0) {
                        return "This field is require";
                      }
                      if (validator.isNotEmpty) {
                        final bool isValid = EmailValidator.validate(validator);
                        return isValid ? null : "Not a email";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.account_box, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (validator) {
                      String pattern =
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                      RegExp regex = new RegExp(pattern);
                      if (validator!.length < 6) {
                        return "Passwords must be at least 6 characters long";
                      }
                      if (!regex.hasMatch(_passwordController.text)) {
                        return "Password contains : digits, lowercase characters and special characters";
                      }
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                //   child: TextFormField(
                //     validator: (validator) {
                //       if (_repeatPasswordController.text !=
                //           _passwordController.text) {
                //         return "Repeat password does not match";
                //       }
                //     },
                //     obscureText: true,
                //     enableSuggestions: false,
                //     autocorrect: false,
                //     style: TextStyle(color: Colors.white),
                //     decoration: InputDecoration(
                //       enabledBorder: UnderlineInputBorder(
                //           borderSide: const BorderSide(
                //               color: Colors.white, width: 2.0)),
                //       hintText: "Repeat password",
                //       hintStyle: TextStyle(color: Colors.white),
                //       prefixIcon: Icon(
                //         Icons.vpn_key,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    BotToast.showLoading(
                        allowClick: false,
                        clickClose: false,
                        backButtonBehavior: BackButtonBehavior.ignore);
                    _onFormSubmitted();
                    BotToast.closeAllLoading();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Sign up with email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
