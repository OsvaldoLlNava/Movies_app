import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/media_list.dart';
import 'package:movies_app/common/MediaProvider.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final MediaProvider movieProvider = MovieProvider();
  final MediaProvider showProvider = ShowProvider();

  PageController _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie; 


  @override
  void initState(){
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Movie"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){},)
        ],
      ),
      drawer: Drawer(
        child:Column(
          children: <Widget>[
            DrawerHeader(
              child: Material(),
            ),
            ListTile(
              title: Text("Peliculas"),
              selected: mediaType == MediaType.movie,
              trailing: Icon(Icons.local_movies),
              onTap: (){
                _changeMediaType(MediaType.movie);
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Television"),
              selected: mediaType == MediaType.show,
              trailing: Icon(Icons.live_tv),
              onTap: (){
                _changeMediaType(MediaType.show);
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Cerrar"),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],

        ),
        
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            _page = index;
          });
        },
        children: _getMediaList()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        items: _getFooterItems(),
        onTap: _navigationTapped,
      ),
    );

    
  }
  List<BottomNavigationBarItem> _getFooterItems(){
      return mediaType == MediaType.movie ? [ 
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up),
          title: Text("Populares")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update),
          title: Text("Proximamente")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Mejor valoradas")
        ),
      ]: 
      [ 
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up),
          title: Text("Populares")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update),
          title: Text("En el Aire")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Mejor valoradas")
        ),
      ];
    }

    void _changeMediaType(MediaType type){
      if(mediaType != type){
        setState(() {
          mediaType = type;
        });
      }
    }

    List<Widget> _getMediaList(){
      return (mediaType == MediaType.movie ?
      <Widget>[
        MediaList(provider: movieProvider, category: "popular",),
        MediaList(provider: movieProvider, category: "upcoming",),
        MediaList(provider: movieProvider, category: "top_rated",),

      ]:
      <Widget>[
        MediaList(provider: showProvider, category: "popular",),
        MediaList(provider: showProvider, category: "on_the_air",),
        MediaList(provider: showProvider, category: "top_rated",)
      ]
      );
    }

    void _navigationTapped(page){
      _pageController.animateToPage(page, duration: const Duration(microseconds: 300), curve: Curves.ease);
    }
}