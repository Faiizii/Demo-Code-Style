import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/bloc/hotel_bloc.dart';
import 'package:upwork_assignment/model/hotel_model.dart';
import 'package:upwork_assignment/model/user_model.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/view/hotel_detail_screen.dart';
import 'package:upwork_assignment/view/login_screen.dart';

class HotelListingScreen extends StatefulWidget {
  final UserModel userModel;
  const HotelListingScreen(this.userModel, {Key? key}) : super(key: key);

  @override
  _HotelListingScreenState createState() => _HotelListingScreenState();
}

class _HotelListingScreenState extends State<HotelListingScreen> {
  final HotelBloc _bloc = HotelBloc();
  @override
  void initState() {
    _bloc.add(GetHotelList()); // add event to bloc that fetch the hotel listing from data source
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
            child: Text('${widget.userModel.fullName}',style: Theme.of(context).textTheme.subtitle1,),
          ),
          Text('${widget.userModel.email}',style: Theme.of(context).textTheme.caption,),

          const SizedBox(height: 8,), //used for spacing purpose. we call use top padding etc.
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180,36) // define the minimum size for button dimension as per shared SS designs
            ),
            child: const Text('Logout'),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              //replace the route with the new route (i.e login screen)
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen(),),(route) => false,);
            },
          ),
          Expanded(
            //to cover the remaining screen area for the hotel listing
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
              //incase the image link is broken or image not found on the provided link
            return const Center(child: Icon(Icons.broken_image,size: 24,),);
          },
          loadingBuilder: (context,widget,event){
              //show progress while the image.network fetch image from the server
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
