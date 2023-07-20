import 'package:car_reception_flutter/common/api_factory/modules/authentication_module.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // show the password or not
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController idController ;



  late TextEditingController passwordController ;

  @override
  void initState() {
    super.initState();
    getVersionInfoAPI();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          centerTitle: true,
            automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(170),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(80))),
                    child: Image.asset(
                      "assets/images/company-logo.png",
                      height: 190,
                      width: 190,
                      fit:  BoxFit.none,
                    )),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: idController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  const BorderSide(
                          color: Colors.red,
                        ),
                      ) ,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),


                      suffix: IconButton( padding: const EdgeInsets.all(0),icon: const Icon(Icons.close_sharp, color : Colors.black), onPressed: () {
                        setState(() {
                          idController.clear();
                        });
                      },),
                      filled: true,

                      fillColor: Colors.white,
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 17),
                      hintText: 'Username',
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric( horizontal: 20, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    cursorColor: Colors.black,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Please enter your username';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.justify,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Please enter your password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffix:  IconButton(icon: Icon(  _isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.black,), onPressed: () => setState(() {
                        _isObscure = !_isObscure;
                      }), ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  const BorderSide(
                          color: Colors.red,
                        ),
                      ) ,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 17),
                      hintText: 'register number',
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric( horizontal: 20,vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    cursorColor: Colors.red,
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authenticationAPI(idController.text, passwordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                    ),
                    child:  const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
