import 'package:flutter/material.dart';
import 'package:pet_app/product/model/news.dart';


class NewsDetailPageView extends StatefulWidget {
  News sendedNews;
  NewsDetailPageView({super.key, required this.sendedNews});

  @override
  State<NewsDetailPageView> createState() => _NewsDetailPageViewState();
}

class _NewsDetailPageViewState extends State<NewsDetailPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

 appBar : AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back)),
      automaticallyImplyLeading: false,
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Haberin Detayları",style: TextStyle(fontFamily: 'MedPoppin')),
      centerTitle: true,),

  body: Column(
    children: [
    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
    
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
        Text(widget.sendedNews.newsDate,style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
        Text("  -  ",style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
        Text(widget.sendedNews.newsTime,style: TextStyle(color: Colors.black54,fontFamily: 'MedPoppin')),
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
          Image.network(fit: BoxFit.cover,widget.sendedNews.newsPhoto)),
      ),



      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width*0.1,
              left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
            child: Text(widget.sendedNews.newsTitle,style: TextStyle(fontFamily: 'BoldPoppin',fontSize: 20),))),
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
            child: Text(widget.sendedNews.newsParagraf1,style: TextStyle(fontFamily: 'MedPoppin'),))),
        ],
      ),

        SizedBox(height: MediaQuery.of(context).size.height*0.005,),

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

        SizedBox(height: MediaQuery.of(context).size.height*0.001,),

    ],
  ),


    );
  }
}