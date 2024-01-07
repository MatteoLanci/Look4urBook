import 'package:flutter/material.dart';
import 'package:flutter_get_books/libri_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isTextFieldNotEmpty = false;

  void _navigateToLibriScreen() {
    if (_formKey.currentState?.validate() ?? false) {
      String keyword = _controller.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LibriScreen(keyword: keyword),
        ),
      );
    }
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
      isTextFieldNotEmpty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/look_4_ur_book_icon.png',
                width: 150,
              ),
              const Spacer(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il campo deve essere compilato';
                  }
                  return null;
                },
                controller: _controller,
                onChanged: (text) {
                  setState(() {
                    isTextFieldNotEmpty = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Cerca Libro',
                  suffixIcon: isTextFieldNotEmpty
                      ? IconButton(
                          onPressed: _clearTextField,
                          icon: const Icon(Icons.cancel),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: _navigateToLibriScreen,
                child: const Text('Look4urBook'),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
