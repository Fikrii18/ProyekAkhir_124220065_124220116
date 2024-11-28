import 'package:finpro/model/resep.dart';
import 'package:finpro/model/resep_api.dart';
import 'package:finpro/profil_page.dart';
import 'package:finpro/views/detail_resep.dart';
import 'package:finpro/views/widget/resep_card.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late List<Resep> _resep;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Resep Makanan'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfilePage(username: widget.username);
              }));
            },
          ),
        ],
        
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _resep.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ResepCard(
                    title: _resep[index].name,
                    rating: _resep[index].rating.toString(),
                    cookTime: _resep[index].totalTime,
                    thumbnailUrl: _resep[index].images,
                    videoUrl: _resep[index].videoUrl,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailResep(
                          username: widget.username,
                          name: _resep[index].name,
                          rating: _resep[index].rating.toString(),
                          totalTime: _resep[index].totalTime,
                          images: _resep[index].images,
                          description: _resep[index].description,
                          videoUrl: _resep[index].videoUrl,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
