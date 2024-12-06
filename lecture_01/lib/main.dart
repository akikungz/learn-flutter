import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 127, 167),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Thitipong Tapianthong'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Thitipong Tapianthong",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://scontent.fbkk21-1.fna.fbcdn.net/v/t39.30808-6/277530061_1651949845153059_1882076327746208940_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QIs_YggMZREQ7kNvgE8PXD4&_nc_zt=23&_nc_ht=scontent.fbkk21-1.fna&_nc_gid=AglvLwHqMWU4KH_Lx8oTOqu&oh=00_AYD83UUSQzMvTcOUmI9MEdsBCGbOB3_9w5NO-SvI5pC1lw&oe=6758953B',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
