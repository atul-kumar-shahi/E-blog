import 'package:blog/core/common/widgets/custom_loader.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../blog/presentation/pages/blog_page.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
   static route() =>MaterialPageRoute(builder: (context)=>const SignupPage());

   const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey=GlobalKey<FormState>();
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                const Text(
                  "Sign Up.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthField(hintText: 'Name',controller: _nameController,),
                const SizedBox(
                  height: 15,
                ),
                 AuthField(hintText: 'Email',controller: _emailController,),
                const SizedBox(
                  height: 15,
                ),
                AuthField(hintText: 'Password',controller: _passwordController,isObscureText: true),
                const SizedBox(
                  height: 20,
                ),
                AuthGradientButton(text: 'Sign Up',onTap: (){
                  if(formKey.currentState!.validate()){
                     context.read<AuthBloc>().add(AuthSignUp(name: _nameController.text.trim(), email: _emailController.text.trim(), password: _passwordController.text.trim()));
                  }
                },),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                      Navigator.push(context,SigninPage.route());
            
                  },
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
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
          ),
        );
  },
),
      ),
    );
  }
}
