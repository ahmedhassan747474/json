import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getjson();

/*  for(int i=0;i<_data.length; i++){
    print(_data[i]['title']+"**body   $i   "+_data[i]['body']);
  }*/
  runApp(MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('json parse'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(10.0),
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();
            return new ListTile(
              title: new Text(
                "$position. ${_data[position]['title']}",
                style: TextStyle(fontSize: 18.9),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: new Text(
                  "${_data[position]['id']}",
                  style:
                      new TextStyle(fontSize: 13.4, color: Colors.deepOrange),
                ),
              ),
              onTap: ()
              { _showOnTapMessage( context,"${_data[position]['title']}" );
              }
            );
            
          },
        ),
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context , String message){
  var alert = new AlertDialog(
    title: new Text('App'),
    content:new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);},
        child: new Text('Ok'),

      )
    ],
  );
  showDialog(context: context ,builder: (context) =>alert);
}

Future<List> getjson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
