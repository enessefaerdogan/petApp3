import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/components/info_snackbar.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/admin/animal/update_animal_view.dart';
import 'package:pet_app/product/model/pet.dart';
import 'package:pet_app/product/model/trip.dart';


class AnimalView extends StatefulWidget {
  const AnimalView({super.key});

  @override
  State<AnimalView> createState() => _AnimalViewState();
}

class _AnimalViewState extends State<AnimalView> {
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

    //notifyListeners();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcPet();
  }

  void deletePet(Pet pet) async{
    await FirebaseFirestore.instance.collection("pet").doc(pet.id).delete();
  }
/*
  void updatePet(Pet pet){
    Pet newPet = Pet(id: pet.id, petName: pet.id, petPhoto: pet.petPhoto, petText: pet., petType: petType)
    await FirebaseFirestore.instance.collection("pet").doc(pet.id).delete();

  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Hayvan Görüntüle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: petList.length > 0 

                    ?
                    
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: petList.length,itemBuilder: (context, index){
                        
                          //globalTripid = tripList[index].id;
                        
                        return 

                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height*0.15,
                          child: Stack(
                            children: [
                              
                              
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: IconButton(onPressed: (){           
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdatePetView(sendedPet: petList[index])));
                                }, icon: Icon(size: 45,color: Colors.black,Icons.settings)),
                              ),
                              
                              Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.37),
                                child: Image.network(petList[index].petPhoto)),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(onPressed: (){
                                  deletePet(petList[index]);
                                  setState(() {
                                    petList.removeAt(index);
                                  });
                                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          SuccessSnackbar.successSnackbar("Kayıt Silindi!", "Kayıt başarıyla silindi", Duration(seconds: 2)));
                                }, icon: Icon(size: 45,color: Colors.black,Icons.delete)),
                              )
                              
                              ]),);


                    })

                    : SizedBox.shrink(),


    );  
  }
}