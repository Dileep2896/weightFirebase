import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/net/flutterfire.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  alignment: AlignmentDirectional.topEnd,
                  child: MaterialButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 16,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            // ignore: avoid_unnecessary_containers
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              // ignore: avoid_unnecessary_containers
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "${data['weight']} ${data['type']}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.shade700,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddView(
                                                type: data['type'],
                                                weight:
                                                    data['weight'].toString(),
                                                isUpdate: true,
                                                uid: document.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.yellow.shade100,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        color: Colors.red.shade500,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: MaterialButton(
                                        onPressed: () {
                                          String uid = document.id;
                                          deleteWeight(uid);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade100,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(
                type: "-0",
                weight: "-0",
                isUpdate: false,
                uid: "-0",
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
