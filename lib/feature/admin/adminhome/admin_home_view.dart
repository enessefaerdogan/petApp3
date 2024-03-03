import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/feature/admin/addHelp/add_help.dart';
import 'package:pet_app/feature/admin/addNews/add_news.dart';
import 'package:pet_app/feature/admin/addPet/add_pet.dart';
import 'package:pet_app/feature/admin/addTrip/add_trip.dart';
import 'package:pet_app/feature/admin/animal/animal_view.dart';
import 'package:pet_app/feature/admin/barAdjust/bar_view.dart';
import 'package:pet_app/feature/admin/helpView/help_view.dart';
import 'package:pet_app/feature/admin/newsDelete/news_delete_view.dart';
import 'package:pet_app/feature/admin/tripView/trip_view.dart';
import 'package:pet_app/feature/admin/userMessages/user_message_view.dart';
import 'package:pet_app/feature/login/signin/view/signin_view.dart';


class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:       
      AppBar(
        actions: [
        Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
            width: MediaQuery.of(context).size.width*0.08,
            height: MediaQuery.of(context).size.height*0.04,child: GestureDetector(
              
              onTap: () async{
                await FirebaseAuth.instance.signOut();
                // uygulama kapatılsın
                Navigator.push(context, MaterialPageRoute(builder: (context) => SigninView()));
              }
              ,child: Image.asset("assets/out.png")))
      ],
      automaticallyImplyLeading: false,
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Admin Paneli",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: Column(
        children: [

          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: MediaQuery.of(context).size.width*0.48,
              height: MediaQuery.of(context).size.height*0.15,
              child: GestureDetector(//splashFactory: NoSplash.splashFactory,
              onTap: ()async{
              
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPetView()));

              },
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(30, 30),
                      bottomRight:  Radius.elliptical(30, 30),
                      bottomLeft: Radius.elliptical(30, 30),
                      topLeft: Radius.elliptical(30, 30),
                      
                      
                    )
                  ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(width: 70,height:70,child: Image.asset('assets/hayvan.png')),
                    SizedBox(height: 5,),
                    Text("Hayvan Ekle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),
                  ],
                ),),
              ),
                      ),

                      Container(
          width: MediaQuery.of(context).size.width*0.48,
          height: MediaQuery.of(context).size.height*0.15,
          child: GestureDetector(//splashFactory: NoSplash.splashFactory,
          onTap: ()async{

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewsView()));
           
          },
            child: Card(
              surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 30),
                  bottomRight:  Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                  topLeft: Radius.elliptical(30, 30),
                  
                  
                )
              ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
              children: [
                SizedBox(height: 10,),
                Container(width: 70,height:70,child: Image.asset('assets/haber.png')),
                SizedBox(height: 5,),
                Text("Haber Ekle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),

              ],
            ),),
          ),
        ),
            ],
          ),

          


          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: MediaQuery.of(context).size.width*0.48,
              height: MediaQuery.of(context).size.height*0.15,
              child: GestureDetector(//splashFactory: NoSplash.splashFactory,
              onTap: ()async{
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddTripView()));
               
              },
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(30, 30),
                      bottomRight:  Radius.elliptical(30, 30),
                      bottomLeft: Radius.elliptical(30, 30),
                      topLeft: Radius.elliptical(30, 30),
                      
                      
                    )
                  ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(width: 70,height:70,child: Image.asset('assets/gezi.png')),
                    SizedBox(height: 5,),
                    Text("Gezi Ekle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15
                    ,color: Colors.black),),

                  ],
                ),),
              ),
                      ),

                      Container(
          width: MediaQuery.of(context).size.width*0.48,
          height: MediaQuery.of(context).size.height*0.15,
          child: GestureDetector(//splashFactory: NoSplash.splashFactory,
          onTap: ()async{

            Navigator.push(context, MaterialPageRoute(builder: (context) => AddHelpView()));
           
          },
            child: Card(
              surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 30),
                  bottomRight:  Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                  topLeft: Radius.elliptical(30, 30),
                  
                  
                )
              ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
              children: [
                SizedBox(height: 10,),
                Container(width: 70,height:70,child: Image.asset('assets/yardim.png')),
                SizedBox(height: 5,),
                Text("Yardım İsteği Ekle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),
              ],
            ),),
          ),
        ),
            ],
          ),


          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: MediaQuery.of(context).size.width*0.48,
              height: MediaQuery.of(context).size.height*0.15,
              child: GestureDetector(//splashFactory: NoSplash.splashFactory,
              onTap: ()async{
               
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalView()));
               
              },
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(30, 30),
                      bottomRight:  Radius.elliptical(30, 30),
                      bottomLeft: Radius.elliptical(30, 30),
                      topLeft: Radius.elliptical(30, 30),
                      
                      
                    )
                  ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(width: 70,height:70,child: Image.asset('assets/hayvan.png')),
                    SizedBox(height: 5,),
                    Text("Hayvan Görüntüle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),
                  ],
                ),),
              ),
                      ),

                      Container(
          width: MediaQuery.of(context).size.width*0.48,
          height: MediaQuery.of(context).size.height*0.15,
          child: GestureDetector(//splashFactory: NoSplash.splashFactory,
          onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDeleteView()));
           
          },
            child: Card(
              surfaceTintColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 30),
                  bottomRight:  Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                  topLeft: Radius.elliptical(30, 30),
                  
                  
                )
              ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
              children: [
                SizedBox(height: 10,),
                Container(width: 70,height:70,child: Image.asset('assets/haber.png')),
                SizedBox(height: 5,),
                Text("Haber Görüntüle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),

              ],
            ),),
          ),
        ),
            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: MediaQuery.of(context).size.width*0.48,
              height: MediaQuery.of(context).size.height*0.15,
              child: GestureDetector(//splashFactory: NoSplash.splashFactory,
              onTap: ()async{
               
              Navigator.push(context, MaterialPageRoute(builder: (context) => TripView()));
               
              },
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(30, 30),
                      bottomRight:  Radius.elliptical(30, 30),
                      bottomLeft: Radius.elliptical(30, 30),
                      topLeft: Radius.elliptical(30, 30),
                      
                      
                    )
                  ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(width: 70,height:70,child: Image.asset('assets/gezi.png')),
                    SizedBox(height: 5,),
                    Text("Gezi Görüntüle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),
                  ],
                ),),
              ),
                      ),

                      Container(
          width: MediaQuery.of(context).size.width*0.48,
          height: MediaQuery.of(context).size.height*0.15,
          child: GestureDetector(//splashFactory: NoSplash.splashFactory,
          onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpView()));
           
          },
            child: Card(
              surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 30),
                  bottomRight:  Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                  topLeft: Radius.elliptical(30, 30),
                  
                  
                )
              ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
              children: [
                SizedBox(height: 10,),
                Container(width: 70,height:70,child: Image.asset('assets/yardim.png')),
                SizedBox(height: 5,),
                Text("Yardım Görüntüle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),

              ],
            ),),
          ),
        ),
            ],
          ),





          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: MediaQuery.of(context).size.width*0.48,
              height: MediaQuery.of(context).size.height*0.15,
              child: GestureDetector(//splashFactory: NoSplash.splashFactory,
              onTap: ()async{
               
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserMessageView()));
               
              },
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 237, 252, 228),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(30, 30),
                      bottomRight:  Radius.elliptical(30, 30),
                      bottomLeft: Radius.elliptical(30, 30),
                      topLeft: Radius.elliptical(30, 30),
                      
                      
                    )
                  ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(width: 70,height:70,child: Image.asset('assets/usermessage.png')),
                    SizedBox(height: 5,),
                    Text("Kullanıcı Mesajları",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),
                  ],
                ),),
              ),
                      ),

                      Container(
          width: MediaQuery.of(context).size.width*0.48,
          height: MediaQuery.of(context).size.height*0.15,
          child: GestureDetector(//splashFactory: NoSplash.splashFactory,
          onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context) => AdjustBarView()));
           
          },
            child: Card(
              surfaceTintColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 30),
                  bottomRight:  Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                  topLeft: Radius.elliptical(30, 30),
                  
                  
                )
              ),elevation: 15,color: Color.fromARGB(255, 237, 252, 228),child: Column(
              children: [
                SizedBox(height: 10,),
                Container(width: 70,height:70,child: Image.asset('assets/barchart.png')),
                SizedBox(height: 5,),
                Text("Bar Düzenle",style: TextStyle(fontFamily: 'MedPoppin',fontSize: 15,color: Colors.black),),

              ],
            ),),
          ),
        ),
            ],
          ),

        
        ],
      ),

    );
  }
}