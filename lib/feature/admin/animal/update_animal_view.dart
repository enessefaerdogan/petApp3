import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/components/info_snackbar.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/product/model/pet.dart';


class UpdatePetView extends StatefulWidget {
  Pet sendedPet;
  UpdatePetView({super.key, required this.sendedPet});

  @override
  State<UpdatePetView> createState() => _UpdatePetViewState();
}

class _UpdatePetViewState extends State<UpdatePetView> {

  final _formKey = GlobalKey<FormState>();
  /// hayvan adı, hayvan açıklaması
  TextEditingController adControlller = TextEditingController();
  TextEditingController textControlller = TextEditingController();

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


  Future<void> updatePet()async{
    Pet newUser = Pet(id: widget.sendedPet.id, 
    petName: adControlller.text, 
    petPhoto: imageUrl, 
    petText: textControlller.text, 
    petType: "köpek");
    await FirebaseFirestore.instance.collection("pet").doc(widget.sendedPet.id).update(newUser.toJson());
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adControlller.text = widget.sendedPet.petName;
    textControlller.text = widget.sendedPet.petText;
    imageUrl = widget.sendedPet.petPhoto;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Hayvan Düzenle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: SingleChildScrollView(
        child: Column(
        
          children: [
        
        
        
            Stack(
        
              children: [
        
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.2,
                child: newImageFilePath.length > 0 ? 
                
                Image.file(File(newImageFilePath))
                
                :   Image.network(imageUrl),
                ),
        
                Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width*0.32,
            child: IconButton(onPressed: ()async{
        
              await chooseFile();    
                 
                        String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages = referenceRoot.child('pet_photo');
        
                        Reference referenceImageToUpload = referenceDirImages.child(uniqeFileName);
                       
                        try{
                        await referenceImageToUpload
                        .putFile(File(file!.path), SettableMetadata(contentType: 'image/png'));
                        
                        imageUrl = await referenceImageToUpload.getDownloadURL();
                        
                        setState(() {
                          newImageFilePath = file!.path;
                          //widget.currentUser!.foto = file!.path;
                        });
        
                        // HAYVAN EKLENECEĞİ ZAMAN ÇAĞRILACAK
                        
                        }
                        catch(error){
            
                        }
            
            }, icon: Icon(Icons.camera_alt,size: 50,color: Colors.black,)),
          )
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
                          label: Text('Hayvan Adı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                        
                        ), controller: adControlller, 
                        validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Hayvan adı zorunludur';
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
                        label: Text('Hayvan Yazısı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: textControlller, 
                      validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Hayvan yazısı zorunludur';
                                  }
                                },),
                      
                               
                               
                              ),
        
        
        
        
                ],
              ),
                        ),
        
        
                        SizedBox(height: MediaQuery.of(context).size.height*0.06,),
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
                              
                              if(imageUrl.length> 2){
                              updatePet();
                              //Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          InfoSnackbar.infoSnackbar("Kayıt Güncellendi!", "Kayıt başarıyla güncellendi", Duration(seconds: 2)));
                            Navigator.pop(context);
                            
                              }
                              
                              
        
                              
                            }
          
                            
                      }
                     
                      , 
                      child: Text("Güncelle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                    ),
            
          ],
        
        
        ),
      ),

    );
  }
}