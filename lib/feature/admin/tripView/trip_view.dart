import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/admin/tripView/update_trip_view.dart';
import 'package:pet_app/product/model/trip.dart';


class TripView extends StatefulWidget {
  const TripView({super.key});

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcTrip();
  }

  void deleteTrip(Trip trip) async{
    await FirebaseFirestore.instance.collection("trip").doc(trip.id).delete();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Gezi Görüntüle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: tripList.length > 0 

                    ?
                    
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: tripList.length,itemBuilder: (context, index){
                        
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
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTripView(sendedTrip: tripList[index])));
                                }, icon: Icon(size: 45,color: Colors.black,Icons.settings)),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.37),
                               child: Image.network(tripList[index].tripPhoto)),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(onPressed: (){
                                  deleteTrip(tripList[index]);
                                  setState(() {
                                    tripList.removeAt(index);
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