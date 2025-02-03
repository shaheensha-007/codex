
import 'dart:ui';

import 'package:codex/View/Homepage.dart';
import 'package:codex/widgets/NavigationServies.dart';
import 'package:codex/widgets/reponsive_Size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloces/Login_blocs/login_bloc.dart';

class Loginin extends StatefulWidget {
  const Loginin({super.key});

  @override
  State<Loginin> createState() => _LogininState();
}
final GlobalKey<FormState> _Loginkey = GlobalKey<FormState>();
TextEditingController Emailcontroller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();

class _LogininState extends State<Loginin> {
  bool _isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,backgroundColor: Theme.of(context).colorScheme.background,),
      backgroundColor:Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Form(
                key: _Loginkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.rh(context),
                    ),
                    Text("Login in", style: TextStyle(fontSize: 20,),),
                    SizedBox(
                      height: 100.rh(context),
                    ),
                    _buildTextField(controller: Emailcontroller, hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email Id';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        // Add more validation rules if needed
                        return null;
                      },),
                    SizedBox(
                      height: 20.rh(context),
                    ),
                    _buildTextField(controller:passwordcontroller,hintText: "Password",validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter password';
                      }
                    },
                      isPassword: true,
                      isVisible: _isPasswordVisible,
                      toggleVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },

                    ),
                    SizedBox(
                      height: 10.rh(context),
                    ),
                    BlocListener<LoginBloc, LoginState>(
                   listener: (context, state)async {
                     final preferences = await SharedPreferences.getInstance();
                     if(state is LoginblocLoading){
                       showDialog(
                         context: context,
                         barrierDismissible: false,
                         builder: (BuildContext context) {
                           return const Center(child: CircularProgressIndicator());
                         },
                       );
                     }
                     if(state is LoginblocLoaded){
                       Navigator.of(context,rootNavigator: true).pop();
                       final singlelogin=state.loginModel;
                       preferences.setString("Username1", Emailcontroller.text);
                       preferences.setString("password1", passwordcontroller.text);
                       NavigationService.pushAndRemoveUntil(Homepage(), (Route<dynamic>route) => false);


                     }
                     if(state is LoginblocError){
                       Navigator.of(context,rootNavigator: true).pop();
                     _showErrorSnackBar(state.Errormessage);
                     }
                   },
                       child: InkWell(
                      onTap: (){
                        if(_Loginkey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(FetchLogin(
                              Email:Emailcontroller.text , password:passwordcontroller.text));
                        }

                      },
                      child: Container(
                          height: 50.rh(context),
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff5151c4),
                          ),
                          child: Center(
                            child: Text("CONTINUE",
                              style: TextStyle(color: Colors.white),),
                          )
                      ),
                    ),
),
                    SizedBox(
                      height: 20.rh(context),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
    List<TextInputFormatter>? inputFormatters,
    List<String>? autofillHints,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),

        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        inputFormatters: inputFormatters,
        validator: validator,
        style: TextStyle(
          fontSize: 18,
          fontFamily: "regulartext",
          color: Theme.of(context).colorScheme.secondary,
        ),
        autofillHints: autofillHints,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
          ),
          //  prefixIcon: prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: toggleVisibility,
          )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
  void _showErrorSnackBar(String message) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            backgroundColor: Colors.white, // Set the background color
            contentPadding: EdgeInsets.zero, // Remove default padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Customize corner radius
            ),
            content: Container(
              constraints: BoxConstraints(
                maxWidth: 300, // Set the maximum width
                minHeight: 150, // Set the minimum height
              ),
              padding: const EdgeInsets.all(16), // Padding for content
              color: Colors.blueGrey[50], // Set the container's background color
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style:  TextStyle(
                      fontSize: 12.rf(context),
                      fontFamily: "font2",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff284389),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text("OK", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: "regulartext",
                        color: Colors.white,
                      ),), // Button text
                    ),
                  ), // Add spacing between text and button
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}