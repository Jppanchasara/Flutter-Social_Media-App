import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key,
  required this.myController,
      required this.focusNode,
      required this.onFieldsubmmitedvalue,
      required this.onValidator,
      required this.hint,
      required this.keyBoardType,
      required this.obscureText,
      this.enable = true,
      this.autoFocus = false
  
  });

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldsubmmitedvalue;
  final FormFieldValidator onValidator;
  final String hint;
  final TextInputType keyBoardType;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        
        controller: myController,
        obscureText: obscureText,
        focusNode: focusNode,
        onFieldSubmitted: onFieldsubmmitedvalue,
        validator: onValidator,
        cursorColor:Colors.black,
        keyboardType: keyBoardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 19),
        decoration: InputDecoration(
          enabled: enable,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.all(Radius.circular(8))
    
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
    
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
    
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
    
          )
        ),
    
      ),
    );
  }
}