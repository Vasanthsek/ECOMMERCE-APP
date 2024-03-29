import 'package:ecommerce_app/screens/auth/forget_password.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../consts/colors.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
 const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
 bool _obscureText = true;
var _emailAddress;
 var _password;
  final _formKey = GlobalKey<FormState>();
    final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }
  void _submitForm() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try{
      await  _auth.signInWithEmailAndPassword(email: _emailAddress.toString().toLowerCase().trim(), password: _password.toString().toLowerCase().trim()).then((value) =>
                Navigator.canPop(context) ? Navigator.pop(context) : null);
      }on FirebaseAuthException catch (e){
        _globalMethods.authDialog("${e.message}",context);
        print("Error Occured ${e.message}");
      }finally{
        setState(() {
      _isLoading = false;
    });
      }
     
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                      [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.25],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    //  color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        'images/login.png',  
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                 filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 15,left: 10),
                                  child: const FaIcon(FontAwesomeIcons.envelope,size: 18),
                                ),
                                labelText: 'Email Address',
                                
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _emailAddress = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 15,left: 10),
                                  child: FaIcon(FontAwesomeIcons.lock,size: 18),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15,right: 10),
                                    child: FaIcon(_obscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,size: 18),
                                  ),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                               _password = value;
                            },
                            obscureText: _obscureText,
                            onEditingComplete:_submitForm, // 
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                            child: TextButton(onPressed: (){Navigator.pushNamed(context, ForgetPassword.routeName);},style: TextButton.styleFrom(primary:  Colors.blue.shade900,textStyle: const TextStyle(decoration: TextDecoration.underline)), child: const Text("Forget Password",)),
                          )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                         _isLoading? const Center(child:  CircularProgressIndicator()): ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: ColorsConsts.backgroundColor),
                                  ),
                                )),
                                onPressed:_submitForm,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 18,
                                    )
                                  ],
                                )),
                           const SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}