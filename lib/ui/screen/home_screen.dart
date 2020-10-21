import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/extensions/scroll_controller.dart';
import 'package:nice_animals_flutter/main.dart';
import 'package:nice_animals_flutter/ui/screen/gallery_screen.dart';
import 'package:shibe_api/shibe_api.dart';

const aspectRatio = 1.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller;
  bool _loading = false;
  bool _loadingMore = false;
  List<AnimalPicture> _dogs = [];

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..onBottomReach(
        _loadMore,
        throttleDuration: const Duration(seconds: 1),
      );

    _initAsync();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initAsync() async {
    setState(() {
      _loading = true;
    });

    final newDogs = await shibeApiService.get(AnimalType.shibes);

    if (mounted) {
      setState(() {
        _dogs = newDogs.toList();
        _loading = false;
      });
    }
  }

  void _loadMore() async {
    if (_loadingMore) {
      return;
    }

    setState(() {
      _loadingMore = true;
    });

    final newDogs = await shibeApiService.get(AnimalType.shibes);

    if (mounted) {
      setState(() {
        _dogs = _dogs + newDogs.toList();
        _loadingMore = false;
      });
    }
  }

  Widget _buildBody() {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    final ratio = MediaQuery.of(context).size.width / 300;

    return SafeArea(
      bottom: false,
      child: GridView.count(
        crossAxisCount: ratio.ceil(),
        controller: _controller,
        childAspectRatio: aspectRatio,
        children: List.generate(
          _dogs.length,
          (index) {
            final animal = _dogs[index];

            return _buildImage(animal);
          },
        ),
      ),
    );
  }

  Widget _buildImage(AnimalPicture animal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GalleryScreen(animal.url),
          ),
        );
      },
      child: Hero(
        tag: animal.url,
        child: CachedNetworkImage(
          imageUrl: animal.url,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          errorWidget: (context, url, error) {
            return Image.asset('assets/image_not_found.png');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shibes'),
      ),
      body: _buildBody(),
    );
  }
}
