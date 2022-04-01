import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


   Map<String,dynamic> data={};
   List<dynamic> country=[];
   Map<String,dynamic> global={};

  Future<dynamic> News()async{
    try{
      var url = Uri.parse('https://api.covid19api.com/summary');
      var response = await http.get(url);
      if(response.statusCode==200){
       return response.body;
      }
      else{
        print('Request failed with status: ${response.statusCode}.');
        return "0";
      }
    }
    catch(e){
      print("dawood error ${e}");
      return "0";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Color(0xff5679FC),
        title: Text("Covid Stats"),
        centerTitle: true,
        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(onPressed: (){

            }, icon: Icon(Icons.search_outlined,size: 40,)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff5679FC),
        onPressed: (){},
        child: Icon(Icons.toc_outlined ,size: 40,color: Colors.white,),
      ),
      body:FutureBuilder(
        future: News(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.data=="0"){
          return Text("Something went wrong");
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasData){
          data=jsonDecode(snapshot.data);
          country=data['Countries'];
          global=data['Global'];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  color:Color(0xffAFC0FF),
                ),
                height: 141,
                width:
                400,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                     height: 150,
                     width: 160,
                      child: Image.network("https://s3-alpha-sig.figma.com/img/cdef/fb2b/00fcbf093d60cee7f1891a8ddca84ff1?Expires=1649635200&Signature=RxCZ9Qm3YxkUHryWWw3e1UFJrBuc3alqrxtbyrXdXLTWBEZlEWXzs-lLVdIQy8dK9pqm4sow1Pu18wpB5mFAwEJ1wgX4B8bnv6JUdxJMR1cPwKs01ebqo9SUVU2-yrITIYvgKoLnOxP9AmR9woh0dpLFcnokzTE9~eaoLbU4muDgBADxEWNEbAg4O3DbwNKyb1mRh7Nq28c6BUb-UKzb6fLdTUhyY4Mz7wpdsiSIZIOUo8TK1iGPE1ryUHCxxOASCUElk1NQD~GvrSQGPmmsuA26HubSdeQSTVW32ZIXHJSlfWRnIfJR3qeV9mMiOUdnyYoqlv7Wcx3oQgggMnssxg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",fit: BoxFit.fill,)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Worldwide Cases",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.w500,color: Color(0xff111111)),),
                        Text("March${global['Date']}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff111111)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("${global['TotalConfirmed']}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xff111111)),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                IconButton(onPressed: (){}, icon:Icon(Icons.sort_by_alpha_outlined,size: 25,)),
                Text("Sort By",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55),
              child: Row(
                children: [
                  InkWell(
                    onTap:
                    (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        )
                      ),
                      height: 35,
                      width: 60,
                      child: Center(child: Text("A to Z")),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            width: 1,
                            color: Color(0xff000000),
                          )
                      ),
                      height: 35,
                      width: 160,
                      child: Center(child: Text("Cases: High to Low")),
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(
              height:15 ,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: country.length,
                  itemBuilder: (context, index)
                  {
                  return Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Color(0xffC7D3FF)),
                        borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             CircleAvatar(
                               radius: 25,
                               backgroundImage: NetworkImage("https://countryflagsapi.com/png/${country[index]['CountryCode']}"),

                             ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("${country[index]['Country']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${country[index]['CountryCode']}",style: TextStyle(fontSize: 16
                              ),),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  height: 24,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2,color:Color(0xffC7D3FF)),
                                      borderRadius: BorderRadius.all(Radius.circular(4))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.network("https://s3-alpha-sig.figma.com/img/ff6d/13f7/c2a928c700a00b1764e8606a844ca44d?Expires=1649635200&Signature=hvvGwKL8Q2nZ7wmofezdCcvHCAK6jjYjOQU1nukHQIHvPhM7Un25u5s7sw8r192vOYvXv4m1CC6XAWyW7TaiM4dQYNVVADitCVZoRRuw969mV9PZ1JxoIznwUNy-qxEMZq-hFg7kaw2HqGPXowMVVJyFx1D3igexAazmpw68xeaWkBcmUChEkTsQBZ560EXSspGXyv9aUFhtAzNB4dZT0cMIg8IYmb-Rio1pSKI2L4FPmXcEHZEigq24BlYo7sMhxMS3txD9fIM3Vv~1bzspkbfy023Q~~lp9Th6upIuS9Y65FHqZOHahDQ5H-u8-8OLdZYXtPwFsxQKY~Etbg1FJA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",fit: BoxFit.fill,),

                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("New Confirmed",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("${country[index]['NewConfirmed']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                SizedBox(
                                  height: 12,
                                ),
                                Text("Total Confirmed",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("${country[index]['TotalConfirmed']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    height: 24,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2,color:Color(0xffC7D3FF)),
                                        borderRadius: BorderRadius.all(Radius.circular(4))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network("https://s3-alpha-sig.figma.com/img/ff6d/13f7/c2a928c700a00b1764e8606a844ca44d?Expires=1649635200&Signature=hvvGwKL8Q2nZ7wmofezdCcvHCAK6jjYjOQU1nukHQIHvPhM7Un25u5s7sw8r192vOYvXv4m1CC6XAWyW7TaiM4dQYNVVADitCVZoRRuw969mV9PZ1JxoIznwUNy-qxEMZq-hFg7kaw2HqGPXowMVVJyFx1D3igexAazmpw68xeaWkBcmUChEkTsQBZ560EXSspGXyv9aUFhtAzNB4dZT0cMIg8IYmb-Rio1pSKI2L4FPmXcEHZEigq24BlYo7sMhxMS3txD9fIM3Vv~1bzspkbfy023Q~~lp9Th6upIuS9Y65FHqZOHahDQ5H-u8-8OLdZYXtPwFsxQKY~Etbg1FJA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",fit: BoxFit.fill,),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("New Deaths",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("${country[index]['NewDeaths']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text("Total Deaths",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("${country[index]['TotalDeaths']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    height: 24,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2,color:Color(0xffC7D3FF)),
                                        borderRadius: BorderRadius.all(Radius.circular(4))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network("https://s3-alpha-sig.figma.com/img/5567/69f9/860510cd5c30703fb9d3633abe5efe3f?Expires=1649635200&Signature=flsgNbT-hoNpX1IPiJPE~lgiaE8jDO-clK3EZywLxrzAOeRFUkWdVgytdJc-7C9PTiKC5u~~hBAwC1KMnOJyaueFFSwoFs51rEKhcat7SskK9pCB~gI~iODX64jDqvcSep--ex9ZAvkzsRbbja~d6i1e3FdSq7vU2wJ0FsPlJ7KTzhDhV5FddeJob3vccI5zLv8seZJTbEtpcwDlm~Hu~9JcC47kqZtL4TxdNH8RO0AbDWnxMbSxWo0ICgghbsW1-QS-MapDJk8d2DhwoWRnw7JPdcTU~uqsWKsbfucEQv4a8uIlZia~K7PKJzeNyPZJHztkjffQeQ8-65BdF0hwOg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",fit: BoxFit.fill,),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("New Recovered",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("${country[index]['NewRecovered']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text("Total Recovered",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("${country[index]['TotalRecovered']}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },),
            ),
          ],
        );
        }
        return Container();
      },),
    );
  }
}
