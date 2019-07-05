
import 'package:flutter/material.dart';
import 'package:weather/config/config.dart';
import 'package:weather/services/api.dart';
import 'package:weather/models/weather_model.dart';

class FirstScreen extends  StatefulWidget {
 final String name;
 final Wind wind;
 final Main main;
  FirstScreen({this.name, this.wind, this.main});
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
with SingleTickerProviderStateMixin {
  bool loading= false;
  bool errorloading = false;
  Forecasting forecasting = Forecasting();
  @override 
  void initState() { 
    super.initState();
    print(widget.name);
    _getData();
  }
 
  _getData() async{
    try{
    print(config['BASE_URL']+"${widget.name}"+"${"&appid=5fa6149b77b730104c3c303109c9d344"}");
    forecasting = Forecasting.fromJson(await Api.getRequest(config['BASE_URL']+"${widget.name}"+"${"&appid=5fa6149b77b730104c3c303109c9d344"}"));
    print(forecasting.weather[0].icon);
    print(forecasting.weather[0].description);
    print(forecasting.weather[0].main);
    print(forecasting.wind.speed);
    
    setState(() {
      loading= true;
    });
    }catch(e){
       print("error => ${e.toString()}");
          setState(() {
      errorloading = true;
    });
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
//appBar: AppBar(
  //      title: Text("weather report"),
    //  ),
      body:loading?
       Center(
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:  Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1,0.5,0.7,0.9],
                      colors: [
                        Colors.blue[400],
                        Colors.blue[400],
                        Colors.blue[300],
                        Colors.blue[200],
                      ],
              ),
            ),
           
           child:ListView.builder(
              
              itemCount: forecasting.weather.length ?? 0,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){
                    print("tap");
                    
                  },
                  
                   child:Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                    
                       children:<Widget>[
                        Row(children: <Widget>[
                         IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=> Navigator.pop(context,false),), 
                         //Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 2),),
                         //IconButton(icon: Icon(Icons.menu,),onPressed: (){},),
                         ],),
                         Padding(padding: EdgeInsets.all(40),),
                       Text("${widget.name.toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                       Padding(padding: EdgeInsets.all(1),),
                       Padding(padding: EdgeInsets.all(25),),
                       Icon(Icons.cloud,size:200,color: Colors.white,) ,
                       //Text(forecasting.weather[index].icon),
                       Padding(padding: EdgeInsets.all(10),),
                       
                       Text("${(forecasting.main.temp-273.5).toStringAsFixed(0)}°",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.white),),
                       Padding(padding: EdgeInsets.all(5),),
                       Text("MAX- ${(forecasting.main.tempMax-273.5).toStringAsFixed(0)}°",style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),),
                       Text("MIN- ${(forecasting.main.tempMin-273.5).toStringAsFixed(0)}°",style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),),
                       Text(forecasting.weather[index].description,style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),),
                       //Text(forecasting.weather[index].main),
                       Text("Wind Speed- ${forecasting.wind.speed}",style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),),
                      ],
                   ),
                 
                );
              },
            ),
          ),
        ),
      ):errorloading ?
      Center(
          child: Container(
            child: 
            Column(
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.all(180),
                ),
                Text("sorry,no results found....",style: TextStyle(fontSize: 30),),
                Icon(Icons.mood_bad, size: 100,color: Colors.white,),
              ],
            ),
          ),
      ): Center( child:CircularProgressIndicator(backgroundColor: Colors.white,)),
     
   );
  }
}