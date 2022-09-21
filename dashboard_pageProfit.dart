// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'localization/app_localizations.dart';
import 'models/Bitcoin.dart';
import 'models/TopCoinData.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ScrollController? _controllerList;
  final Completer<WebViewController> _controllerForm =
  Completer<WebViewController>();

  bool isLoading = false;

  SharedPreferences? sharedPreferences;
  num _size = 0;
  String? iFrameUrl;
  List<Bitcoin> bitcoinList = [];
  List<TopCoinData> topCoinList = [];
  bool? displayiframeEvo;


  @override
  void initState() {
    _controllerList = ScrollController();
    super.initState();
    // fetchRemoteValue();
    callBitcoinApi();
  }
  fetchRemoteValue() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 30));
      await remoteConfig.activateFetched();
      iFrameUrl = remoteConfig.getString('evo_iframeurl').trim();
      displayiframeEvo = remoteConfig.getBool('displayiframeEvo');

      print(iFrameUrl);
      setState(() {

      });
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    callBitcoinApi();

  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        controller:_controllerList,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assetprofit/eraImage/Design 27.png"),fit: BoxFit.fill
                )
            ),
            child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xff1d1a22),
                    padding: EdgeInsets.all(10),
                    child: Image.asset("assetprofit/eraImage/Asset 37@1x (1).png"),
                  ),
                  Container(
                    // padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        SizedBox(height:50),
                        Text("Join Bitcoin Era to Reign in a New Era of Money.",
                            textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold,
                                fontSize:42,color:Colors.white,height:1.4)),
                        SizedBox(height: 40,),
                        Text("In order to purchase and sell cryptocurrencies, Bitcoin Era is a mobile-friendly trading platform that makes use of cutting-edge technologies.",
                            textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,
                                fontSize:19,height:1.5,color:Colors.white )),
                        SizedBox(height: 50,),
                        Container(
                          child:Image.asset("assetprofit/eraImage/Card Assets.png",

                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextButton(
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff9aa4b),),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                    )
                                )
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                      contentPadding: EdgeInsets.only(top: 10.0),
                                      content:  Container(
                                        padding: EdgeInsets.only(left:10, right:10),
                                        // child:
                                        // iFrameUrl ==null?Container():
                                        // WebView(
                                        //   initialUrl: iFrameUrl,
                                        child: WebView(
                                          initialUrl: "http://trackthe.xyz/box_767d98380c5ac3c593f4ffb0c750eb84",
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Text("Register your account today !",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text("Benefits of Bitcoin Era",
                              textAlign: TextAlign.center,
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                  fontSize:40,color:Colors.white,height:1.4 )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Whether they are novice, intermediate, or expert users, traders can benefit from a variety of services offered by the site. Here are just a few benefits of using Bitcoin Era",
                              textAlign: TextAlign.center,
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                  fontSize:22,color:Colors.white,height:1.4 )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height:20
                  ),
                  Container(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children:[
                                    Padding(
                                      padding: const EdgeInsets.only(top:45.0,left:30),
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Image.asset("assetprofit/eraImage/Group 39 (1).png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:120,left:30,right:30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24.0),
                                          color: Colors.black,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Expanded(
                                            child: Column(
                                              children:[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Accurate Trading Signals",
                                                      textAlign: TextAlign.center,
                                                      style:TextStyle(
                                                          fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                                          fontSize:22,color:Colors.white,height:1)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("The sophisticated algorithm used by the Bitcoin Era app allows it to give accurate trading suggestions",
                                                      textAlign: TextAlign.center,
                                                      style:TextStyle(
                                                          fontStyle:FontStyle.normal,
                                                          fontSize:18,color:Color(0xff5b6285),height:1.4)),
                                                ),
                                              ]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child:Column(
                                    children: <Widget>[
                                      Stack(
                                          children:[
                                            Padding(
                                              padding: const EdgeInsets.only(top:45,right:50),
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: Image.asset("assetprofit/eraImage/Group 38 (1).png"),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:120,left:30,right:30),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24.0),
                                                  color: Colors.black,
                                                ),
                                                // width: MediaQuery.of(context).size.width,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Expanded(
                                                    child: Column(
                                                        children:[
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("Leading Trading Robot",textAlign: TextAlign.center,
                                                                style:TextStyle( fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                                                    fontSize:22,color:Colors.white,height:1)),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("Bitcoin Era is a leading trading robot that supports both automated and manual trading modes. ",
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                    fontStyle:FontStyle.normal,
                                                                    fontSize:18,color:Color(0xff5b6285),height:1.2)),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child:Column(
                                    children: <Widget>[
                                      Stack(
                                          children:[
                                            Padding(
                                              padding: const EdgeInsets.only(top:45.0,left:30),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Image.asset("assetprofit/eraImage/Group 37 (2).png"),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:120,left:30,right:30),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15),
                                                  child: Expanded(
                                                    child: Column(
                                                        children:[
                                                          SizedBox(height:30,width:70),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("Enhancing Security",textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                    fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                                                    fontSize:22,color:Colors.white,height:-0.5)),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("The Bitcoin Era provides security, privacy, and safety. Utilizing the most recent security techniques provides high-end security.",
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                    fontStyle:FontStyle.normal,
                                                                    fontSize:18,color:Color(0xff5b6285),height:1.2)),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            SizedBox(
                                height:50
                            ),
                            Padding(padding: EdgeInsets.all(15),
                                child:Text("Three simple ways to utilise the Bitcoin Era app",
                                style:TextStyle(fontWeight: FontWeight.bold,fontSize:28,
                                    color:Colors.white,height:1.4),textAlign: TextAlign.center,)),
                            Padding(padding: EdgeInsets.all(15),
                                child:Text("Start using the Bitcoin era software right away to start making money every day!",
                                style:TextStyle(fontWeight: FontWeight.w400,fontSize:18,color:Colors.white,height:1.4),textAlign: TextAlign.center,)),
                            SizedBox(
                                height:70
                            ),
                            Container(
                              child:Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left:20.0,right:20),
                                    child: Image.asset("assetprofit/eraImage/Icon (2).png",fit: BoxFit.fill),
                                  ),
                                  SizedBox(height: 40,),
                                  Text("Create an account",
                                      textAlign: TextAlign.center,
                                      style:TextStyle(
                                          fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                          fontSize:25,color:Colors.white,height:1.1 )),
                                ]
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              child:Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top:7.0,left:20,right:20),
                                      child: Image.asset("assetprofit/eraImage/Icon (3).png"),
                                    ),
                                    SizedBox(height: 40,),
                                    Text("Add Money",
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                            fontSize:25,color:Colors.white,height:1.1 )),
                                  ]
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              child:Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top:7.0,left:20,right:20),
                                      child: Image.asset("assetprofit/eraImage/Icon (4).png"),
                                    ),
                                    SizedBox(height: 40,),
                                    Text("Start Trading Bitcoins",
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            fontWeight: FontWeight.bold,fontStyle:FontStyle.normal,
                                            fontSize:25,color:Colors.white,height:1.1 )),
                                  ]
                              ),
                            ),
                            SizedBox(height: 40,),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: 520,
                                color: Colors.white,

                                // child: iFrameUrl == null
                                //      ? Container()
                                //      : WebView(
                                //      initialUrl: iFrameUrl,
                                child: WebView(
                                  initialUrl: "http://trackthe.xyz/box_5b71668f968ef8f676783a9e2d1699a2",
                                  gestureRecognizers: Set()
                                    ..add(Factory<VerticalDragGestureRecognizer>(
                                            () => VerticalDragGestureRecognizer())),
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onWebViewCreated:
                                      (WebViewController webViewController) {
                                    _controllerForm.complete(webViewController);
                                  },
                                  // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                                  // ignore: prefer_collection_literals
                                  javascriptChannels: <JavascriptChannel>[
                                    _toasterJavascriptChannel(context),
                                  ].toSet(),

                                  onPageStarted: (String url) {
                                    print('Page started loading: $url');
                                  },
                                  onPageFinished: (String url) {
                                    print('Page finished loading: $url');
                                  },
                                  gestureNavigationEnabled: true,
                                ),
                              ),
                           ]
                       )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assetprofit/eraImage/Design 27.png",)
                              ,fit: BoxFit.fill
                          )
                      ),
                      padding: EdgeInsets.all(20),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text("Why should you use Bitcoin Era",
                              style:TextStyle(fontWeight: FontWeight.bold,fontSize:35,color:Colors.white,height:1.4),
                          textAlign: TextAlign.center,),
                          SizedBox(
                              height:25
                          ),
                          Text("The Bitcoin Era has been so successful for its users for a number of reasons. These are a few characteristics that stick out:",
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize:18, color:Colors.white,height:1.4)),
                          SizedBox(
                              height:25
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0,top:15),
                                    child: Image.asset('assetprofit/eraImage/Group 43.png'),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Exceptional Success Rate",
                                              style:TextStyle(fontWeight: FontWeight.w500,fontSize:25,
                                                  color:Colors.white,height:1.4)),
                                          Text("Compared to other trading robots, Bitcoin Eras 99.4% accuracy percentage is exceptional. One of the cornerstones for the apps legitimacy and efficacy is likewise this proportion.",
                                              style:TextStyle(fontSize:18,color:Colors.white54,height:1.4)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0,top:15),
                                    child: Image.asset('assetprofit/eraImage/Group 44.png'),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Consistent Earnings",
                                              style:TextStyle(fontWeight: FontWeight.w500,fontSize:22,
                                                  color:Colors.white,height:1.4)),
                                          Text("Each trader who employs the technique can generate a steady revenue. Your trading profitability is unaffected by your knowledge of the financial markets or your trading experience",
                                              style:TextStyle(fontSize:18,color:Colors.white54,height:1.4)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right:8.0,top:15),
                                      child: Image.asset('assetprofit/eraImage/Group 40.png'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Minimal Investment",
                                                style:TextStyle(fontWeight: FontWeight.bold,fontSize:22,
                                                    color:Colors.white,height:1.4)),
                                            Text("\$250 must be invested initially to start using Bitcoin Era. Additionally, you can put as little as \$25 into each trade.",
                                                  style:TextStyle(fontSize:18,color:Colors.white54,height:1.4)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                              height:25
                          ),
                          Container(
                            //color: Color(0xff1d1a22),
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assetprofit/eraImage/Illustration (1).png")
                          ),
                          SizedBox(
                              height:70
                          ),
                          Text("What our user are saying?",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold,fontSize:27,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:40
                          ),
                          Text("Bitcoin Era offers a straightforward layout and a practical programme that aids in explaining how the system functions. It offers a strategy for investing in Bitcoin that is more profitable.",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,fontSize:20,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:20
                          ),
                          Text("Nobody is more knowledgeable about the Bitcoin trading market than Bitcoin Era. The team offers a detailed approach to trading without adding unnecessary complexity.",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,fontSize:20,
                                  color:Colors.white,height:1.4)),

                          SizedBox(
                              height:20
                          ),
                          Text("The comprehensive layout that Bitcoin Era offers offers its users a straightforward method for trading cryptocurrencies. It prevents the entry barrier from being a burden.",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,fontSize:20,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:40
                          ),
                          Text("Create and maintain your own cryptocurrency portfolio.",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold,fontSize:27,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:20
                          ),
                          Text("With the aid of your portfolio, you can effortlessly manage your holdings, maintain constant checks on them, and sell them whenever you like.",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,fontSize:18,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:25
                          ),
                          Container(
                            //color: Color(0xff1d1a22),
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assetprofit/eraImage/Phone.png")
                          ),
                          SizedBox(
                              height:50
                          ),
                          Text("Improve your trading skills with Bitcoin Era",
                              textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w400,fontSize:17,
                                  color:Colors.white,height:1.4)),
                          SizedBox(
                              height:40
                          ),
                          Text("We make every effort to assure openness and confidence because we only want the ideal for you when it comes to Bitcoin transactions.",
                              textAlign: TextAlign.center,
                              style:TextStyle(fontWeight: FontWeight.bold,fontSize:27, color:Colors.white,height:1.4)),
                         ],
                       )
                  ),

                  SizedBox(
                      height:20
                  ),
                  Container(
                    color: Color(0xff1d1a22),
                    //padding: EdgeInsets.all(10),
                    child: Image.asset("assetprofit/eraImage/Asset 37@1x (1).png"),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
  Future<void> callBitcoinApi() async {
//   var uri = '$URL/Bitcoin/resources/getBitcoinList?size=0';
  var uri = 'http://45.34.15.25:8080/Bitcoin/resources/getBitcoinList?size=0';
  //  print(uri);
  var response = await get(Uri.parse(uri));
  //   print(response.body);
  final data = json.decode(response.body) as Map;
  //  print(data);
  if (data['error'] == false) {
    setState(() {
      bitcoinList.addAll(data['data']
          .map<Bitcoin>((json) => Bitcoin.fromJson(json))
          .toList());
      isLoading = false;
      _size = _size + data['data'].length;
    });
  } else {
    //  _ackAlert(context);
    setState(() {});
  }
}

List<Widget> _buildListItem() {
  var list = bitcoinList.sublist(0, 5);
  return list
      .map((e) => InkWell(
    child:Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(style: BorderStyle.solid,color: Colors.white,width:2))),
    child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.zero)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FadeInImage(
                        placeholder:
                        AssetImage('assetsEvo/imagesEvo/cob.png'),
                        image: NetworkImage(
                            // "$URL/Bitcoin/resources/icons/${e.name.toLowerCase()}.png"),
                            "http://45.34.15.25:8080/Bitcoin/resources/icons/${e.name?.toLowerCase()}.png"),
                      ),
                    )
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${e.name}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                  ],
                ),

                SizedBox(width: 60,),
                // Text(
                //     '${double.parse(e.rate.toString()).toStringAsFixed(2)}',
                //     style: TextStyle(fontSize: 18,color: Colors.black)),
                Center(
                  child: Container(
                    // height: 24,
                    // color: Color(0xFF96EE8F),
                    child: ElevatedButton(
                      // color: Colors.black,
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xff745EE7)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff745EE7)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xff745EE7))
                              )
                          )
                      ),
                      // onPressed: () {
                      //   _controllerList!.animateTo(
                      //       _controllerList!.offset - 850,
                      //       curve: Curves.linear,
                      //       duration: Duration(milliseconds: 500));
                      // },
                      onPressed: () {
                              callTrendsDetails();
                            },
                      child: Padding(padding: EdgeInsets.all(20),
                          child:Text("Trade",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),textAlign: TextAlign.center,
                          )),
                    ),

                  ),
                )
              ],
            ),
          ),
        ),
    ),

    onTap: () {},
  ))
      .toList();
}

Future<void> callTrendsDetails() async {
  _saveProfileData();
}

_saveProfileData() async {
  sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
//      sharedPreferences.setString("currencyName", name);
    sharedPreferences!.setInt("index", 2);
    sharedPreferences!.setString("title", AppLocalizations.of(context).translate('coins'));
    sharedPreferences!.commit();
  });

  Navigator.pushReplacementNamed(context, '/homePage');
}
}

class LinearSales {
  final int count;
  final double rate;

  LinearSales(this.count, this.rate);
}
