import 'package:flutter/material.dart';
import 'package:flutter_get_books/home_screen.dart';
// import 'package:flutter_get_books/libro.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'libroScreen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Books',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          // brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // home: const LibriScreen(),
      home: const HomeScreen(),
    );
  }
}

// class LibriScreen extends StatefulWidget {
//   const LibriScreen({super.key});

//   @override
//   State<LibriScreen> createState() => _LibriScreenState();
// }

// class _LibriScreenState extends State<LibriScreen> {
//   Icon icona = const Icon(Icons.search);
//   Widget widgetRicerca = const Text('Libri');
//   String risultato = '';
//   List<Libro> libri = [];

//   @override
//   void initState() {
//     cercaLibri('harry potter');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: widgetRicerca,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   if (icona.icon == Icons.search) {
//                     icona = const Icon(Icons.cancel);
//                     widgetRicerca = TextField(
//                       onSubmitted: (testoRicerca) => cercaLibri(testoRicerca),
//                       textInputAction: TextInputAction.search,
//                       style: const TextStyle(color: Colors.black, fontSize: 20),
//                     );
//                   } else {
//                     setState(() {
//                       icona = const Icon(Icons.search);
//                       widgetRicerca = const Text('Libri');
//                     });
//                   }
//                 });
//               },
//               icon: icona),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: libri.length,
//         itemBuilder: (BuildContext context, int posizione) {
//           return Card(
//             elevation: 2,
//             child: ListTile(
//               onTap: () {
//                 MaterialPageRoute route = MaterialPageRoute(
//                     builder: (_) => LibroScreen(libri[posizione]));
//                 Navigator.push(context, route);
//               },
//               leading: (libri[posizione].immagineCopertina != '')
//                   ? Image.network(libri[posizione].immagineCopertina)
//                   : const FlutterLogo(),
//               title: Text(libri[posizione].titolo),
//               subtitle: Text(libri[posizione].autori),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future cercaLibri([String? ricerca]) async {
//     const dominio = 'www.googleapis.com';
//     const percorso = '/books/v1/volumes';
//     Map<String, dynamic> parametri = {};

//     if (ricerca != null && ricerca.isNotEmpty) {
//       parametri = {'q': ricerca};
//     }

//     final Uri url = Uri.https(dominio, percorso, parametri);

//     setState(() {
//       risultato = 'Ricerca in corso';
//     });

//     try {
//       http.get(url).then((res) {
//         final resJson = json.decode(res.body);
//         final libriMap = resJson['items'];
//         libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();

//         setState(() {
//           risultato = res.body;
//           libri = libri;
//         });
//       });
//     } catch (e) {
//       setState(() {
//         risultato = '';
//       });
//     }
//   }
// }
