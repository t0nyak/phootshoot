import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketPage extends StatefulWidget {
  MarketPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MarketPageState createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int _counter = 0;
  ListTile _playersList;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    _playersList = new ListTile(
        title: Row(
            children: [
              Expanded(
                  child: Text(
                    document['name'],
                    style: Theme.of(context).textTheme.headline,
                  )
              ),
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffddddff),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['position'].toString(),
                    style: Theme.of(context).textTheme.display1,
                  )
              )
            ]
        ),
        onTap: () {
          Firestore.instance.runTransaction((transaction) async {
            DocumentSnapshot freshSnap =
            await transaction.get(document.reference);
            await transaction.update(freshSnap.reference,{
              'inMarket': true
            });
          });
        }
    );
    return _playersList;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('players').where('inMarket', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemExtent: 80.0,
    //        itemCount: snapshot.data.documents.length,
            itemCount: 40,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Update market',
        child: new Icon(Icons.update),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}