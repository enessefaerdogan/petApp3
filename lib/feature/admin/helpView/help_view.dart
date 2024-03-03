import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/admin/helpView/update_help_view.dart';
import 'package:pet_app/product/model/help.dart';
import 'package:pet_app/product/model/trip.dart';


class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  List<Help> helpList = [];

  Future<void> fetcHelp()async{
    var response = await FirebaseFirestore.instance.collection("help")
    .get();
    mapHelp(response);
  }
  
  mapHelp(QuerySnapshot<Map<String,dynamic>> datas){
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcHelp();
  }

  void deleteHelp(Help help) async{
    await FirebaseFirestore.instance.collection("help").doc(help.id).delete();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Yardım Görüntüle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: helpList.length > 0 

                    ?
                    
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: helpList.length,itemBuilder: (context, index){
                        
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
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateHelpView(sendedHelp: helpList[index])));
                                }, icon: Icon(size: 45,color: Colors.black,Icons.settings)),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.37),
                                child: Image.asset("assets/help.jpg")),
                                Positioned(
                                  bottom: 0,
                                  left: 0,child: Text(style: TextStyle(fontFamily: 'BoldPoppin'),helpList[index].helpDetailTitle)),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(onPressed: (){
                                  deleteHelp(helpList[index]);
                                  setState(() {
                                    helpList.removeAt(index);
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