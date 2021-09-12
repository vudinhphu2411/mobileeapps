import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';

class BottomTab2 extends StatefulWidget {
  const BottomTab2({Key? key, required this.customerInfo}) : super(key: key);
  final CustomerInfo customerInfo;

  @override
  _BottomTab2State createState() => _BottomTab2State();
}

class _BottomTab2State extends State<BottomTab2> {
  TextEditingController _searchcontroller = TextEditingController();
  final customer = CustomerInfo();

  late String searchString;
  Future<QuerySnapshot> getUser() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserRecord');
    return await users.get();
  }

  @override
  void initState() {
    super.initState();
    _searchcontroller.addListener(_onSearchChanged);
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchcontroller.text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 50,
              ),
              child: TextField(
                controller: _searchcontroller,
                decoration: InputDecoration(
                  hintText: 'Search Name Of The Property',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  // ignore: unnecessary_null_comparison
                  stream: (searchString == null || searchString.trim() == '')
                      ? FirebaseFirestore.instance
                          .collection('UserRecord')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('UserRecord')
                          .where('searchIndex', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('We got an error ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                          child: Center(
                            child: Text('Loading...'),
                          ),
                        );
                      case ConnectionState.none:
                        return Text('Oops no data to present');
                      case ConnectionState.done:
                        return Text('We are done!');
                      default:
                        return new ListView(
                          children: [
                            // snapshot.data.docs
                          ],
                        );
                    }
                  }),
            )
          ],
        ),
      );
}
