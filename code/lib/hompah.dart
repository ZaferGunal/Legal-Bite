import 'package:flutter/material.dart';
import 'package:legalbite/NotiService.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text("Günün Mesajı")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (todaysTitle != null) ...[
              Text(
                todaysTitle!,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                todaysBody ?? "",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _notiService.showNotification(
                  title: "Test Bildirimi",
                  body: "Bu anlık test bildirimi",
                );
              },
              child: const Text("Anlık Test Bildirimi Gönder"),
            ),
          ],
        ),
      ),
    );
  }
}
