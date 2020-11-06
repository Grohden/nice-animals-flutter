import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/extensions/scroll_controller.dart';
import 'package:nice_animals_flutter/main.dart';
import 'package:nice_animals_flutter/ui/screen/gallery_screen.dart';
import 'package:shibe_api/shibe_api.dart';
import 'package:async/async.dart' show Result;

const aspectRatio = 1.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller;
  String _error;
  bool _loading = false;
  List<AnimalPicture> _dogs = [];

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..onBottomReach(
        () => _makeListRequest((items) => _dogs + items),
        throttleDuration: const Duration(seconds: 1),
      );

    _makeListRequest((items) => items);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _makeListRequest(
    List<AnimalPicture> Function(List<AnimalPicture> items) listTransform,
  ) async {
    if (_loading) {
      return;
    }

    setState(() {
      _error = null;
      _loading = true;
    });

    final result = await Result.capture(shibeApiService.get(AnimalType.shibes));

    if (mounted) {
      setState(() {
        if (result.isError) {
          _error = result.asError.error.toString();
        } else {
          _dogs = listTransform(result.asValue.value.toList());
        }

        _loading = false;
      });
    }

  }

  Widget _buildBody() {
    if (_error?.isNotEmpty == true) {
      return Center(child: Text(_error));
    }

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
