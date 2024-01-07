import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_get_books/libro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'libroScreen.dart';

class LibriScreen extends StatefulWidget {
  final String keyword;
  const LibriScreen({required this.keyword, Key? key}) : super(key: key);

  @override
  State<LibriScreen> createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  Icon icona = const Icon(Icons.search);
  Widget widgetRicerca = const Text('Cerca il tuo libro preferito');
  String risultato = '';
  List<Libro> libri = [];
  bool isRicercaInCorso = false;

  @override
  void initState() {
    cercaLibri();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widgetRicerca,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (icona.icon == Icons.search) {
                    icona = const Icon(Icons.cancel);
                    widgetRicerca = TextField(
                      onSubmitted: (testoRicerca) => cercaLibri(),
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    );
                  } else {
                    setState(() {
                      icona = const Icon(Icons.search);
                      widgetRicerca =
                          const Text('Cerca il tuo libro preferito');
                    });
                  }
                });
              },
              icon: icona),
        ],
      ),
      body: isRicercaInCorso
          ? (const Center(
              child: CircularProgressIndicator(),
            ))
          : ListView.builder(
              itemCount: libri.length,
              itemBuilder: (BuildContext context, int posizione) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => LibroScreen(libri[posizione]));
                      Navigator.push(context, route);
                    },
                    leading: (libri[posizione].immagineCopertina != '')
                        ? Hero(
                            tag: 'cover_img',
                            child: Image.network(
                                libri[posizione].immagineCopertina))
                        : const FlutterLogo(),
                    title: Text(libri[posizione].titolo),
                    subtitle: Text(libri[posizione].autori),
                  ),
                );
              },
            ),
    );
  }

  Future cercaLibri() async {
    const dominio = 'www.googleapis.com';
    const percorso = '/books/v1/volumes';
    Map<String, dynamic> parametri = {'q': widget.keyword};

    final Uri url = Uri.https(dominio, percorso, parametri);

    setState(() {
      risultato = 'Ricerca in corso';
      isRicercaInCorso = true;
    });

    try {
      http.get(url).then((res) {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'];
        libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();

        setState(() {
          risultato = res.body;
          libri = libri;
          isRicercaInCorso = false;
        });
      });
    } catch (e) {
      setState(() {
        risultato = '';
      });
    }
  }
}
