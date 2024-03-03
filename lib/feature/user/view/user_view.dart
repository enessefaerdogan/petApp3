import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/feature/news/view/news_view.dart';
import 'package:pet_app/product/model/user.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:url_launcher/url_launcher.dart';


class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

 List<Users> currentUser = [];

  Future<void> fetcCurrentUser()async{
    var response = await FirebaseFirestore.instance.collection("user")
    .where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapCurrentUser(response);
  }
  
  mapCurrentUser(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
    Users(
      id: item.id, 
      tel: item["tel"], 
      userEmail: item["user_email"], 
      userName: item["user_name"], 
      userPassword: item["user_password"], 
      userPhoto: item["user_photo"], 
      userSurname: item["user_surname"])
    
    ).toList();

    setState(() {
          currentUser = _datas;
    });

    //notifyListeners();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcCurrentUser();
  }
  bool isEyeClicked = true;

   ImagePicker _imagePicker = ImagePicker();
   XFile? file;
   String newImageFilePath = "";
   String imageUrl = '';

  Future chooseFile() async{
  
    file = await _imagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      newImageFilePath = file!.path;
    });
  } 


  Future<void> updateUser()async{
    Users newUser = Users(
      id: currentUser[0].id, 
      tel: currentUser[0].tel,
      userEmail: currentUser[0].userEmail, 
      userName: currentUser[0].userName, 
      userPassword: currentUser[0].userPassword, 
      userPhoto: imageUrl, 
      userSurname: currentUser[0].userSurname);
    await FirebaseFirestore.instance.collection("user").doc(currentUser[0].id).update(newUser.toJson());
    
    
    //await context.read<SigninViewProvider>().newcurrentUserr(newUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: 

currentUser.length > 0 ? 
Column(
  children: [
    Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.02),
      child: Stack(
        children: [
          
          
newImageFilePath.length >0 ? 

ProfilePhoto(
        totalWidth: MediaQuery.of(context).size.width*0.4,
        cornerRadius: 100,
        color: Colors.white,
        outlineColor: Colors.redAccent,
        outlineWidth: 4,
        textPadding: 10,
        //name: 'Brad Varnum',
        fontColor: Colors.white,
        //nameDisplayOption: NameDisplayOptions.initials,
        fontWeight: FontWeight.w100,
        //showName: true,
        image: FileImage(File(newImageFilePath)),//Image.file(File(file!.path),fit: BoxFit.cover,), // nul yerine NetworkImage yerleştircez
        badgeAlignment: Alignment.bottomLeft,
        badgeSize: 60,
        //badgeImage: const AssetImage('assets\dog1.jpg'),
        onTap: () {
            // open profile for example
        },
        onLongPress: () {
            // popup to message user for example
        },
        ):




          ProfilePhoto(
        totalWidth: MediaQuery.of(context).size.width*0.4,
        cornerRadius: 100,
        color: Colors.white,
        outlineColor: Colors.redAccent,
        outlineWidth: 4,
        textPadding: 10,
        //name: 'Brad Varnum',
        fontColor: Colors.white,
        //nameDisplayOption: NameDisplayOptions.initials,
        fontWeight: FontWeight.w100,
        //showName: true,
        image: currentUser[0].userPhoto == 'assets/defaultUserP.jpg'  ?  NetworkImage('https://firebasestorage.googleapis.com/v0/b/pet-app-phalanx-1.appspot.com/o/user_photo%2FdefaultUserP.jpg?alt=media&token=f81463ba-9e28-4469-aab0-004d5fcc3229') 
        : newImageFilePath.length > 0 ?  NetworkImage(newImageFilePath) : NetworkImage(currentUser[0].userPhoto) , // nul yerine NetworkImage yerleştircez
        badgeAlignment: Alignment.bottomLeft,
        badgeSize: 60,
        //badgeImage: const AssetImage('assets\dog1.jpg'),
        onTap: () {
            // open profile for example
        },
        onLongPress: () {
            // popup to message user for example
        },
        ),
      
        Positioned(
          bottom: 0,
          right: 5,
          child: IconButton(onPressed: ()async{

            await chooseFile();    
               
                      String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages = referenceRoot.child('user_photo');

                      Reference referenceImageToUpload = referenceDirImages.child(uniqeFileName);
                     
                      try{
                      await referenceImageToUpload
                      .putFile(File(file!.path), SettableMetadata(contentType: 'image/png'));
                      
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      
                      setState(() {
                        newImageFilePath = file!.path;
                        //widget.currentUser!.foto = file!.path;
                      });
          
                      updateUser();
                      }
                      catch(error){
          
                      }
          
          }, icon: Icon(Icons.camera_alt,size: 40,color: Colors.black,)),
        )
      
        ]
      ),
    ),

SizedBox(height: MediaQuery.of(context).size.height*0.03,),
Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.53)
,child: Text("Kullanıcı Bilgileri",style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),)),
    Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: Card(
          elevation: 10,
          surfaceTintColor: Color.fromARGB(255, 248, 200, 200),
                    color: Colors.white,
                    child: Column(
                      children: [
        
        
                    
        
                       
                        
        
                         Container(
                          width: MediaQuery.of(context).size.width*0.85,
                           child: ListTile(
                                               leading: Container(width: MediaQuery.of(context).size.width*0.1,
                                               height: MediaQuery.of(context).size.height*0.05,child: Icon(Icons.mail,color: Colors.black,)),
                                               title: Text(currentUser[0].userEmail,style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54,fontSize: 15),//Text(_currentUser.email),
                                               ),
                         )),
                        Divider(endIndent: 15,indent: 15,),

                        Container(
                          width: MediaQuery.of(context).size.width*0.85,
                           child: ListTile(trailing: IconButton(onPressed: (){

                            setState(() {
                              isEyeClicked = !isEyeClicked;
                            });

                           }, icon: Icon(isEyeClicked == true ?  Icons.visibility_off : Icons.visibility )),
                                               leading: Container(width: MediaQuery.of(context).size.width*0.1,
                                               height: MediaQuery.of(context).size.height*0.05,child: Image.asset("assets/pass.png")),
                                               title: Text(isEyeClicked == true ? writer(currentUser[0].userPassword) 
                                               : currentUser[0].userPassword
                                               ,style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54,fontSize: 15),//Text(_currentUser.email),
                                               ),
                         ),),
                        Divider(endIndent: 15,indent: 15,),

                        Container(
                          width: MediaQuery.of(context).size.width*0.85,
                           child: ListTile(
                                               leading: Container(width: MediaQuery.of(context).size.width*0.1,
                                               height: MediaQuery.of(context).size.height*0.05,child: Icon(Icons.person,color: Colors.black,)),
                                               title: Text(currentUser[0].userName + " " + currentUser[0].userSurname,style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54,fontSize: 15),//Text(_currentUser.email),
                                               ),
                         )),
                        Divider(endIndent: 15,indent: 15,),

                        Container(
                          width: MediaQuery.of(context).size.width*0.85,
                           child: ListTile(
                                               leading: Container(width: MediaQuery.of(context).size.width*0.1,
                                               height: MediaQuery.of(context).size.height*0.05,child: Icon(Icons.phone,color: Colors.black,)),
                                               title: Text(currentUser[0].tel,style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54,fontSize: 15),//Text(_currentUser.email),
                                               ),
                         )),

                      
        
        
                       
                        
                      ],
                    ),
                  ),
      ),
    ),

    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.59)
,child: Text("Sosyal Medya",style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),)),

   Center(
      child: Container(
        height: MediaQuery.of(context).size.height*0.1,
        width: MediaQuery.of(context).size.width*0.9,
        child: Card(
          elevation: 10,
          surfaceTintColor: Color.fromARGB(255, 248, 200, 200),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                         GestureDetector(
                    onTap: (){
                      // instaya gidiş
                  launchMe("https://www.youtube.com/");

                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/youtube.png")),
                  ),
                   GestureDetector(
                    onTap: (){
                      // instaya gidiş

launchMe("https://twitter.com/");

                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/twitter.png")),
                  ),
                   GestureDetector(
                    onTap: (){
                      // instaya gidiş

launchMe("https://www.linkedin.com/");
                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/linkedin.png")),
                  ),
        
   GestureDetector(
                    onTap: (){
                      // instaya gidiş

launchMe("https://www.facebook.com/");
                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/facebook.png")),
                  ),


                  GestureDetector(
                    onTap: (){
                      // instaya gidiş

launchMe("https://www.instagram.com/yedikulebarinak_official/");
                    },
                    child: Container(height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.1,child: Image.asset("assets/instagram.png")),
                  )
                    
                        
                      ],
                    ),
                  ),
      ),
    ),



  ],
)

:

Center(child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
          child: CircularProgressIndicator(color: Colors.red,)))




    );
  }

  String writer(String text){
   String newText = "";

   for(int i=0;i<text.length;i++){
    newText = newText + "*";
   }

   return newText;
  }

  launchMe(String url) async{
  //var url = 'https://wa.me/905061059958'; // admin no
  await launchUrl(Uri.parse(url));
  }
}