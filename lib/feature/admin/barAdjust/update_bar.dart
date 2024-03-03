import 'package:flutter/material.dart';
import 'package:pet_app/core/components/info_snackbar.dart';
import 'package:pet_app/product/model/pet.dart';
import 'package:pet_app/product/model/pet_bar.dart';

class UpdateBarView extends StatefulWidget {
  Pet sendedPet;
  List<PetBar> sendedBarPetList;
  UpdateBarView({super.key, required this.sendedPet ,required this.sendedBarPetList});

  @override
  State<UpdateBarView> createState() => _UpdateBarViewState();
}

class _UpdateBarViewState extends State<UpdateBarView> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController barController = TextEditingController();

  PetBar currentPetbar = PetBar(data: 3, id: "id", petId: "petId");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*for(int i=0;i<widget.sendedBarPetList.length;i++){
      if(widget.sendedBarPetList[i].petId == )
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      // yanına siyah beyaz veya renkli pati koy
      title: Text("Bar Düzenle",style: TextStyle(color: Colors.black,fontFamily: 'BoldPoppin')),centerTitle: true,),

      body: Column(children: [

        Form(
              key: _formKey,
              child: Column(
                children: [
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        
        
        
                  Center(
                    child: Container(
                                width: MediaQuery.of(context).size.width*0.85,
                                child: TextFormField(
                                
                         
                                  //obscureText: _showPass,
                                  decoration: InputDecoration(
                          //                    hintText: 'Şifre',
                          label: Text('Hayvan yem yüzdesi',style: TextStyle(fontFamily: 'MedPoppin',color: Colors.black54),),
                                    enabledBorder: OutlineInputBorder(
                          borderSide:
                      BorderSide(width: 2, color: Colors.black38), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(20.0),
                    
                          
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
                    color: Colors.black,
                    width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        
                        ), controller: barController, 
                        validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Hayvan yem barı zorunludur';
                                    }
                                  },),
                        
                                 
                                 
                                ),
                  ),
        
                ],
              ),
                        ),
        
        
                        SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                  Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      height: MediaQuery.of(context).size.height*0.05,
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
                       // if(_formKey.currentState!.validate()){            
                            
                                ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                          InfoSnackbar.infoSnackbar("Kayıt Güncellendi!", "Kayıt başarıyla güncellendi", Duration(seconds: 2)));
                            Navigator.pop(context);
                            
                         //     }
                              
                              
        
                              
                           // }
          
                            
                      }
                     
                      , 
                      child: Text("Ekle",style: TextStyle(color: Color.fromRGBO(255, 182, 41 ,1),fontFamily: 'MedPoppin',fontSize: 17),)),
                    ),

      ],),

    );
  }
}