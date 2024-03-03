import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/product/model/help.dart';
import 'package:pet_app/product/model/news.dart';
import 'package:pet_app/product/model/pet.dart';


class NotificationDetailPageView extends StatefulWidget {
  Help sendedNotification;
  NotificationDetailPageView({super.key, required this.sendedNotification});

  @override
  State<NotificationDetailPageView> createState() => _NotificationDetailPageViewState();
}

class _NotificationDetailPageViewState extends State<NotificationDetailPageView> {


  List<Pet> currentPet = [];

  Future<void> fetcCurrentPet()async{
    var response = await FirebaseFirestore.instance.collection("pet")
    .where('id',isEqualTo: widget.sendedNotification.petId)//FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapCurrentPet(response);

  }
  
  mapCurrentPet(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
   Pet(
   id: item.id, 
   petName: item["pet_name"], 
   petPhoto: item["pet_photo"], 
   petText: item["pet_text"], 
   petType: item["pet_type"])
    
    ).toList();

    setState(() {
          currentPet = _datas;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("GELEN PET İDDD :")
    fetcCurrentPet();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

 appBar : AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back)),
      automaticallyImplyLeading: false,
      // yanına siyah beyaz veya renkli pati koy
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width*0.01,),
          Text("Yardıma İhtiyacım Var",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 20)),
         
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
            width: MediaQuery.of(context).size.width*0.1,
            height: MediaQuery.of(context).size.height*0.05,
            child: Image.asset("assets/cry.png"),
          )
        ],
      ),
      centerTitle: true,),

  body:
  
  currentPet.length >0 ? 
   Column(
    children: [
    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
    
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
      //  Text(widget.sendedNews.newsDate,style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
      //  Text("  -  ",style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
      //  Text(widget.sendedNews.newsTime,style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
      ],
    ),

    SizedBox(height: MediaQuery.of(context).size.height*0.01,),

      Center(
        child: Container(
        /*decoration: BoxDecoration(
          border: Border.all(width: 1,)),*/
          margin: EdgeInsets.only(//left: MediaQuery.of(context).size.width*0.04,
          right: MediaQuery.of(context).size.width*0.02),
          height: MediaQuery.of(context).size.height*0.25,
          width: MediaQuery.of(context).size.width*0.85,child:
          Image.network(fit: BoxFit.cover,currentPet[0].petPhoto)),
      ),



      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width*0.1,
              left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
            child: Text(widget.sendedNotification.helpDetailTitle+"(${currentPet[0].petName})",style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 20),))),
        ],
      ),
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
        //SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width*0.1,
              left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
            child: Text(widget.sendedNotification.helpText,style: TextStyle(fontFamily: 'MedPoppin'),))),
        ],
      ),

       
       /* SizedBox(height: MediaQuery.of(context).size.height*0.005,),

        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width*0.1,
              left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
            child: Text(widget.sendedNews.newsParagraf2,style: TextStyle(fontFamily: 'MedPoppin'),))),
        ],
      ),

        SizedBox(height: MediaQuery.of(context).size.height*0.001,),

        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width*0.1,
              left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
            child: Text(widget.sendedNews.newsParagraf3,style: TextStyle(fontFamily: 'MedPoppin'),))),
        ],
      ),

        SizedBox(height: MediaQuery.of(context).size.height*0.001,),*/

    ],
  )

  :

   Center(child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
          child: CircularProgressIndicator(color: Colors.red,)))


    );
  }
}