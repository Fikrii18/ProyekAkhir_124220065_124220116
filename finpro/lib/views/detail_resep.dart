import 'package:finpro/model/komentar.dart';
import 'package:finpro/views/widget/resep_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailResep extends StatefulWidget {
  final String name;
  final String images;
  final String rating;
  final String totalTime;
  final String description;
  final String videoUrl;
  final String username;

  DetailResep({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.description,
    required this.videoUrl,
    required this.username,
  });

  @override
  State<DetailResep> createState() => _DetailResepState();
}

class _DetailResepState extends State<DetailResep> {
  final _commentController = TextEditingController();
  late Box<Komentar> _komentarBox;
  int? _editingKomentarId;

  @override
  void initState() {
    super.initState();
    
    Hive.openBox<Komentar>('komentarBox').then((box) {
      setState(() {
        _komentarBox = box;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resep', style: TextStyle()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResepCard(
              title: widget.name,
              rating: widget.rating,
              cookTime: widget.totalTime,
              thumbnailUrl: widget.images,
              videoUrl: widget.videoUrl,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.description,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _komentarBox.listenable(),
                builder: (context, Box<Komentar> box, _) {
                  final komentarList = box.values
                      .where((komentar) => komentar.resepId == widget.name)
                      .toList();
                  return ListView.builder(
                    itemCount: komentarList.length,
                    itemBuilder: (context, index) {
                      final komentar = komentarList[index];
                      return ListTile(
                        title: Text(komentar.username),
                        subtitle: Text(komentar.komentar),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _commentController.text = komentar.komentar;
                                _editingKomentarId = komentar.key;
                                showCommentInput();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteKomentar(komentar.key);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _commentController.clear();
          _editingKomentarId = null;
          showCommentInput();
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }

  void showCommentInput() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(labelText: 'Tambah Komentar'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      if (_editingKomentarId == null) {
                      
                        addKomentar(widget.name, widget.username, _commentController.text);
                      } else {
                      
                        updateKomentar(_editingKomentarId!, _commentController.text);
                      }
                      _commentController.clear();
                      Navigator.pop(context); 
                    }
                  },
                  child: Text(
                    _editingKomentarId == null ? 'Tambah Komentar' : 'Update Komentar',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addKomentar(String resepId, String username, String komentar) {
    final newKomentar = Komentar(
      resepId: resepId,
      username: username,
      komentar: komentar,
    );
    _komentarBox.add(newKomentar);
  }

  void updateKomentar(int komentarId, String komentar) {
    final updatedKomentar = _komentarBox.get(komentarId);
    if (updatedKomentar != null) {
      final newKomentar = Komentar(
        resepId: updatedKomentar.resepId,
        username: updatedKomentar.username,
        komentar: komentar,
      );
      _komentarBox.put(komentarId, newKomentar);
    }
  }

  void deleteKomentar(int komentarId) {
    _komentarBox.delete(komentarId);
  }
}
