import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PenulisPage extends StatefulWidget {
  const PenulisPage({Key? key}) : super(key: key);

  @override
  _PenulisPageState createState() => _PenulisPageState();
}

class _PenulisPageState extends State<PenulisPage> {
  List<dynamic> books = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  // Fetch all books
  Future<void> fetchBooks() async {
    setState(() {
      isLoading = true;
    });

    const url = 'http://103.196.155.42/api/buku/penulis';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          setState(() {
            books = data['data'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch books.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch books.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  // Function to create a new book
  Future<void> createBook(
      String author_name, String nationality, int birth_year) async {
    const url = 'http://103.196.155.42/api/buku/penulis';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "author_name": author_name,
          "nationality": nationality,
          "birth_year": birth_year
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Penulis added successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add the Penulis.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Function to update a book
  Future<void> updateBook(
      int id, String author_name, String nationality, int birth_year) async {
    final url = 'http://103.196.155.42/api/buku/penulis/$id/update';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "author_name": author_name,
          "nationality": nationality,
          "birth_year": birth_year
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Penulis updated successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update the Penulis.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Function to delete a book
  Future<void> deleteBook(int id) async {
    final url = 'http://103.196.155.42/api/buku/penulis/$id/delete';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Penulis deleted successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete the Penulis.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Dialog for adding a new book
  void _showAddBookDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController genreController = TextEditingController();
    final TextEditingController coverTypeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Penulis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Penulis'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Negara'),
              ),
              TextField(
                controller: coverTypeController,
                decoration: const InputDecoration(labelText: 'Tahun Lahir'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                createBook(titleController.text, genreController.text,
                    coverTypeController.text as int);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Dialog for updating an existing book
  void _showUpdateBookDialog(int id, String currentTitle, String currentGenre,
      String currentCoverType) {
    final TextEditingController titleController =
        TextEditingController(text: currentTitle);
    final TextEditingController genreController =
        TextEditingController(text: currentGenre);
    final TextEditingController coverTypeController =
        TextEditingController(text: currentCoverType);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Penulis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Penulis'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Negara'),
              ),
              TextField(
                controller: coverTypeController,
                decoration: const InputDecoration(labelText: 'Tahun Lahir'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                updateBook(
                  id,
                  titleController.text,
                  genreController.text,
                  coverTypeController.text as int,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Book List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6A11CB),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book['author_name']),
                  subtitle: Text(
                      'Negara: ${book['nationality']} | Tahun Lahir: ${book['birth_year']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showUpdateBookDialog(
                          book['id'],
                          book['author_name'],
                          book['nationality'],
                          book['birth_year'],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteBook(book['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        backgroundColor: const Color(0xFF6A11CB),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
