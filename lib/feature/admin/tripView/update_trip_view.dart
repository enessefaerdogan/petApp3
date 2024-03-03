import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/components/info_snackbar.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/product/model/pet.dart';
import 'package:pet_app/product/model/trip.dart';

String globalTripid = "";
class UpdateTripView extends StatefulWidget {
  Trip sendedTrip;
  UpdateTripView({super.key, required this.sendedTrip});

  @override
  State<UpdateTripView> createState() => _UpdateTripViewState();
}

class _UpdateTripViewState extends State<UpdateTripView> {

  List<Trip> tripList = [];
  Future<void> fetcTrip()async{
    var response = await FirebaseFirestore.instance.collection("trip")
    //.where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapTrip(response);
  }
  
  mapTrip(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
   Trip(id: item.id, tripPhoto: item["trip_photo"])
    ).toList();

    setState(() {
      tripList = _datas;
    });
  }

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

  



    updateTrip()async{
    Trip newUser = Trip(id: widget.sendedTrip.id, tripPhoto: imageUrl);
    await FirebaseFirestore.instance.collection("trip").doc(widget.sendedTrip.id).update(newUser.toJson());
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcTrip();
    imageUrl = widget.sendedTrip.tripPhoto;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Gezi Düzenle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
        
        
        
            Stack(
        
              children: [
        
                Center(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 1)),width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: newImageFilePath.length > 0 ? 
                  
                  Image.file(File(newImageFilePath))
                  
                  :    Image.network(imageUrl),
                  ),
                ),
        
                Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width*0.41,
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
                                           
                              
                              updateTrip();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          InfoSnackbar.infoSnackbar("Kayıt Güncellendi!", "Kayıt başarıyla güncellendi", Duration(seconds: 2)));
                             
                              
                                   
                      }
                     
                      , 
                      child: Text("Güncelle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                    
          ],
        
        
        ),
      ),

    );
  }
}
