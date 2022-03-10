import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/bloc/hotel_bloc.dart';
import 'package:upwork_assignment/model/hotel_model.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/view/hotel_detail_screen.dart';
import 'package:upwork_assignment/view/login_screen.dart';

class HotelListingScreen extends StatefulWidget {
  const HotelListingScreen({Key? key}) : super(key: key);

  @override
  _HotelListingScreenState createState() => _HotelListingScreenState();
}

class _HotelListingScreenState extends State<HotelListingScreen> {
  final HotelBloc _bloc = HotelBloc();
  @override
  void initState() {
    _bloc.add(GetHotelList()); // add event to bloc
    super.initState();
  }
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView'), centerTitle: true),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:16.0,bottom: 4),
            child: Text('User Name Here',style: Theme.of(context).textTheme.subtitle1,),
          ),
          Text('abc@domain.com',style: Theme.of(context).textTheme.caption,),
          const SizedBox(height: 8,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180,36)
            ),
            child: const Text('Logout'),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen(),),(route) => false,);
            },
          ),
          Expanded(
            child: _hotelListView()
          )

        ],),
      ),
    );
  }

  Widget _hotelListView() {
    return BlocBuilder(
      bloc: _bloc,
      builder: (_, state) {
        //update the ui if anything changes in bloc
        if(state is HotelsLoaded){
          return _listItems(state.hotels);
        }else if(state is NoHotelFound){
          return _messageWidget('No hotel found');
        }else if(state is ErrorModel){
          return _messageWidget(state.message);
        }else{
          return _loadingScreen();
        }
      },
    );
  }
  Widget _messageWidget(String message){
    return Center(child: Text(message),);
  }
  Widget _listItems(List<HotelModel> hotels){
    return  ListView.separated(
      shrinkWrap: true,
      itemCount: hotels.length,
      separatorBuilder: (context,index){
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(),
        );
      },
      itemBuilder: (context, index) {
        return _itemLayout(hotels[index]);
      },
    );
  }
  Widget _itemLayout(HotelModel hotel){
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HotelDetailScreen(hotel),));
      },
      horizontalTitleGap: 16,
      leading: CircleAvatar(
        child: Image.network(
            hotel.image.small,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image,size: 24,),);
          },
          loadingBuilder: (context,widget,event){
            return const Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,),);
          },
        ),
      ),
      title: Text(hotel.title),
      subtitle: Text(hotel.address),
    );
  }

  Widget _loadingScreen() {
    return const Center(child: CircularProgressIndicator());
  }
}
