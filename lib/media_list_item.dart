import 'package:flutter/material.dart';
import 'package:movies_app/model/Media.dart';


class MediaListItem extends StatelessWidget{
  final Media media;
  
  

  MediaListItem({this.media});

  @override
  Widget build(BuildContext context){
    final String fechita = media.releaseDate;
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: "assets/placeholder.jpg", 
                  image: media.backdropPath != "" ? media.getBackdropUrl():"https://image.freepik.com/foto-gratis/representacion-3d-signo-interrogacion-blanco-aislado-fondo-negro_42071-126.jpg",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  fadeInDuration: Duration(milliseconds: 40),
                  ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.grey[900].withOpacity(0.5)
                    ),
                  constraints: BoxConstraints.expand(
                    height: 55
                  ),
                  
                  ), 
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          media.title, 
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold)
                          ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Row(
                          children: <Widget>[
                            Text(media.getGenres(), style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,),

                            

                          ],
                        ),

                      ),
                      

                    ],
                    

                  )
                  ),
                  Positioned(
                    right: 15,
                    bottom: 10,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(media.voteAverage.toString()),
                            SizedBox(width:15,),
                            Icon(Icons.star, size: 15,)
                          ],
                        ),
                        Container(height: 4.0,),
                        Row(children: <Widget>[
                          
                          Text(media.releaseDate != null ? fechita.substring(0,4):"No Data"),
                          SizedBox(width: 5,),
                          Icon(Icons.date_range, color:Colors.white, size: 15,)
                        ],)
                      ],
                    ))


              ],
            ),

          ),
          
        ],
      ),
    );

  }
}