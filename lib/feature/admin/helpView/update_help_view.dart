import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/core/components/info_snackbar.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/login/signin/view/signin_view.dart';
import 'package:pet_app/product/model/help.dart';
import 'package:pet_app/product/model/news.dart';
import 'package:pet_app/product/model/pet.dart';


class UpdateHelpView extends StatefulWidget {
  Help sendedHelp;
  UpdateHelpView({super.key, required this.sendedHelp});

  @override
  State<UpdateHelpView> createState() => _UpdateHelpViewState();
}

class _UpdateHelpViewState extends State<UpdateHelpView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcPet();
    titleController.text = widget.sendedHelp.helpTitle;
    textController.text = widget.sendedHelp.helpText;
    detailTitleController.text = widget.sendedHelp.helpDetailTitle;
  }

  List<Pet> petList = [];

  Future<void> fetcPet()async{
    var response = await FirebaseFirestore.instance.collection("pet").get();
    mapPet(response);
  }
  
  mapPet(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
    Pet(id: item.id, petName: item["pet_name"], 
    petPhoto: item["pet_photo"], 
    petText: item["pet_text"], 
    petType: item["pet_type"])).toList();

    setState(() {
          petList = _datas;
    });

  }



  final _formKey = GlobalKey<FormState>();
  /// hayvan adı, hayvan açıklaması
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController detailTitleController = TextEditingController();
  
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


  Future<void> updateHelp()async{
    Help addHelp = Help(
      helpText: textController.text, 
      helpTitle: titleController.text, 
      id: widget.sendedHelp.id, 
      petId: widget.sendedHelp.petId, 
      userEmail: widget.sendedHelp.userEmail, 
      helpDetailTitle: detailTitleController.text);
      await FirebaseFirestore.instance.collection("help").doc(widget.sendedHelp.id).update(addHelp.toJson());
      }

  Pet choosedPet = Pet(id: "id", petName: "Hayvan Adı", petPhoto:"", petText: "petText", petType: "petType");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Yardım İsteği Düzenle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: SingleChildScrollView(
        child: 
        
        petList.length > 0 ?
        
        Column(
        
          children: [
        
        
        
            /*Stack(
        
              children: [
        
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.2,
                child: newImageFilePath.length > 0 ? 
                
                Image.file(File(newImageFilePath))
                
                :    Image.network(imageUrl),
                ),
        
                Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width*0.32,
            child: IconButton(onPressed: ()async{
        
              await chooseFile();    
                 
                        String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages = referenceRoot.child('news_photo');
        
                        Reference referenceImageToUpload = referenceDirImages.child(uniqeFileName);
                       
                        try{
                        await referenceImageToUpload
                        .putFile(File(file!.path), SettableMetadata(contentType: 'image/png'));
                        
                        imageUrl = await referenceImageToUpload.getDownloadURL();
                        
                        setState(() {
                          newImageFilePath = file!.path;
                          //widget.currentUser!.foto = file!.path;
                        });
        
                        
                        }
                        catch(error){
            
                        }
            
            }, icon: Icon(Icons.camera_alt,size: 50,color: Colors.black,)),
          )
              ],
            ),*/

            SizedBox(height: MediaQuery.of(context).size.height*0.02,),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Card(
                    child: ListView.builder(
                      itemCount: petList.length,itemBuilder: (context, index){
                      return ListTile(
                        onTap: (){
                          setState(() {
                            choosedPet = petList[index];
                          });
                        },title: Text(petList[index].petName),);
                    },),
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width*0.05,)
                ,

                Flexible(child: Text(choosedPet.petName,style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17),))
              ],
            ),
        
        
            Form(
              key: _formKey,
              child: Column(
                children: [
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        
        
        
                  Center(
                    child: Container(
                                width: MediaQuery.of(context).size.width*0.85,
                                child: TextFormField(
                                
                         
                                  //obscureText: _showPass,
                                  decoration: InputDecoration(
                          //                    hintText: 'Şifre',
                          label: Text('Yardım Başlığı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                        
                        ), controller: titleController, 
                        validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Yardım başlığı zorunludur';
                                    }
                                  },),
                        
                                 
                                 
                                ),
                  ),
        
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        
        
        
                              Container(
                              width: MediaQuery.of(context).size.width*0.85,
                              child: TextFormField(
                              
                       
                                //obscureText: _showPass,
                                decoration: InputDecoration(
                        //                    hintText: 'Şifre',
                        label: Text('Yardım İçeriği Başlığı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: textController, 
                      validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Yardım içeriği başlığı yazısı zorunludur';
                                  }
                                },),
                      
                               
                               
                              ),


                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        
        
        
                              Container(
                              width: MediaQuery.of(context).size.width*0.85,
                              child: TextFormField(
                              
                       
                                //obscureText: _showPass,
                                decoration: InputDecoration(
                        //                    hintText: 'Şifre',
                        label: Text('Yardım İçeriği Yazısı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: detailTitleController,
                       validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Yardım içeriği yazısı zorunludur';
                                  }
                                } 
                      ),
                      
                               
                               
                              ),



                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        
        
        
                           
        
        
        
        
                ],
              ),
                        ),
        
        
                        SizedBox(height: MediaQuery.of(context).size.height*0.001,),
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
             /*                 for(int i=0;i<newsList.length;i++){
      if(newsList[i].newsIndex > biggerIndex ){
        setState(() {
          biggerIndex = newsList[i].newsIndex;
        });
      }
    }*/



updateHelp();                      
Navigator.pop(context);
  ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          InfoSnackbar.infoSnackbar("Kayıt Güncellendi!", "Kayıt başarıyla güncellendi", Duration(seconds: 2)));

                              
        
                              
                            }
          
                            
                      }
                     
                      , 
                      child: Text("Güncelle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,)
            
          ],
        
        
        )

        :

        Center(child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.36),
          child: CircularProgressIndicator(color: Colors.red,)))
      ),

    );
  }
}