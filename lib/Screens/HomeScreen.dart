import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_weather/Controler/Api_Helper.dart';
import 'package:the_weather/Model/Weather.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WeatherModel> weatherModel;
  ApiHelper apiHelper = ApiHelper();
  String input = '';

  Map<String, String> images = {
    'sn':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'sl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'h':
        'https://c8.alamy.com/comp/MCEDBJ/flakes-and-balls-of-ice-crystals-on-green-grass-after-a-hail-storm-appearing-scenic-in-a-shallow-depth-of-field-landscape-image-MCEDBJ.jpg',
    't':
        'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    'hr':
        'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'ir':
        'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    's':
        'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'hc':
        'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    'c':
        'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop',
    'lc':
        'https://p0.pikist.com/photos/399/89/sky-light-cloud-weather-mood-landscape-romantic-mystery-light-spreading.jpg',
  };
  String imagePath;
  imagesMethod() {
    bool exsist = false;
    var e = images.entries.toList();
    if (weatherModel != null) {
      for (int i = 0; i < images.length; i++) {
        if (e[i].key == weatherModel[0].icon) {
          setState(() {
            imagePath = e[i].value;
            exsist = true;
          });
          break;
        }
        else
          {
            setState(() {
              exsist = false;
            });
        }
      }
    }
    return exsist;
  }

  getDate() {
    apiHelper.getWeatherData(input).then((value) {
      setState(() {
        weatherModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(weatherModel == null
                    ? 'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'
                    : imagesMethod()
                        ? imagePath
                        : 'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'))),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: (){
                        apiHelper.locationDate();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    SvgPicture.network(
                      weatherModel == null
                          ? 'https://www.metaweather.com/static/img/weather/c.svg'
                          : 'https://www.metaweather.com/static/img/weather/${weatherModel[0].icon}.svg',
                      height: 80,
                      width: 180,
                    ),
                    Center(
                        child: Text(
                      weatherModel == null
                          ? '19' + " °C"
                          : weatherModel[0].temp.toStringAsFixed(2) + " °C",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        weatherModel == null ? 'Cairo' : weatherModel[0].cityname,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount:
                              weatherModel == null ? 0 : weatherModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return index != 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                      ),
                                      child: Column(
                                        children: [
                                          Text('High:  ' +
                                              weatherModel[index]
                                                  .maxTemp
                                                  .toStringAsFixed(2)),
                                          Text('Low: ' +
                                              weatherModel[index]
                                                  .minTamp
                                                  .toStringAsFixed(2)),

                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: ' Search Here.....'),
                        onSubmitted: (v) {
                          setState(() {
                            input = v;
                          });
                          getDate();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
