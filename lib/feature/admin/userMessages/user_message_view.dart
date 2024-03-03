import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/product/model/family_match.dart';
import 'package:pet_app/product/model/pet.dart';



class UserMessageView extends StatefulWidget {
  const UserMessageView({super.key});

  @override
  State<UserMessageView> createState() => _UserMessageViewState();
}

class _UserMessageViewState extends State<UserMessageView> {

   List<FamilyMatch> famiyMatchList = [];

  Future<void> fetcFamilyMatch()async{
    var response = await FirebaseFirestore.instance.collection("family_match")
    //.where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapFamilyMatch(response);
  }
  
  mapFamilyMatch(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
   FamilyMatch(
    id: item.id, 
    petId: item["pet_id"], 
    petName: item["pet_name"], 
    userEmail: item["user_email"], 
    message: item["message"])
    
    ).toList();

    setState(() {
          famiyMatchList = _datas;
    });
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

    //notifyListeners();

  }

  /*String findPetName(FamilyMatch familyMatch){
    for(int i=0;i<petList.length;i++){

      if(petList[i] == familyMatch.petId){
        return petList[i].petName;
      }
      
    }
    return "";
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcFamilyMatch();
    //fetcPet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Kullanıcı Mesajları",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: ListView.builder(
        itemCount: famiyMatchList.length,
        itemBuilder: (context,index) {

          return Card(
            elevation: 5,
            surfaceTintColor: Colors.white,
            child: Column(
              children: [

                Text("Kullanıcı : "+famiyMatchList[index].userEmail,style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),

                Text("Mesaj : "+famiyMatchList[index].message,style: TextStyle(color: Colors.black,fontFamily: 'MedPoppin'))

              ],
            ),
          );

      } ),


    );
  }
}