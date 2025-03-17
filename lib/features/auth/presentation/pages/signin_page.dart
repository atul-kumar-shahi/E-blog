import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SigninPage extends StatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>SigninPage());
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> { final formKey=GlobalKey<FormState>();
final _emailController=TextEditingController();
final _passwordController=TextEditingController();

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is AuthFailure){
      showSnackBar(context, state.message);
    }else if(state is AuthSuccess){
      Navigator.pushAndRemoveUntil(context, BlogPage.route() , (route)=>false);
    }
  },
  builder: (context, state) {
    if(state is AuthLoading){
      return const CustomLoader();
    }
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthField(hintText: 'Email',controller: _emailController,),
            const SizedBox(
              height: 15,
            ),
            AuthField(hintText: 'Password',controller: _passwordController,isObscureText: true),
            const SizedBox(
              height: 20,
            ),
             AuthGradientButton(text: 'Sign In',onTap: (){
               if(formKey.currentState!.validate()){
                 context.read<AuthBloc>().add(AuthSignIn(email: _emailController.text.trim(), password: _passwordController.text.trim()));
               }
             },),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap:(){
                Navigator.push(context, SignupPage.route());
                },
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      );
  },
),
    ),
  );
}
}
