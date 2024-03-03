import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/login/signin/view/signin_view.dart';
import 'package:pet_app/product/model/news.dart';
import 'package:pet_app/product/model/pet.dart';


class AddNewsView extends StatefulWidget {
  const AddNewsView({super.key});

  @override
  State<AddNewsView> createState() => _AddNewsViewState();
}

class _AddNewsViewState extends State<AddNewsView> {

   List<News> newsList = [];
   int biggerIndex = 0;
  // EN BÜYÜK İNDEX HESAPLANACAK
  Future<void> fetcHelp()async{
    var response = await FirebaseFirestore.instance.collection("news")
    //.where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapHelp(response);
  }
  
  mapHelp(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
   News(
    id: item.id, 
    newsDate: item["news_date"], 
    newsIndex: item["news_index"], 
    newsOwner: item["news_owner"], 
    newsParagraf1: item["news_paragraf1"], 
    newsParagraf2: item["news_paragraf2"], 
    newsParagraf3: item["news_paragraf3"], 
    newsPhoto: item["news_photo"], 
    newsTime: item["news_time"], 
    newsTitle: item["news_title"],)
    ).toList();

    setState(() {
      newsList = _datas;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcHelp();
  }

  final _formKey = GlobalKey<FormState>();
  /// hayvan adı, hayvan açıklaması
  TextEditingController paragraf1Controlller = TextEditingController();
  TextEditingController paragraf2Controlller = TextEditingController();
  TextEditingController paragraf3Controlller = TextEditingController();

  TextEditingController titleControlller = TextEditingController();
  
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


  Future<void> addNews()async{
    News addNews = News(
      id: "id", 
      newsDate: DateFormat('dd.MM.yyyy').format(DateTime.now()), 
      newsIndex: biggerIndex+1, 
      newsOwner: FirebaseAuth.instance.currentUser!.email!, 
      newsParagraf1: paragraf1Controlller.text, 
      newsParagraf2: paragraf2Controlller.text, 
      newsParagraf3: paragraf3Controlller.text, 
      newsPhoto: imageUrl, 
      newsTime: DateFormat('kk:mm').format(DateTime.now()), 
      newsTitle: titleControlller.text);
      await FirebaseFirestore.instance.collection("news").add(addNews.toJson());
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Haber Ekle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: SingleChildScrollView(
        child: Column(
        
          children: [
        
        
        
            Stack(
        
              children: [
        
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.2,
                child: imageUrl.length > 0 ? 
                
                Image.file(File(newImageFilePath))
                
                :    Center(
                  child: Text('Haber Fotoğrafı Yükleme Alanı',
                  style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
                ),
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
                          label: Text('Haber Başlığı',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                        
                        ), controller: titleControlller, 
                        validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Haber başlığı zorunludur';
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
                        label: Text('Birinci Paragraf',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: paragraf1Controlller, 
                      validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Paragraf 1 yazısı zorunludur';
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
                        label: Text('İkinci Paragraf',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: paragraf2Controlller, 
                      ),
                      
                               
                               
                              ),



                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        
        
        
                              Container(
                              width: MediaQuery.of(context).size.width*0.85,
                              child: TextFormField(
                              
                       
                                //obscureText: _showPass,
                                decoration: InputDecoration(
                        //                    hintText: 'Şifre',
                        label: Text('Üçüncü Paragraf',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
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
                      
                      ), controller: paragraf3Controlller,),
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
                              //Navigatodr.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                              /*if(pageIndex < 2){
                                setState(() {
                                  pageIndex += 1;
                                  increaseIndicatorValue();
                                });
                              }*/
                              for(int i=0;i<newsList.length;i++){
      if(newsList[i].newsIndex > biggerIndex ){
        setState(() {
          biggerIndex = newsList[i].newsIndex;
        });
      }
    }


if(newImageFilePath.length > 2){
addNews();
                              
setState(() {
  paragraf1Controlller.text = "";
  paragraf2Controlller.text = "";
  paragraf3Controlller.text = "";
  titleControlller.text = "";
  imageUrl = "";
});
Navigator.pop(context);
  ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          SuccessSnackbar.successSnackbar("Yeni Kayıt Eklendi!", "Yeni kayıt başarıyla eklendi", Duration(seconds: 2)));
}
                              
        
                              
                            }
          
                            
                      }
                     
                      , 
                      child: Text("Ekle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                    ),
            
          ],
        
        
        ),
      ),

    );
  }
}