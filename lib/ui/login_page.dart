import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistic/src/extension/navigator_extension.dart';
import 'package:logistic/src/extension/number_extension.dart';

import '../business_logic/bloc/login/login_bloc.dart';
import '../common_widget/animated_button.dart';
import '../common_widget/textfield_widget.dart';
import '../route/route_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFocus = false;
  bool? condition;
  late LoginBloc _loginBloc;

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = context.read<LoginBloc>()..add(LoginSessionCheckEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              const SizedBox(
                height: 20,
              ),
              _passwordField(),
              const SizedBox(
                height: 20,
              ),
              _loginButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    ButtonStatus status = ButtonStatus.start;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          // status = ButtonStatus.success;
          context.pushReplace(route: RouteList.mainHomePage);
        }
      },
      builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          status = ButtonStatus.loading;
        } else if (state.status == LoginStatus.fail) {
          status = ButtonStatus.fail;
        } else if (state.status == LoginStatus.initial) {
          status = ButtonStatus.start;
        }
        return GestureDetector(
            onTap: () {
              if (_formKey.currentState?.validate() == true) {
                _loginBloc.add(UserLoginEvent(
                    username: _usernameController.text,
                    password: _passwordController.text));
              }
            },
            child: AnimatedButton(
              buttonText: 'Login',
              status: status,
              buttonColor: Colors.orangeAccent,
            ));
      },
    );
  }

  Widget _usernameField() {
    return TextFieldWidget(
      controller: _usernameController,
      validator: (username) {
        if (username == null || username == '') {
          return 'required';
        }
      },
      hintText: "username",
      prefixIcon: const Icon(Icons.person),
      backgroundColor: Colors.white,
      accentColor: Colors.orangeAccent,
      borderRadius: 10,
      isShadow: false,
      height: 50,
      focusNode: _usernameNode,
    );
  }

  Widget _passwordField() {
    return TextFieldWidget(
      validator: (password) {
        if (password == null || password == '') {
          return 'required';
        }
      },
      controller: _passwordController,
      focusNode: _passwordNode,
      hintText: "password",
      prefixIcon: const Icon(Icons.key),
      backgroundColor: Colors.white,
      accentColor: Colors.orangeAccent,
      borderRadius: 10,
      isShadow: false,
      isPassword: true,
      suffixIcon: const Icon(Icons.key),
      height: 50,
    );
  }

  Widget _a({void Function()? onTap}) {
    return Container(
      height: 50,
      decoration:
          BoxDecoration(border: Border.all(), borderRadius: 20.borderRadius),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              // alignment: Alignment.centerRight,
              width: isFocus ? 500 : 40,
              height: isFocus ? 50 : 30,
              margin: EdgeInsets.only(right: isFocus ? 0 : 7),
              duration: 500.millisecond,
              decoration: BoxDecoration(
                borderRadius: isFocus
                    ? 20.borderRadius
                    : BorderRadius.all(Radius.circular(60)),
                color: Colors.orangeAccent,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFocus = !isFocus;
              });
            },
            child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.key,
                    color: Colors.white,
                  ),
                )),
          ),
          Center(
            child: Text(
              "This is input text",
              style: TextStyle(
                  color: isFocus ? Colors.white : Colors.orangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}
