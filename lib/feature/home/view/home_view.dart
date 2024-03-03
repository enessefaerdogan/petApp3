import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/feature/login/signin/view/signin_view.dart';
import 'package:pet_app/feature/login/signup/view/signup_view.dart';
import 'package:pet_app/feature/news/view/news_view.dart';
import 'package:pet_app/feature/notification/view/notification_view.dart';
import 'package:pet_app/feature/petPage/view/petpage_view.dart';
import 'package:pet_app/feature/user/view/user_view.dart';
import 'package:pet_app/product/model/pet.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

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
    //print("KULLANICI İÇERDEEE"+ FirebaseAuth.instance.currentUser!.email!);
  }

  final _navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    HomeView(),
    NewsView(),
    NotificationView(),
    UserView()
  ];


  final items = <Widget>[
    Icon(Icons.home,size: 30,color: Color.fromRGBO(255, 182, 41 ,1),),
    Icon(Icons.newspaper,size: 30,color: Color.fromRGBO(255, 182, 41 ,1),),
    Icon(Icons.notifications,size: 30,color: Color.fromRGBO(255, 182, 41 ,1),),
    Icon(Icons.person,size: 30,color: Color.fromRGBO(255, 182, 41 ,1),),
    
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        
            key: _navigationKey,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Color.fromRGBO( 237, 252, 228,1),
            color: Color.fromRGBO( 237, 252, 228,1),
            height: MediaQuery.of(context).size.height*0.07,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            index: index,
            items: items,
            onTap: (index) =>
            setState(() {
              print("İNDEXİ YAZIYORUM : "+index.toString());
              this.index = index;
             
            })
            
            ), 

      appBar: 
      
      //index == 0 ? 
      
      AppBar(
        
        actions: [
          
         index == 3 ? Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
            width: MediaQuery.of(context).size.width*0.08,
            height: MediaQuery.of(context).size.height*0.04,child: InkWell(
              
              onTap: () async{
                await FirebaseAuth.instance.signOut();
                // uygulama kapatılsın
                Navigator.push(context, MaterialPageRoute(builder: (context) => SigninView()));
              }
              ,child: Image.asset("assets/out.png"))) : SizedBox.shrink()],

      automaticallyImplyLeading: false,
      // yanına siyah beyaz veya renkli pati koy
      title:  Row(
        children: [

          // burada safa bazlı appbar yazılı düzeltilecek!!!
          // widthler ona göre düzeltilerek buna ulaşılacak
          SizedBox(width: 
          
          index == 2 ? MediaQuery.of(context).size.width*0.32 : 
          index == 3 ? MediaQuery.of(context).size.width*0.34
          :MediaQuery.of(context).size.width*0.25,),

          Text(index==0 ? "Pati Dostum" : index == 1 ? "Bizden Haberler" : index == 2 ? "Bildirimler" : "Hesabım",style: TextStyle(fontFamily: 'MedPoppin')),
          SizedBox(width: MediaQuery.of(context).size.width*0.02,)
,         index==0 ?  Container(width: MediaQuery.of(context).size.width*0.1,height: MediaQuery.of(context).size.height*0.04,child: Image.asset("assets/heart.png"),)
: SizedBox.shrink()
        ],
      ),centerTitle: true,)
      ,

      //:
     //null,

      body: 


      index == 0 ?
      
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
        
           Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.03),
            width: MediaQuery.of(context).size.width*0.8,child: Text("Pati Dostum ile neler yapabilirim?",style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 25))),
        
        Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),
            width: MediaQuery.of(context).size.width*0.87,child: Text("Sadece pati dostunun günlük ihtiyaçlarını karşılayarak değil onunla birlikte zaman geçirerek de mutlu edebileceğini biliyor muydun?",style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54))),
            ListView.builder(
            
              physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: petList.length,itemBuilder: (context,index){
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Container(
                        /*decoration: BoxDecoration(
                        border: Border.all(width: 1,)),*/
                        //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                        //right: MediaQuery.of(context).size.width*0.02),
                        width: MediaQuery.of(context).size.width*0.75,
                        height: MediaQuery.of(context).size.height*0.2,
                        child:
                        ClipPath(
                          clipper: ShapeBorderClipper(shape: 
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          child: Image.network(fit: BoxFit.cover,petList[index].petPhoto))),
        
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        
                          Center(
                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.6,
                                              height: MediaQuery.of(context).size.height*0.04,
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
                                                // hayvanın sayfaya gidicek
                                                
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PetPageView(sendedPet: petList[index],)));
                            
                                              }
                                             
                                              , 
                                              child: Text(petList[index].petName,style: TextStyle(
                                                 color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,)
                ],
              );
            })
        
        ],),
      )
      
      
      :

      screens [index]
      ,

      
    );
  }
}