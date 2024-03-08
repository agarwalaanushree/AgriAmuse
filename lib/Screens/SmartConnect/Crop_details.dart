import 'package:agriamuse/models/crop_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CropDetails extends StatelessWidget {
  final crop cropData;
  CropDetails({Key? key, required this.cropData}) : super(key: key);

  call(String x) async {
    print(x);
    // ignore: deprecated_member_use
    await launch('tel:$x');
  }

  /* Uri x = Uri(scheme: "tel", path: x);
  call(String x) async {
    await launchUrl(x);
  } */

  final Color primaryColor = const Color(0xFF66BB6A);

  final Color bgColor = const Color(0xffF9E0E3);

  final Color secondaryColor = const Color(0xff324558);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: const Text('Details'),
        leading: const Icon(FontAwesomeIcons.tools),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Image(
                image: NetworkImage(cropData.pic),
                height: MediaQuery.of(context).size.height / 1.55,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Crop Name: " + cropData.cropname.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Selling Price: " + cropData.msp,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Quantity: " + cropData.quantity,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(cropData.descr),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      onPressed: () {
                        call(cropData.contact);
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.call),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Contact",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    /* ElevatedButton(
                      onPressed: () {},
                      /* shape: StadiumBorder(), */
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Book",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
