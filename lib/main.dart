import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:covid_19/localestate.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() {
  runApp(MaterialApp(
    title: 'Covid-19 Static Cases',
    home: HomePage(),debugShowCheckedModeBanner: false,//to remove debuug icon   from up screen
  ));
}
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         Duration(seconds: 3),
//             () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => HomePage())));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset('images/sound.png'),
//       ),
//     );
//   }
// }
class HomePage extends StatefulWidget {

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        body: SingleChildScrollView(
          child: Container(
            child:
            Container(

              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 150.0),
                    width: double.infinity,
                    height:250.0,
                    color: Colors.redAccent,
                    child: Text ('COVID-19 STATIC CASES', textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0,),) ,

                  ),

                  Container(
                    width: double.infinity,
                    height:120.0,
                    child:    RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GlobalState()),
                        );
                      },
                      child:  Text('Global stats', style: TextStyle(fontSize: 20.0,color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    //same space tag
                    height:20.0,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height:130.0,
                    child:    RaisedButton(
                      color: Colors.white,
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => selectcountry()),
                        );
                      },
                      child:  Text('Local stats', style: TextStyle(fontSize: 20.0,color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    //same space tag
                    height:20.0,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height:100.0,
                    child:    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      color: Colors.white,
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyWebView()),
                        );
                      },
                      child:  Text('For More Information', style: TextStyle(fontSize: 20.0,color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    //same space tag
                    height:20.0,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height:100.0,
                    child:    RaisedButton(
                      color: Colors.white,
                      onPressed:_installapp,
                      child:  Text('Install Aman App', style: TextStyle(fontSize: 20.0,color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ),

          ),
        )
    );

  }}


class GlobalState extends StatefulWidget {
  @override
  _GlobalStateState createState() => _GlobalStateState();
}

class _GlobalStateState extends State<GlobalState> {
  var  now = new DateTime.now();
  var  year = new DateTime.now().year;
  var day =new DateTime.now().day;
  var  hour =new DateTime.now().hour;
  var minute =new DateTime.now().minute;
  String month = DateFormat('MMM').format(new DateTime.now());
  Timer timer;
 bool isloading=true;
 final  String url = 'https://corona.lmao.ninja/v2/all';
  Map<String, dynamic> information ;


void _getdate() {
  setState(() {
    now = new DateTime.now();
    year = new DateTime.now().year;
    day = new DateTime.now().day;
    hour = new DateTime.now().hour;
    minute = new DateTime.now().minute;
    month = DateFormat('MMM').format(new DateTime.now());
    if (hour == 0)
      hour = 12;
    else if (hour > 12)
      hour -= 12;
  }
  );
}

  Future<String>  fetchdata()  async {
    var  response =await http.get(
        Uri.encodeFull(url),
        headers:  {"Accept":"application/json"}

    );
    setState(() {
      information  = jsonDecode(response.body);
    });
    return "Success";
  }
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _getdate());
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => fetchdata());


  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return information == null ? Center(child: CircularProgressIndicator()) :  Scaffold(

        body: SingleChildScrollView(
          child: Container(
            child:
            Container(
//
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 100.0,left: 30.0),
                    width: double.infinity,
                    color: Colors.redAccent,
                    child: Text ('$month $day,$year,$hour:$minute GMt',style: TextStyle(color: Colors.white,fontSize: 20.0,),) ,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0,left: 30.0),
                    width: double.infinity,
                    color: Colors.redAccent,
                    child: Text ('Corona Virus Cases',style: TextStyle(color: Colors.white,fontSize: 20.0,),) ,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0,left: 30.0),
                    width: double.infinity,
                    color: Colors.redAccent,
                    height: 80.0,
                    child: Text ('${information['cases']}',style: TextStyle(color: Colors.white,fontSize: 20.0,),) ,
                  ),
                  Row(

                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),

                        margin: EdgeInsets.only(top : 20.0 ,left: 20.0,right: 15.0),
                        padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                        width:170.0,
                        height: 130.0,
                        child: Column(

                          children: <Widget>[
                          Text ('Death',style: TextStyle(color: Colors.red ,fontSize: 20.0,),)
                          , SizedBox (
                              height:20.0

                          ),Text ('${information['deaths']}',textAlign:TextAlign.start , style: TextStyle(color: Colors.lightGreen,fontSize: 20.0,),)


                        ],) ,
                      ),
                      SizedBox(
                        //same space tag

                        width: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: EdgeInsets.only(top : 20.0 ,right: 15.0),
                        padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                        width:170.0,
                        height: 130.0,

                        child: Column(children: <Widget>[
                          Text ('Recovered',style: TextStyle(color: Colors.red,fontSize: 20.0,),
                          )
                          , SizedBox (
                              height:20.0

                          ),
                          Text ('${information['recovered']}',textAlign:TextAlign.start ,  style: TextStyle(color: Colors.red,fontSize: 20.0,),
                          )
                          ,
                        ],) ,
                      ),
                    ],
                  ),
                  SizedBox(
                    //same space tag
                    height:10.0,
                    width: double.infinity,
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 5.0 , right: 5.0),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                      border: Border.all(
                        color: Colors.black
                      ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(

                      children: <Widget>[
                        Container(

                          padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                          width:220.0,
                          height: 130.0,
                          child: Column(children: <Widget>[
                            Text ('ACTIVE CASES',style: TextStyle(color : Color(0xff696969) ,fontWeight: FontWeight.bold,fontSize: 20.0,),)
                            , SizedBox (
                                height:20.0

                            ),Text ('${information['active']}',textAlign:TextAlign.start , style: TextStyle(color:Colors.black,fontSize: 25.0,),)


                          ],) ,
                        ),

                        Container(
                          margin: EdgeInsets.only(top:30.0),

                          padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                          width:170.0,
                          height: 130.0,

                          child: Column(children: <Widget>[
                            Text ('${information['critical']}',style: TextStyle(color: Colors.black,fontSize: 25.0,),
                            )
                            , SizedBox (
                                height:20.0

                            ),
                            Text ('Critical',textAlign:TextAlign.start ,  style: TextStyle(color:  Hexcolor("#AFB8BE"),fontSize: 20.0,),
                            )
                            ,
                          ],) ,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    //same space tag
                    height:10.0,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 5.0 , right: 5.0),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(

                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                          width:220.0,
                          height: 130.0,
                          child: Column(children: <Widget>[
                            Text ('NEW  CASES',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0,),)
                            , SizedBox (
                                height:20.0

                            ),Text ('${information['todayCases']}',textAlign:TextAlign.start , style: TextStyle(color:Colors.black,fontSize: 25.0,),)


                          ],) ,
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
                          width:170.0,
                          height: 130.0,

                          child: Column(children: <Widget>[
                            Text ('${information['todayDeaths']}',style: TextStyle(color: Colors.black,fontSize: 20.0,),
                            )
                            ,
                            Text ('Deaths',textAlign:TextAlign.start ,  style: TextStyle(color:  Hexcolor("#AFB8BE"),fontSize: 20.0,),
                            )
                            ,
                            SizedBox (
                                height:5.0

                            ),
                            Text ('${information['todayRecovered']}',style: TextStyle(color: Colors.black,fontSize: 20.0,),
                            )
                            ,
                            Text ('Recovered',textAlign:TextAlign.start ,  style: TextStyle(color:  Hexcolor("#AFB8BE"),fontSize: 20.0,),
                            )
                            ,
                          ],) ,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    //same space tag
                    height:10.0,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 5.0 , right: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                    width:double.infinity,
                    height: 130.0,

                    child: Column(children: <Widget>[
                      Text ('Affected Countries',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0),
                      )
                      , SizedBox (
                          height:20.0

                      ),
                      Text ('${information['affectedCountries']}',textAlign:TextAlign.start ,  style: TextStyle(color: Colors.lightGreen,fontSize: 25.0),
                      )
                      ,
                    ],) ,
                  ),

                 ]   )))));

  }


}


_installapp() async {
  const url = "https://play.google.com/store/apps/details?id=jo.gov.moh.aman&hl=ar";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class selectcountry extends StatefulWidget {
  @override
  _selectcountryState createState() => _selectcountryState();
}

class _selectcountryState extends State<selectcountry> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  double _confidence = 1.0;
  String _textafterspeech="";
 bool state=false ;
  @override
  void initState() {
    super.initState();
    _speech=stt.SpeechToText();




  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _textafterspeech = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;

            }
          }),
        );
      }
    } else {
      setState(() {
        _isListening  = false ;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountryState(_textafterspeech)),
        );
      });
      _speech.stop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Colors.red,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                child:
                Container(
                  width: double.infinity,
        decoration: new BoxDecoration(
                    image: new DecorationImage(image: new AssetImage("images/selectacountry.png"), fit: BoxFit.cover,),
                  ),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 150.0),


                               child: Text('Say a country name' ,textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold , color: Colors.black),)
                        )
              ,  SizedBox (height: 40.0,) ,
              Image.asset('images/sound.png')
   , Container(
                          margin: EdgeInsets.only(left: 100.0 , top : 350.0),
     child: Row(
                            children: <Widget>[
                              Text('Say a country name' , style: TextStyle(fontSize: 10.0 , fontWeight: FontWeight.bold , color: Colors.black),)
     ,
                              Switch(
                                value: state,
                                onChanged: (value){
                                  setState(() {
                                    if (state == false) {
                                      state = true;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => countrylist()),

                                      );
                                    }

                                    else  {
                                      state =false;
                                    }
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),


                            ],


                          ),

   ) , SizedBox(height: 150.0,)

             ] )   )









                    ))



            );

  }

}


class countrylist extends StatefulWidget {
  @override
  _countrylist createState() =>_countrylist();
}
class _countrylist extends State<countrylist> {
  String Body;
  List<Countries> countries=[];
  List<Countries> copycountries=[];
  TextEditingController editingController = TextEditingController();
  getdata(){
    setState(() {

      http.get("https://corona.lmao.ninja/v2/Countries").then((value) {
        setState(() {
          countries=countriesFromJson(value.body);
          copycountries=countries;
        });

      });
    });
  }
  void filterSearchResults(String query) {

    List<Countries> dummySearchList = List<Countries>();
    dummySearchList.addAll(countries);
    if(query.isNotEmpty) {
      List<Countries> dummyListData = List<Countries>();
      dummySearchList.forEach((item) {
        if(item.country.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        countries.clear();
        countries.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        countries.clear();
        countries.addAll(copycountries);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffE5E5E5),

        body:
    Container(
    child: Column(
    children: <Widget>[
    Container(
      margin:EdgeInsets.only(top: 100 ,left: 20,right: 20) ,
    padding:  EdgeInsets.all(8.0),
    child: TextField(
    onChanged: (value) {
      filterSearchResults(value);
    },
    controller: editingController,
    decoration: InputDecoration(
    labelText: "Search",
    hintText: "Search For Your Country",
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    ),
    ),
    Expanded(
    child: countries.length == 0 ?  Center(child: CircularProgressIndicator())    : ListView.builder(
       // scrollDirection: Axis.horizontal, make scroll horizintal
    shrinkWrap: true,
    itemCount: countries.length,
      itemBuilder: (context,index)=>
          Countryitem(countries[index]),) ,
    ),  ] ),



    ) ,) , debugShowCheckedModeBanner: false, )  ;

  }

}
class Countryitem extends StatelessWidget {
  final Countries countries;
  const Countryitem( this.countries  , {Key key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Card(
      elevation: 10,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(5),
        child: SingleChildScrollView(
            scrollDirection : Axis.horizontal ,
          child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          width: 120.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(countries.countryInfo.flag),
                                  fit: BoxFit.cover),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.0,),
                    GestureDetector(

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CountryState(countries.country)),
                        );


                      },
                      child: Container(
                        color: Colors.white,
                          padding: EdgeInsets.only(top: 10 , left:  10 ,right:  20) ,
                          child:  Text('${countries.country}',style: TextStyle(color: Colors.black
                            ,



                            ),),

                          ),
                    ),
                  ],
                ),
        ),

        ),
      );

  }
}
class CountryState extends StatefulWidget {
final String countryy;
  const CountryState( this.countryy  , {Key key} ) : super(key: key);

  @override
  _CountryState createState() =>_CountryState(countryy);
}
class _CountryState extends State<CountryState> {
  var  now = new DateTime.now();
  var  year = new DateTime.now().year;
  var day =new DateTime.now().day;
  var  hour =new DateTime.now().hour;
  var minute =new DateTime.now().minute;
  String month = DateFormat('MMM').format(new DateTime.now());
  Timer timer;
  final  String url = 'https://corona.lmao.ninja/v2/Countries';
  String Body;
  List<Countries> countries=[];
  Countries countriess ;
  TextEditingController editingController = TextEditingController();
  final String  countryy;
  _CountryState( this.countryy);


  void _getdate() {
    setState(() {
      now = new DateTime.now();
      year = new DateTime.now().year;
      day = new DateTime.now().day;
      hour = new DateTime.now().hour;
      minute = new DateTime.now().minute;
      month = DateFormat('MMM').format(new DateTime.now());
      if (hour == 0)
        hour = 12;
      else if (hour > 12)
        hour -= 12;
    }
    );
  }

 fetchdata()  async {
    setState(() {

      http.get("https://corona.lmao.ninja/v2/Countries").then((value) {
        setState(() {
          countries = countriesFromJson(value.body);
          for (int i = 0; i < countries.length; i ++) {
                if(countries[i].country.toLowerCase().contains(countryy.toLowerCase())){
                  countriess = new Countries();
                  countriess=countries[i];
                  break ;
                }
          }
        }
          );

      });
    });
  }
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _getdate());
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => fetchdata());


  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return countriess==null? Center(child: CircularProgressIndicator()) :  Scaffold(

        body:  SingleChildScrollView(
            child: Container(
                child:
                Container(
//
                    child: new Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 100.0,left: 30.0),
                            width: double.infinity,
                            color: Colors.redAccent,
                            child: Text ('$month $day,$year,$hour:$minute GMt',style: TextStyle(color: Colors.white,fontSize: 15.0,),) ,
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 10.0,left: 30.0 ,right: 10.0),
                            width: double.infinity,
                            color: Colors.redAccent,
                            child: SingleChildScrollView(
                                  scrollDirection : Axis.horizontal ,
                              child: Row (
                                children: <Widget>[
                                  Text ('Total Cases in ${countriess.country}',style: TextStyle(color: Colors.white,fontSize: 15.0,),) ,
                                  SizedBox(width: 60.0,),

                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: 75.0,
                                    height: 75.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        border: Border.all(color: Colors.white) ,
                                      color:  Colors.white ,
                                    ) ,
                                    child: Image.network('${countriess.countryInfo.flag}' ,width: 75.0,height: 75.0,)
                                  ),

                                ],
                              ),
                            )
                          ),


                          Container(
                            padding: EdgeInsets.only(top: 10.0,left: 30.0),
                            width: double.infinity,
                            color: Colors.redAccent,
                            height: 80.0,
                            child: Text ('${countriess.cases}',style: TextStyle(color: Colors.white,fontSize: 15.0,),) ,
                          ),

                          Row(

                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),

                                margin: EdgeInsets.only(top : 20.0 ,left: 20.0,right: 15.0),
                                padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                width:170.0,
                                height: 130.0,
                                child: Column(

                                  children: <Widget>[
                                    Text ('Death',style: TextStyle(color: Colors.red ,fontSize: 20.0,),)
                                    , SizedBox (
                                        height:20.0

                                    ),Text ('${countriess.deaths}',textAlign:TextAlign.start , style: TextStyle(color: Colors.lightGreen,fontSize: 20.0,),)


                                  ],) ,
                              ),
                              SizedBox(
                                //same space tag

                                width: 10.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                margin: EdgeInsets.only(top : 20.0 ,right: 15.0),
                                padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                width:170.0,
                                height: 130.0,

                                child: Column(children: <Widget>[
                                  Text ('Recovered',style: TextStyle(color: Colors.red,fontSize: 20.0,),
                                  )
                                  , SizedBox (
                                      height:20.0

                                  ),
                                  Text ('${countriess.recovered}',textAlign:TextAlign.start ,  style: TextStyle(color: Colors.red,fontSize: 20.0,),
                                  )
                                  ,
                                ],) ,
                              ),
                            ],
                          ),
                          SizedBox(
                            //same space tag
                            height:10.0,
                            width: double.infinity,
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 5.0 , right: 5.0),
                            decoration:  BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Row(

                              children: <Widget>[
                                Container(

                                  padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                  width:220.0,
                                  height: 130.0,
                                  child: Column(children: <Widget>[
                                    Text ('ACTIVE CASES',style: TextStyle(color : Color(0xff696969) ,fontWeight: FontWeight.bold,fontSize: 20.0,),)
                                    , SizedBox (
                                        height:20.0

                                    ),Text ('${countriess.active}',textAlign:TextAlign.start , style: TextStyle(color:Colors.black,fontSize: 25.0,),)


                                  ],) ,
                                ),

                                Container(
                                  margin: EdgeInsets.only(top:30.0),

                                  padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                  width:170.0,
                                  height: 130.0,

                                  child: Column(children: <Widget>[
                                    Text ('${countriess.critical}',style: TextStyle(color: Colors.black,fontSize: 25.0,),
                                    )
                                    , SizedBox (
                                        height:20.0

                                    ),
                                    Text ('Critical',textAlign:TextAlign.start ,  style: TextStyle(color:  Hexcolor("#AFB8BE"),fontSize: 20.0,),
                                    )
                                    ,
                                  ],) ,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            //same space tag
                            height:10.0,
                            width: double.infinity,
                          ),
                          Container(
                            margin: EdgeInsets.only( left: 5.0 , right: 5.0),
                            decoration:  BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Row(

                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                                  width:220.0,
                                  height: 130.0,
                                  child: Column(children: <Widget>[
                                    Text ('TODAY DEATH',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0,),)
                                    , SizedBox (
                                        height:20.0

                                    ),Text ('${countriess.todayDeaths}',textAlign:TextAlign.start , style: TextStyle(color:Colors.black,fontSize: 25.0,),)


                                  ],) ,
                                ),

                                Container(
                                  padding: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                                  width:170.0,
                                  height: 130.0,

                                  child: Column(children: <Widget>[
                                    Text ('NEW  CASES',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0,),)
                                    , SizedBox (
                                        height:20.0

                                    ),
                                    Text ('${countriess.todayCases}',textAlign:TextAlign.start , style: TextStyle(color:Colors.black,fontSize: 25.0,),)
                                  ],) ,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            //same space tag
                            height:10.0,
                            width: double.infinity,
                          ),
                          Container(
                            margin: EdgeInsets.only( left: 5.0 , right: 5.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                            width:double.infinity,
                            height: 130.0,

                            child: Column(children: <Widget>[
                              Text ('TODAY RECOVERED',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0),
                              )
                              , SizedBox (
                                  height:20.0

                              ),
                              Text ('${countriess.todayRecovered}',textAlign:TextAlign.start ,  style: TextStyle(color: Colors.black,fontSize: 25.0),
                              )
                              ,
                            ],) ,
                          ),
                          Container(
                            margin: EdgeInsets.only( top : 10.0 , left: 5.0 , right: 5.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                            width:double.infinity,
                            height: 130.0,

                            child: Column(children: <Widget>[
                              Text ('Tests',style: TextStyle(color: Hexcolor("#696969") ,fontWeight: FontWeight.bold,fontSize: 20.0),
                              )
                              , SizedBox (
                                  height:20.0

                              ),
                              Text ('${countriess.tests}',textAlign:TextAlign.start ,  style: TextStyle(color: Colors.black,fontSize: 25.0),
                              )
                              ,
                            ],) ,
                          ),

                        ]   )))));

  }


}

class MyWebView extends StatelessWidget {

   Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('world health organization'),
        ),
        body: WebView(
          initialUrl: 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}