import 'package:agriamuse/Screens/SmartConnect/Add_crops.dart';
import 'package:agriamuse/Screens/SmartConnect/Crop_details.dart';
import 'package:agriamuse/models/crop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _db = FirebaseFirestore.instance;

Future<List<crop>> allcrop() async {
  final snapshot = await _db.collection("smartconnect").get();
  final allData = snapshot.docs.map((e) => crop.fromSnapshot(e)).toList();
  return allData;
}

class Crops extends StatefulWidget {
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  int currentPageIndex = 0;

  final Color primaryColor = const Color(0xFF66BB6A);

  final Color bgColor = const Color(0xffF9E0E3);

  final Color secondaryColor = const Color(0xff324558);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.green.shade300,
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
            toolbarTextStyle: TextTheme(
              titleLarge: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ).bodyMedium,
            titleTextStyle: TextTheme(
              titleLarge: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ).titleLarge,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Crops'),
            leading: const Icon(FontAwesomeIcons.tools),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: primaryColor,
              unselectedLabelColor: secondaryColor,
              tabs: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(""),
                ),
                /* Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      displayRentToolsCtrl.selectedCategory.value = "Tractors";
                    },
                    child: Text("Tractors"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      displayRentToolsCtrl.selectedCategory.value =
                          "Harvestors";
                    },
                    child: Text("Harvestors"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      displayRentToolsCtrl.selectedCategory.value =
                          "Pesticides";
                    },
                    child: Text("Pesticides"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      displayRentToolsCtrl.selectedCategory.value = "Others";
                    },
                    child: Text("Others"),
                  ),
                ), */
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: allcrop().toString().length,
                itemBuilder: (context, index) {
                  return _buildArticleItem(index);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
              ),
            ],
          ),
          /* bottomNavigationBar: NavigationBarApp(), */
          /* bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.folderOpen),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "",
              ),
            ],
          ), */
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCrops()),
              );
            },
            backgroundColor: Colors.green.shade300,
            hoverColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleItem(int index) {
    return FutureBuilder(
      future: allcrop(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<crop> cropList = snapshot.data as List<crop>;
            if (index < cropList.length) {
              crop data = cropList[index];
              return Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 90,
                      //color: bgColor,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          /* Container(
                              height: 100,
                              color: Colors.green,
                              width: 80.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(data.pic),
                              )), */

                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(data.pic),
                          ),
                          const SizedBox(width: 18.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CropDetails(
                                          cropData: cropList[index],
                                        )),
                              );
                            },
                            child: Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    data.cropname.toString(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    "MSP: " + data.msp.toString(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    "Quantity: " + data.quantity.toString(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  /* Text.rich(
                                    TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: SizedBox(width: 5.0),
                                        ),
                                        const WidgetSpan(
                                          child: SizedBox(width: 5.0),
                                        ),
                                        TextSpan(
                                          text: data.msp.toString(),
                                        ),
                                      ],
                                    ),
                                    style: const TextStyle(height: 2.0),
                                  ), */
                                  /* Icon(Icons.description), */
                                  /* ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                              ,
                                MaterialPageRoute(builder: (context) => Details()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text("Details"),
                          ), */
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text("");
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong!!"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
