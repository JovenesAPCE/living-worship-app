import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:formz/formz.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state.loginToast.show){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
               SnackBar(content: Text(state.loginToast.message)),
            );
        }
      },
      child: Padding(
          padding: EdgeInsets.all(32),
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: EdgeInsets.all(32)),
                Text(
                  context.strings.loginMyData,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.skyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
                Text(
                  context.strings.loginSignInTitle,
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: AppFont.fontTwo,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
                const SizedBox(height: 30),
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
                const Padding(padding: EdgeInsets.all(6)),
                _LoginHelper(),
                _LoginProgress()
              ],
            ),
          ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (LoginBloc bloc) => bloc.state.username.displayError,
    );

    return TextFormField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: _loginInputDecoration(
        labelText: context.strings.loginDniHint,
        icon: Icons.person,
        errorText: displayError != null ? context.strings.loginInvalidUser : null,
      ),
      cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white)
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (LoginBloc bloc) => bloc.state.birthYear.displayError,
    );

    return TextFormField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginBirthYearChanged(password));
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: _loginInputDecoration(
        labelText: context.strings.loginBirthYearHint,
        icon: Icons.calendar_month,
        errorText: displayError != null ? context.strings.loginBirthYearInvalid : null,
      ),
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white)
    );
  }
}

class _LoginProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final isInProgressOrSuccess = context.select(
          (LoginBloc bloc) => bloc.state.progress,
    );

    if (isInProgressOrSuccess){
      return  Column(
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const CircularProgressIndicator(
            color: AppColor.yellowDark,
          ),
          const Padding(padding: EdgeInsets.all(8)),
          Text(
            context.strings.loginValidatingMessage,
            style: TextStyle(
                color: Colors.white
            ),
          )
        ],
      );
    }else {
      return Container();
    }

  }

}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      onPressed: (){
        context.read<LoginBloc>().add(const LoginSubmitted());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.blueLight, // tu color primario
        foregroundColor: Colors.black, // color del texto
        disabledBackgroundColor: AppColor.blueLight,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        context.strings.loginSignInTitle,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: AppFont.fontTwo
        ),
      ),
    );
  }
}

class _LoginHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('¿Necesitas ayuda?'),
              content: const Text(
                'Si no puedes ingresar, verifica tu DNI y año de nacimiento. '
                    'Si el problema persiste, comunícate con soporte.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          );
        },
        child: Text(
          context.strings.loginCantSignInLink,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
  
}

InputDecoration _loginInputDecoration({
  required String labelText,
  required IconData icon,
  String? errorText,
}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(icon, color: Colors.white),
    filled: true,
    fillColor: Colors.transparent,
    labelStyle: TextStyle(
      color: Colors.white70
    ),
    floatingLabelStyle: const TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white54),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    border: const OutlineInputBorder(),
    errorText: errorText,
  );
}