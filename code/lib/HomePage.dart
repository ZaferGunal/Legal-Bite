import 'package:flutter/material.dart';
import 'package:legalbite/MyColors.dart';
import 'package:legalbite/NotiService.dart';

import 'ListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotiService _notiService = NotiService();
  String? todaysTitle;
  String? todaysBody;

  @override
  void initState() {
    super.initState();
    _notiService.initNotification();
    _loadTodaysMessage();
  }

  void _loadTodaysMessage() {
    final msg = _notiService.getTodaysMessage();
    setState(() {
      todaysTitle = msg["title"];
      todaysBody = msg["body"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MyColors.beige
        ,

      body: Stack( children: [Center(child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,children:[



            Align(alignment: Alignment.centerLeft,child: Padding(child:Text("Bugün",style: TextStyle(color:Colors.black,fontSize: 32,fontWeight:FontWeight.w600))
              ,padding: const EdgeInsets.fromLTRB(6, 30, 0, 14),
            )),
            Container(
              height: 250,
              width: double.infinity, // Genişlik sınırsız (ekranı kaplar)

              padding: const EdgeInsets.all(10), // içerik ile çeper arasındaki boşluk
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // yuvarlak köşeler
                border: Border.all(
                  color: MyColors.green, // kenarlık rengi
                  width: 2.1, // kalınlık
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    todaysTitle != null
                        ? Column(
                      children: [
                           SizedBox(height:3),
                        Text(textAlign: TextAlign.start,
                          todaysTitle!,
                          style: const TextStyle(
                            fontSize: 22,
                            color: MyColors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Divider(color: Colors.black,thickness:  1.75,height: 40,),
                        Text(
                          todaysBody ?? "",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    )
                        : const SizedBox(), // boş bırakmak için,
                  ],
                ),
              ),
            ),
           SizedBox(height: 39),
          PressableContainer(onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListPage()),
          );
          }),
          SizedBox(height:21),
          PressableContainer2(onTap: (){     showDialog(
            context: context,
            barrierDismissible: true, //
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // köşeleri yuvarlat
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MyColors.beige2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // içeriğe göre boyut
                    children: [
                      Image.asset(
                        "assets/app_logo.png", //
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(textAlign:TextAlign.start,
                        "  Legal Bite’ın misyonu, hukuk bilgisini demokratikleştirmek ve adalet sistemini herkes için daha erişilebilir hale getirmektir. Amacı, kaliteli hukuki içerik sunmak, karmaşık hukuki terimleri basitleştirmek ve kullanıcıların yasal haklarını etkili bir şekilde anlamalarına ve kullanmalarına destek olmaktır."

,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              );
            },
          );}),



        ]),
      ))
   , Positioned(height: 120,child:Image.asset('assets/black_transparent.png'),bottom:10, right:10),]));
  }
}
















//////////////////////////////////////////////////////////////////////////////////////////

class PressableContainer extends StatefulWidget {
  final VoidCallback onTap;

  const PressableContainer({super.key, required this.onTap});

  @override
  State<PressableContainer> createState() => _PressableContainerState();
}

class _PressableContainerState extends State<PressableContainer> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.identity()..scale(_pressed ? 0.96 : 1.0),
        height: 53,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _pressed ? MyColors.green.withOpacity(0.85) : MyColors.green,
          border: Border.all(color: Colors.black, width: 1.3),
          borderRadius: BorderRadius.circular(19),
          boxShadow: _pressed
              ? []
              : [const BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )],
        ),
        child: const Center(
          child: Text(
            "Hepsini Görüntüle",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white, // MyColors.white kullanabilirsin
            ),
          ),
        ),
      ),
    );
  }
}


class PressableContainer2 extends StatefulWidget {
  final VoidCallback onTap;

  const PressableContainer2({super.key, required this.onTap});

  @override
  State<PressableContainer2> createState() => _PressableContainerState2();
}

class _PressableContainerState2 extends State<PressableContainer2> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.identity()..scale(_pressed ? 0.96 : 1.0),
        height: 53,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 1.3),
          borderRadius: BorderRadius.circular(19),

        ),
        child: const Center(
          child: Text(
            "Legal Bite'ın Misyonu",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black, // MyColors.white kullanabilirsin
            ),
          ),
        ),
      ),
    );
  }
}


