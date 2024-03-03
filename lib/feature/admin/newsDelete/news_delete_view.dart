import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/components/success_snackbar.dart';
import 'package:pet_app/feature/admin/newsDelete/update_news_view.dart';
import 'package:pet_app/product/model/news.dart';
import 'package:pet_app/product/model/trip.dart';


class NewsDeleteView extends StatefulWidget {
  const NewsDeleteView({super.key});

  @override
  State<NewsDeleteView> createState() => _NewsDeleteViewState();
}

class _NewsDeleteViewState extends State<NewsDeleteView> {

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcNews();
  }

  void deleteNews(News news) async{
    await FirebaseFirestore.instance.collection("news").doc(news.id).delete();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
      title: Text("Haber Görüntüle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: newsList.length > 0 

                    ?
                    
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: newsList.length,itemBuilder: (context, index){
                        
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
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateNewsView(sendedNews: newsList[index])));
                                }, icon: Icon(size: 45,color: Colors.black,Icons.settings)),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.37),
                                child: Image.network(newsList[index].newsPhoto)),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(onPressed: (){
                                  deleteNews(newsList[index]);
                                  setState(() {
                                    newsList.removeAt(index);
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