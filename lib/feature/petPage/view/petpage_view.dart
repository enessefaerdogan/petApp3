import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/product/model/family_match.dart';
import 'package:pet_app/product/model/pet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';


class PetPageView extends StatefulWidget {
  Pet sendedPet;
  PetPageView({super.key, required this.sendedPet});

  @override
  State<PetPageView> createState() => _PetPageViewState();
}

class _PetPageViewState extends State<PetPageView> {

  List<FamilyMatch> familyMatchList = [];
   int biggerIndex = 0;
  // EN BÜYÜK İNDEX HESAPLANACAK
  Future<void> fetchFamilyMatchList()async{
    var response = await FirebaseFirestore.instance.collection("family_match")
    .where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapFamilyMatchList(response);
  }
  
  mapFamilyMatchList(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
   FamilyMatch(id: item.id, 
   petId: item["pet_id"], 
   petName: item["pet_name"], 
   userEmail: item["user_email"], 
   message: item["message"])
    ).toList();

    setState(() {
      familyMatchList = _datas;
    });
  }

  bool detectMethod(){
    for(int i=0;i<familyMatchList.length;i++){
      if((familyMatchList[i].petId == widget.sendedPet.id) 
      && (familyMatchList[i].userEmail == FirebaseAuth.instance.currentUser!.email!)){
        return true;
      }
    }
    return false;
  }

  


TextEditingController messageController = TextEditingController();


void sendFamilyMatch() async{
  var newMatch = FamilyMatch(id: "", 
  petId: widget.sendedPet.id, 
  petName: widget.sendedPet.petName,
  message: messageController.text,
  userEmail: FirebaseAuth.instance.currentUser!.email!);

  await FirebaseFirestore.instance.collection("family_match").add(newMatch.toJson());
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFamilyMatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(centerTitle: true,title: 
      
      
      Text(widget.sendedPet.petName,style: TextStyle(fontFamily: 'MedPoppin'),)),
      


      body: SingleChildScrollView(
        child: Column(
        
          children: [
        
        
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Center(
                    child: Container(
                        /*decoration: BoxDecoration(
                          border: Border.all(width: 1,)),*/
                          //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                          //right: MediaQuery.of(context).size.width*0.02),
                          width: MediaQuery.of(context).size.width*0.85,
                          height: MediaQuery.of(context).size.height*0.25,
                          child:
                          ClipPath(
                            clipper: ShapeBorderClipper(shape: 
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            child: Image.network(fit: BoxFit.cover,widget.sendedPet.petPhoto))),
                  ),
        
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.085),child: Text(widget.sendedPet.petName,style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 20),)),
              ],
            ) ,            
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.085,
                right: MediaQuery.of(context).size.width*0.085),
              child: Row(
                children: [
                  Flexible(child: Text(widget.sendedPet.petText,style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),))
                ],
              ),
            ),
         /*Expanded(child: Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.03),
          child: Align(alignment: Alignment.centerLeft,
          child: Text(widget.sendedPet.petText,style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)))),*/
        /*
        DÜZELTİLECEK


        Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: 0.9,
                center: Text("90.0%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),*/
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.45),child: Text("İhtiyaç Listesi",style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 20),)) ,
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09,
            ),
            child: Text("- Mama",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09),
            child: Text("- Battaniye",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09),
            child: Text("- Tasma",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09),
            child: Text("- İlaç Desteği",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09),
            child: Text("- Klinik Desteği",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09),
            child: Text("- Gönüllü Yardımseverlik",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15),)),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        
        Center(
                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              height: MediaQuery.of(context).size.height*0.06,
                                              child: 
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.brown,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                                                  )
                                                ),
                                                onPressed: ()async {
                                                // hayvanın sayfaya gidice

                                                if(!detectMethod()){
showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

    title: Text("Yardım",style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 20),),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
      
      //Divider(),
      TextFormField(controller: messageController,decoration: InputDecoration(hintText: "Mesajınız..."),),
      //TextFormField(controller: numController,decoration: InputDecoration(hintText: "Numara"),),
      
    ],),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("Kapat",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),),
 
      TextButton(onPressed: (){
        
        Navigator.pop(context);

        // mesaj database'e atılır
        sendFamilyMatch();
        ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          SuccessSnackbar.successSnackbar("Artık Pati Dostusun!", "${widget.sendedPet.petName} koruman altında", Duration(seconds: 2)));
      }, child: Text("Gönder",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),),

    ],
      );
    },);
                                                }
                                                       
                                                       
                            
                                              }
                                             
                                              , 
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  
                                                  Text(detectMethod() == true ? "Pati dostu olundu" : "Pati dostu ol",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17),),
                                                ],
                                              )),
                                            ),
                          ),
        
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        
        
        Center(
                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              height: MediaQuery.of(context).size.height*0.06,
                                              child: 
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                                                  )
                                                ),
                                                onPressed: ()async {
                                                // hayvanın sayfaya gidicek
        
                                                //String number = "05525809434";
        
                                         /*       
         await launchUrl(
           "https://wa.me/${number}?text=Hello",
        child: Text('Open Whatsapp')),*/
        
        //String url = "whatsapp://send?+905525809434";
        //var url = 'https://wa.me/905525809434';   benim no
        var url = 'https://wa.me/905061059958'; // admin no
         await launchUrl(Uri.parse(url));
        
        
                                                
                            
                                              }
                                             
                                              , 
                                              child: Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,
                                                  height: MediaQuery.of(context).size.height*0.025,child: Image.asset("assets/whatsapp.png",color: Colors.white,),),
                                                  Text("   Yardım talebi için iletişim",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 17),),
                                                ],
                                              )),
                                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*0.04,)
        
        
          ],
        ),
      ),
      
      
    );
  }
}