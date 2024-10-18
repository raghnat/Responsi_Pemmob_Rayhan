import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JumlahhalamanPage extends StatefulWidget {
  const JumlahhalamanPage({Key? key}) : super(key: key);

  @override
  _JumlahhalamanPageState createState() => _JumlahhalamanPageState();
}

class _JumlahhalamanPageState extends State<JumlahhalamanPage> {
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

    const url = 'http://103.196.155.42/api/buku/genre';
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
  Future<void> createBook(String title, String genre, String coverType) async {
    const url = 'http://103.196.155.42/api/buku/genre';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'book_title': title,
          'book_genre': genre,
          'cover_type': coverType,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book added successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add the book.')),
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
      int id, String title, String genre, String coverType) async {
    final url = 'http://103.196.155.42/api/buku/genre/$id/update';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'book_title': title,
          'book_genre': genre,
          'cover_type': coverType,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book updated successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update the book.')),
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
    final url = 'http://103.196.155.42/api/buku/genre/$id/delete';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book deleted successfully.')),
          );
          fetchBooks();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete the book.')),
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
          title: const Text('Add New Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Book Title'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Book Genre'),
              ),
              TextField(
                controller: coverTypeController,
                decoration: const InputDecoration(labelText: 'Cover Type'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                createBook(
                  titleController.text,
                  genreController.text,
                  coverTypeController.text,
                );
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
          title: const Text('Update Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Book Title'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Book Genre'),
              ),
              TextField(
                controller: coverTypeController,
                decoration: const InputDecoration(labelText: 'Cover Type'),
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
                  coverTypeController.text,
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
                  title: Text(book['book_title']),
                  subtitle: Text(
                      'Genre: ${book['book_genre']} | Cover: ${book['cover_type']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showUpdateBookDialog(
                          book['id'],
                          book['book_title'],
                          book['book_genre'],
                          book['cover_type'],
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
