import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color,textColor;
  final bool loading;
  const RoundButton({super.key,
  required this.onPress,
   this.color=AppColors.primaryColor,
   this.textColor=AppColors.whiteColor,
   this.loading=false,
  required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryTextTextColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text(title,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16,color: textColor))),
      ),
    );
  }
}