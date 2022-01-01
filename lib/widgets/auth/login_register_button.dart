import 'package:flutter/material.dart';
// import 'package:incredibclap/models/user_model.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({
    Key? key,
    required this.text, 
    required this.onPressed
    
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {


    final loginProvider = Provider.of<LoginProvider>(context);
    
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: const Color.fromRGBO(185, 226, 140, 1),
      child: Container(
        padding: const  EdgeInsets.symmetric( horizontal: 80, vertical: 15),
        child: Text(
          loginProvider.isLoading
            ? 'Espere...'
            : text, 
          style: const TextStyle( color: Colors.white) 
        )
      ),
      onPressed: loginProvider.isLoading ? null : () async{

          FocusScope.of(context).unfocus(); // Quitar teclado
          loginProvider.isLoading = true;
          
          loginProvider.isValidForm() 
            ? onPressed()
            : null;

          

          loginProvider.isLoading = false;
          
      }
    );
  }
}