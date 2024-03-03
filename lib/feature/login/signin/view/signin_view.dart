import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/core/components/failure_snackbar.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/admin/adminhome/admin_home_view.dart';
import 'package:pet_app/feature/home/view/home_view.dart';
import 'package:pet_app/feature/login/signup/view/signup_view.dart';


class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _sifreController = TextEditingController();

  bool _showPass = true;

  void changeShowPass(){
  setState(() {
        _showPass = !_showPass;
  });

   // notifyListeners();
  }
  
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
backgroundColor: Colors.white,
      body: SingleChildScrollView(
      //  physics: NeverScrollableScrollPhysics(),
        child: 
        
        Column(
          children: [
        
            Center(
              child: Container(
                //decoration: BoxDecoration(border: Border.all(width: 1)),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                width: MediaQuery.of(context).size.width*0.55,
                height: MediaQuery.of(context).size.height*0.27,child: Image.asset("assets/login_pet_photo.png")),
            ),

            Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
          width: MediaQuery.of(context).size.width*0.8,
          child: Center(child: Text("Pati Dostum",style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 25)))),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),

          Text("Birlikte daha mutluyuz",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17,color: Colors.black54),),
/*
isError == true ? 
Column(
  children: [
    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
    Text("E-mail ve/veya Şire Hatalıdır",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17,color: Colors.black54),),
  
  ],
)
      :
        SizedBox.shrink(),*/

              Form(key: _formKey,child: Column(
        
                children: [
                  /*Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.65),
                      child: Text("E-mail",style: TextStyle(fontFamily: 'Open Sans',fontSize: 17,fontWeight: FontWeight.bold),)),*/
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,//right: MediaQuery.of(context).size.width*0.65
                  ),
                  child: EmailTFF(emailController: _emailController)),
        
        
                  
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                /*Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.69,),
                      child: Text("Şifre",style: TextStyle(fontFamily: 'Open Sans',fontSize: 17,fontWeight: FontWeight.bold),)),*/
                  
        
                  SifreTFF(context)
        
                ],                
        
              ) ),
SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO( 237, 252, 228,1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    onPressed: ()async {
                    if(_formKey.currentState!.validate()) {            
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));

                        var response = await FirebaseFirestore.instance.collection("user")
                        .where('user_email',isEqualTo: _emailController.text)
                        .where('user_password',isEqualTo: _sifreController.text).limit(1).get();
                        
                        if(response.docs.isNotEmpty && (_emailController.text == "admin1@gmail.com" || _emailController.text == "admin2@gmail.com")){
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text, 
    password: _sifreController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeView()));
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          SuccessSnackbar.successSnackbar("Giriş Başarılı!", "Admin Girişi Yapıldı", Duration(seconds: 1)));
                        }
                        else if(response.docs.isNotEmpty){
                           await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text, 
    password: _sifreController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                        }
                        else{
                          setState(() {
                            isError = true;
                          });
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          FailureSnackbar.failureSnackbar("Giriş Yapılamadı!", "E-mail ve şifre uyumsuz", Duration(seconds: 2)));
                        }
                        }

                        //else{} hata verdir
                  }
                 
                  , 
                  child: Text("Giriş",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                ),

              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabın yok mu?",style: TextStyle(fontFamily: 'MedPoppin',),),
                    TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupView()));
                    }, child: Text('Kayıt Ol',style: TextStyle(fontFamily: 'MedPoppin',color: Color.fromRGBO(255, 182, 41 ,1)),))
                  ],
                ),
              ),

              /*Divider(endIndent: MediaQuery.of(context).size.width*0.05,indent: MediaQuery.of(context).size.width*0.05,),

              
                  // insta adresine git
                  GestureDetector(
                    onTap: (){
                      // instaya gidiş


                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/instagram.png")),
                  )*/
                
              
        
        
        
          ],
        ),
      ),
    );  
  }

  Container SifreTFF(BuildContext context) {
    return Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                  
               autofocus: true,
                        obscureText: _showPass,
                        decoration: InputDecoration(
                //                    hintText: 'Şifre',
                label: Text('Şifre',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
                          enabledBorder: OutlineInputBorder(
                borderSide:
            BorderSide(width: 2, color: Colors.black38), //<-- SEE HERE
                borderRadius: BorderRadius.circular(20.0),
          
                
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(
          color: Colors.black,
          width: 2,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
          color: Colors.redAccent,
          width: 2,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),prefixIcon: Icon(Icons.password_rounded),
              suffixIcon: IconButton(onPressed: (){
                
                changeShowPass();
                 
              }, icon: Icon(_showPass ==true ? Icons.visibility_off : Icons.visibility))),
              
                        controller: _sifreController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Şifre zorunludur';
                          }
                        },
                      ),
                    );
  }
}

























class EmailTFF extends StatelessWidget {
  const EmailTFF({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                //hintText: 'E-mail',
                label: Text('E-mail',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
                enabledBorder: OutlineInputBorder(
      borderSide:
                  BorderSide(width: 2, color: Colors.black38), //<-- SEE HERE
      borderRadius: BorderRadius.circular(20.0),
                
      
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:  BorderSide(
                color: Colors.black,
                width: 2,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
                color: Colors.redAccent,
                width: 2,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),prefixIcon: Icon(Icons.mail_outline)),
          
    
              controller: _emailController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'E-mail zorunludur';
                }
                String pattern = r'\w+@\w+\.\w+';
                RegExp regex = RegExp(pattern);
                if(!regex.hasMatch(value)){
                  return 'Geçersiz E-mail formatı';
                }
                
              },
            ),
          );
  }
}