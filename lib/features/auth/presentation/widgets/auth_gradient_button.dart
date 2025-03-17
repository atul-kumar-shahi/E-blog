import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key, required this.text,required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
              begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
          onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          fixedSize: Size(395, 55),

        ),
        child: Text(text,style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,

        ),),

      ),
    );
  }
}
