import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/feature/notificationDetail/view/notification_detail_view.dart';
import 'package:pet_app/product/model/family_match.dart';
import 'package:pet_app/product/model/help.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with TickerProviderStateMixin {


   List<FamilyMatch> famiyMatchList = [];
   List<String> petIds = [];

  Future<void> fetcFamilyMatch()async{
    var response = await FirebaseFirestore.instance.collection("family_match")
    .where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
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
          for(int i=0;i<famiyMatchList.length;i++){
              if(!petIds.contains(famiyMatchList[i].petId)){
                petIds.add(famiyMatchList[i].petId);
              }
          }
    });
  }


  bool isLoading  = true;


  List<Help> helpList = [];
  List<Help> realHelpList = [];

  Future<void> fetcHelp()async{
    var response = await FirebaseFirestore.instance.collection("help")
    //.where('user_email',isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .get();
    mapHelp(response);
  }
  
  mapHelp(QuerySnapshot<Map<String,dynamic>> datas){
    setState(() {
                    isLoading = false;
    });

    final _datas = datas.docs.map((item) => 
   Help(
   helpDetailTitle: item["help_detail_title"],
   helpText: item["help_text"], 
   helpTitle: item["help_title"], 
   id: item.id, 
   petId: item["pet_id"], 
   userEmail: item["user_email"])
    
    ).toList();

    setState(() {

          helpList = _datas;
          for(int i=0;i<helpList.length;i++){
              if(petIds.contains(helpList[i].petId)){
                realHelpList.add(helpList[i]);
              }
          }
 
    });
  }

late AnimationController _controller;

    
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("EMAİL:"+FirebaseAuth.instance.currentUser!.email!);
    fetcFamilyMatch();
    fetcHelp();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);

  }



  @override
  Widget build(BuildContext context) {

    setState(() {
      
    });
    return Scaffold(
//assets/help.jpg
      body:
/*
      isLoading == false && realHelpList.length == 0

?

// lottieden bildirim yok
Center(
  child: Container(
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.height*0.2,child: Lottie.asset("assets/notfound.json")),
    Text("Bildirim yok",style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54))
          
    
    
      ],
    ),
  ),
)


:
      */
      realHelpList.length > 0 && famiyMatchList.length > 0 
        ?
        
      
       Column(
        children:
        
        
         [

          ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: realHelpList.length,itemBuilder: (context, index) {
                return Column(
                  children: [
                    /*Container(
                                                 height: MediaQuery.of(context).size.height*0.14,
                                                 width: MediaQuery.of(context).size.width*0.95,
                                                 child: 
                                                 GestureDetector(
                                                   onTap: () async{
                                                 //Navigator.push(context, 
                                                 //MaterialPageRoute(
                                                 // builder: (context) => NewsDetailPageView(sendedNews: newsList[index])));
                                                   },
                                                   child: Card(
                                                    
                                                    surfaceTintColor: Colors.grey,elevation: 1,color: Colors.white,
                                                   child: Row(children: [
                                                   
                                                     Container(
                                                     /*decoration: BoxDecoration(
                                                       border: Border.all(width: 1,)),*/
                                                       margin: EdgeInsets.only(//ri: MediaQuery.of(context).size.width*0.04,
                                                       right: MediaQuery.of(context).size.width*0.05),
                                                       width: MediaQuery.of(context).size.width*0.36,
                                                       height: MediaQuery.of(context).size.height*0.14,child:
                                                       Image.asset("assets/help.jpg")),
                    
                                                         Expanded(child: Container(//decoration: BoxDecoration(border: Border.all(width: 1)),
                                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                                                          right: MediaQuery.of(context).size.width*0.04),child: Text(helpList[index].helpTitle,style: TextStyle(fontFamily: 'MedPoppin'))))
                                                   
                                                     
                                                   ]),),
                                                 )
                                               ),*/
                                               SizedBox(height: MediaQuery.of(context).size.height*0.015,),

                                               Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return
           Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withOpacity(_controller.value), // Renk ve opaklık burada ayarlanabilir
                  blurRadius: 10,
                ),
              ],
            ),
                                                 height: MediaQuery.of(context).size.height*0.14,
                                                 width: MediaQuery.of(context).size.width*0.95,
                                                 child: 
                                                 GestureDetector(
                                                   onTap: () async{
                                                 Navigator.push(context, 
                                                 MaterialPageRoute(
                                                  builder: (context) => NotificationDetailPageView(
                                                    sendedNotification: realHelpList[index])));
                                                   },
                                                   child: Card(
                                                    
                                                    surfaceTintColor: const Color.fromARGB(255, 20, 14, 14),elevation: 1,color: Colors.white,
                                                   child: Row(children: [
                                                   
                                                     Container(
                                                     /*decoration: BoxDecoration(
                                                       border: Border.all(width: 1,)),*/
                                                       margin: EdgeInsets.only(//ri: MediaQuery.of(context).size.width*0.04,
                                                       right: MediaQuery.of(context).size.width*0.01),
                                                       width: MediaQuery.of(context).size.width*0.36,
                                                       height: MediaQuery.of(context).size.height*0.14,child:
                                                       Image.asset("assets/help.jpg")),
                    
                                                         Expanded(child: Container(//decoration: BoxDecoration(border: Border.all(width: 1)),
                                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                                                          right: MediaQuery.of(context).size.width*0.04),child: Text(realHelpList[index].helpTitle,style: TextStyle(fontFamily: 'MedPoppin'))))
                                                   
                                                     
                                                   ]),),
                                                 )
                                               );




          /*Container(
                                                     /*decoration: BoxDecoration(
                                                       border: Border.all(width: 1,)),*/
                                                       margin: EdgeInsets.only(//ri: MediaQuery.of(context).size.width*0.04,
                                                       right: MediaQuery.of(context).size.width*0.05),
                                                       height: MediaQuery.of(context).size.height*0.14,
                                                 width: MediaQuery.of(context).size.width*0.95,child:
                                                       Image.asset("assets/help.jpg")
                                                       ,
                                                       decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(_controller.value), // Renk ve opaklık burada ayarlanabilir
                  blurRadius: 10,
                ),
              ],
            ),);*/
          
          
           /*Container(
            width: 500,
            height: 500,
            decoration: 
          );*/
        },
      ),
    )
                  ],
                );
              },),


        ],
      )

      :

      Center(child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
          child: CircularProgressIndicator(color: Colors.red,)))
      
    );
  }
}