import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/login/signin/view/signin_view.dart';
import 'package:pet_app/product/model/user.dart';



class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  int pageIndex = 1;
  double indicatorValue = 0.5;

  bool showPass1 = true;
  bool showPass2 = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController telController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController1 = TextEditingController();
  TextEditingController passController2 = TextEditingController();

  addUser() async{
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passController1.text);
  }

  createUserDB() async{
    Users newUser = Users(
    userPhoto: "assets/defaultUserP.jpg",
    id: "id", 
    tel: telController.text, 
    userEmail: emailController.text, 
    userName: nameController.text, 
    userPassword: passController1.text, 
    userSurname: surnameController.text);
    await FirebaseFirestore.instance.collection("user").add(newUser.toJson());
  }


  final _formKey = GlobalKey<FormState>();

  void increaseIndicatorValue(){
    setState(() {
      indicatorValue += 0.5;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(
  leading: IconButton(onPressed: (){
    if(pageIndex == 1){
      Navigator.pop(context);
    }
    else{
      setState(() {
              pageIndex = pageIndex -1 ;
              indicatorValue -= 0.5;

      });
    }
  }, icon: Icon(Icons.arrow_back))
  
  ,title: Text("$pageIndex / 2",style: TextStyle(fontFamily: 'MedPoppin',)),centerTitle: true,),
body: SingleChildScrollView(
  child: 
  
  pageIndex == 1 ?
  
  Column(
    children: [
  

  LinearProgressIndicator(
    //backgroundColor: Colors.green,
    //valueColor: Colors.amber, 
    color: Color.fromRGBO(255, 182, 41 ,1),
                value: indicatorValue,
                //semanticsLabel: 'Linear progress indicator',
              ),
  
  SizedBox(height: MediaQuery.of(context).size.height*0.05,),

  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.41),
  child: Text("İlk Adım",style: TextStyle(fontFamily: 'BoldPoppin',fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),)),
  
  Container(//decoration: BoxDecoration(border: Border.all(width: 1)),
  height: MediaQuery.of(context).size.height*0.09,width: MediaQuery.of(context).size.width*0.8,
child: Text("Biraz yolumuz var ama buna değecek!. Kendini tanıtır mısın ?. İsmin, soyismin ve telefon numaranı girmelisin.",
style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),)),

SizedBox(height: MediaQuery.of(context).size.height*0.05,),
  Form(key: _formKey,child: Column(
    children: [


Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        child: TextFormField(
                        
                 
                         //obscureText: _showPass,
                          decoration: InputDecoration(
                  //                    hintText: 'Şifre',
                  label: Text('İsim',style : TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                ),prefixIcon: Icon(Icons.person),
                ),
                
                          controller: nameController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'İsim zorunludur';
                            }
                          },
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
  
  
                      Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        child: TextFormField(
                        
                 
                         //obscureText: _showPass,
                          decoration: InputDecoration(
                  //                    hintText: 'Şifre',
                  label: Text('Soyisim',style : TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                ),prefixIcon: Icon(Icons.person),
                ),
                
                          controller: surnameController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Soyisim zorunludur';
                            }
                          },
                        ),
                      ),
  
  
  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                      Container(
                        //height: MediaQuery.of(context).size.height*0.23,
                        width: MediaQuery.of(context).size.width*0.85,
                      
                        child: TextFormField(
                        
                          maxLength: 10,
                         //obscureText: _showPass,
                          decoration: InputDecoration(
  
  
  
     isDense: true,
     prefixIcon:Text("   +90|   ",style: TextStyle(color: Colors.black54)),
     prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  
  
                  //                    hintText: 'Şifre',
                  label: Text('Tel No',style : TextStyle(fontFamily: 'MedPoppin',color: Colors.black54)),
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
                ),
                ),
                
                          controller: telController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Tel No zorunludur';
                            }
                          },
                        ),
                      ),

    ],
  )),
              
  
  
  
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
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
                      if(_formKey.currentState!.validate()){            
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                            if(pageIndex < 2){
                              setState(() {
                                pageIndex += 1;
                                increaseIndicatorValue();
                              });
                            }
                            if(pageIndex == 2){

                            }
                          }
  
                          
                    }
                   
                    , 
                    child: Text(pageIndex == 2 ? "Kaydol" : "İlerle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                  ),
    ],
  )
  
  :

  //pageIndex == 2 ?

  Column(
    children: [

LinearProgressIndicator(
    //backgroundColor: Colors.green,
    //valueColor: Colors.amber, 
    color: Color.fromRGBO(255, 182, 41 ,1),
                value: indicatorValue,
                //semanticsLabel: 'Linear progress indicator',
              ),
  
  SizedBox(height: MediaQuery.of(context).size.height*0.05,),

  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.34),
  child: Text("Az Kaldı...",style: TextStyle(fontFamily: 'BoldPoppin',fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),)),
  
  Container(height: MediaQuery.of(context).size.height*0.09,width: MediaQuery.of(context).size.width*0.8,
child: Text("Şimdi emailin ve şifreni isteyeceğim. Şifreni 2 kere girmeyi unutma!.",
style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),)),

SizedBox(height: MediaQuery.of(context).size.height*0.05,),
  Form(key: _formKey,child: Column(
    children: [


Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: TextFormField(
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
          
    
              controller: emailController,
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
          ),





                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
  
  
                      Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                      
               
                        obscureText: showPass1,
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
                
                setState(() {
                                  
                  showPass1 = !showPass1;

                });
                 
              }, icon: Icon(showPass1 ==true ? Icons.visibility_off : Icons.visibility))),
              
                        controller: passController1,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Şifre zorunludur';
                          }
                          else if(passController1.text != passController2.text){
                              return 'Şifreler aynı olmalıdır';
                          }
                          else if(passController1.text.length<6){
                            return 'Şifre en az 6 haneli olmalıdır';
                          }
                        },
                      ),
                    ),
  
  
  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                      Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                      
               
                        obscureText: showPass2,
                        decoration: InputDecoration(
                //                    hintText: 'Şifre',
                label: Text('Şifre Tekrar',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                setState(() {
                                  
                  showPass2 = !showPass2;

                });

                print("showpass yazıyorum :"+showPass2.toString());
                 
              }, icon: Icon(showPass2 ==true ? Icons.visibility_off : Icons.visibility))),
              
                        controller: passController2,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Şifre zorunludur';
                          }
                          else if(passController1.text != passController2.text){
                              return 'Şifreler aynı olmalıdır';
                          }
                          else if(passController2.text.length<6){
                            return 'Şifre en az 6 haneli olmalıdır';
                          }
                        },
                      ),
                    ),

    ],
  )),
              
  
  
  
              SizedBox(height: MediaQuery.of(context).size.height*0.12,),
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
                      if(_formKey.currentState!.validate()){            
                            //Navigatodr.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                            /*if(pageIndex < 2){
                              setState(() {
                                pageIndex += 1;
                                increaseIndicatorValue();
                              });
                            }*/
                            ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          SuccessSnackbar.successSnackbar("Uygulamaya Hoşgeldin!", "Artık pati dostlarına yardımcı olabilirsin", Duration(seconds: 2)));
                            
                            addUser();
                            createUserDB();
                           Navigator.push(context, MaterialPageRoute(builder: (context) => SigninView()));

                            
                          }
  
                          
                    }
                   
                    , 
                    child: Text(pageIndex == 2 ? "Kaydol" : "İlerle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                  ),

    ],
  )


  /*:

  Column(
    children: [

LinearProgressIndicator(
    //backgroundColor: Colors.green,
    //valueColor: Colors.amber, 
    color: Colors.redAccent,
                value: indicatorValue,
                //semanticsLabel: 'Linear progress indicator',
              ),
  
  SizedBox(height: MediaQuery.of(context).size.height*0.05,),

  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.22),
  child: Text("Son Aşama...",style: TextStyle(fontFamily: 'BoldPoppin',fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),)),
  
  Container(height: MediaQuery.of(context).size.height*0.09,width: MediaQuery.of(context).size.width*0.8,
child: Text("Telefon numarana gelen kodu girmelisin!.",
style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),)),

SizedBox(height: MediaQuery.of(context).size.height*0.05,),
      
  
  
  
              SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      onPressed: ()async {
                      if(_formKey.currentState!.validate()){            
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                            if(pageIndex < 3){
                              setState(() {
                                pageIndex += 1;
                                increaseIndicatorValue();
                              });
                            }
                          }
  
                          
                    }
                   
                    , 
                    child: Text(pageIndex == 3 ? "Kaydol" : "İlerle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17),)),
                  ),

    ],
  )*/
  
  ,
),
    );
  }
}