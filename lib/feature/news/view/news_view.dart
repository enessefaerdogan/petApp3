import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/feature/newsDetailPage/view/news_detail_page_view.dart';
import 'package:pet_app/product/model/news.dart';
import 'package:pet_app/product/model/trip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {

  List<News> newsList = [];

  Future<void> fetcNews()async{
    var response = await FirebaseFirestore.instance.collection("news").orderBy('news_index',descending: true).get();
    mapNews(response);
  }
  
  mapNews(QuerySnapshot<Map<String,dynamic>> datas){
    final _datas = datas.docs.map((item) => 
    News(id: item.id,
     newsDate: item["news_date"], 
     newsIndex: item["news_index"], 
     newsOwner: item["news_owner"], 
     newsParagraf1: item["news_paragraf1"], 
     newsParagraf2: item["news_paragraf2"], 
     newsParagraf3: item["news_paragraf3"], 
     newsPhoto: item["news_photo"], 
     newsTime: item["news_time"], 
     newsTitle: item["news_title"])
    
    ).toList();

    setState(() {
          newsList = _datas;
    });
  }


  List<Trip> tripList = [];

  Future<void> fetcTrip()async{
    var response = await FirebaseFirestore.instance.collection("trip").get();
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
    fetcNews();
    fetcTrip();
  }

  int carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      
      SingleChildScrollView(
        //physics: FixedExtentScrollPhysics(),
        child:
        
        newsList.length > 0 && tripList.length > 0 ? 
        
        
         Column(
        
        
          children: [
        
            //Text("Merhaba"),

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),child: Text("Gezi Fotoğrafları",style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin',fontSize: 17),)),
                ],
              ),
            
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                
                
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlay: true,
                height: MediaQuery.of(context).size.height*0.2,
                onPageChanged: ((index, reason) {
                  
                  setState(() {
                    carouselIndex = index;
                  });
                })
              ),
              items: [
              InkWell(
                onTap: (){
                  //Navigator.push(context, 
                    //                             MaterialPageRoute(
                      //                            builder: (context) => NewsDetailPageView(sendedNews: newsList[0])));
                },
        
                // Container değil Card da yapılabilir!
                child: Container(child: Stack(children: [
                
                  
                
                  Positioned.fill(
                      child: 
                      
                      
                      Image.network(
                        tripList[0].tripPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                
                //Image.asset(",),
                /*Positioned(
                  //top: 0,
                  //top: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15), 
                    height: MediaQuery.of(context).size.height*0.1,color: Colors.black.withOpacity(0.6),),
                ),
                
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                  child: Center(child: Text(textWriter(newsList[0].newsTitle),style: 
                  TextStyle(fontFamily: 'BoldPoppin',fontSize: 15,color: Colors.white))))*/
                ]
                
                )),
              ),
        
              Container(child: Stack(children: [
        
                
        
                InkWell(
                onTap: (){
                
                },
        
                // Container değil Card da yapılabilir!
                child: Container(child: Stack(children: [
                
                  
                
                  Positioned.fill(
                      child: Image.network(
                         tripList[1].tripPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                
                //Image.asset(",),
                /*Positioned(
                  //top: 0,
                  //top: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15), 
                    height: MediaQuery.of(context).size.height*0.1,color: Colors.black.withOpacity(0.6),),
                ),
                
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                  child: Center(child: Text(textWriter(newsList[1].newsTitle),style: 
                  TextStyle(fontFamily: 'BoldPoppin',fontSize: 15,color: Colors.white))))*/
                ]
                
                )),
              ),
              ]
              
              )),
              
              InkWell(
                onTap: (){
                 
                },
        
                // Container değil Card da yapılabilir!
                child: Container(child: Stack(children: [
                
                  
                
                  Positioned.fill(
                      child: Image.network(
                         tripList[2].tripPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                
                //Image.asset(",),
                /*Positioned(
                  //top: 0,
                  //top: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15), 
                    height: MediaQuery.of(context).size.height*0.1,color: Colors.black.withOpacity(0.6),),
                ),
                
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                  child: Center(child: Text(textWriter(newsList[2].newsTitle),style: 
                  TextStyle(fontFamily: 'BoldPoppin',fontSize: 15,color: Colors.white))))*/
                ]
                
                )),
              ),
              InkWell(
                onTap: (){
                  
                },
        
                // Container değil Card da yapılabilir!
                child: Container(child: Stack(children: [
                
                  
                
                  Positioned.fill(
                    child: Image.network(
                       tripList[3].tripPhoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                
                //Image.asset(",),
                /*Positioned(
                  //top: 0,
                  //top: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15), 
                    height: MediaQuery.of(context).size.height*0.1,color: Colors.black.withOpacity(0.6),),
                ),
                
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                  child: Center(child: Text(textWriter(newsList[2].newsTitle),style: 
                  TextStyle(fontFamily: 'BoldPoppin',fontSize: 15,color: Colors.white))))*/
                ]
                
                )),
              ),
              InkWell(
                onTap: (){
                  
                },
        
                child: Stack(
                  children: [Container(child: Positioned.fill(
                      child: Image.network(
                         tripList[4].tripPhoto,
                        fit: BoxFit.cover,
                      ),
                    ))],
                ),
              ),
              InkWell(
                onTap: (){
                 
                },
        
                // Container değil Card da yapılabilir!
                child: Stack(
                  children: [Container(child: Positioned.fill(
                      child: Image.network(
                         tripList[5].tripPhoto,
                        fit: BoxFit.cover,
                      ),
                    ))],
                ),
              ),
              ],
            
            ),
        
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            AnimatedSmoothIndicator(
              
              
              
              activeIndex: carouselIndex, 
              count: 6,
              effect: WormEffect(
                
                dotHeight: 10,
                dotColor: Colors.blueGrey,
                dotWidth: 10,
                activeDotColor: Colors.red,
                paintStyle: PaintingStyle.fill,
        
              ),),
        
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),child: Text("En Yeniden Eskiye",style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin',fontSize: 17),)),
                ],
              ),
        
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsList.length,itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                                                 height: MediaQuery.of(context).size.height*0.14,
                                                 width: MediaQuery.of(context).size.width*0.95,
                                                 child: 
                                                 GestureDetector(
                                                   onTap: () async{
                                                 Navigator.push(context, 
                                                 MaterialPageRoute(
                                                  builder: (context) => NewsDetailPageView(sendedNews: newsList[index])));
                                                   },
                                                   child: Card(
                                                    
                                                    surfaceTintColor: Colors.grey,elevation: 1,color: Colors.white,
                                                   child: Row(children: [
                                                   
                                                     Container(
                                                     /*decoration: BoxDecoration(
                                                       border: Border.all(width: 1,)),*/
                                                       margin: EdgeInsets.only(//left: MediaQuery.of(context).size.width*0.04,
                                                       right: MediaQuery.of(context).size.width*0.02),
                                                       width: MediaQuery.of(context).size.width*0.4,
                                                       height: MediaQuery.of(context).size.height*0.14,child:
                                                        Image.network(fit: BoxFit.cover,newsList[index].newsPhoto)),
                    
                                                         Expanded(child: Container(//decoration: BoxDecoration(border: Border.all(width: 1)),
                                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                                                          right: MediaQuery.of(context).size.width*0.04),child: Text(newsList[index].newsTitle,style: TextStyle(fontFamily: 'MedPoppin'))))
                                                   
                                                     
                                                   ]),),
                                                 )
                                               ),
                                               SizedBox(height: MediaQuery.of(context).size.height*0.015,)
                  ],
                );
              },),
          ],
        ) 
         
         :

         Center(child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.36),
          child: CircularProgressIndicator(color: Colors.red,)))
         
         ,
      ),

    );
  }
}

String textWriter(String text){
String newText = "";

if(text.length > 20){
for(int i=0;i<20;i++){
newText = newText + text[i]; 
}

newText = newText + "...";
}
else{
newText = text;
}

return newText;
}