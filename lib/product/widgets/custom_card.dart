import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';
import 'package:kartal/kartal.dart';
import '../../feature/descriptionPage/view/description_page_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';

class CustomCard extends StatefulWidget {
  final JobsModel job;
  final UserModel user;
  const CustomCard({Key? key, required this.job, required this.user})
      : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool starLight = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFav();
    checkFav();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionPageView(
                job: widget.job,
                user: widget.user,
              ),
            ));
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                  child: widget.job.jobImage != null
                      ? Image.network(widget.job.jobImage ?? "")
                      : Image.network("https://picsum.photos/400/300")),
              title: Text(
                widget.job.jobName ?? "",
                maxLines: 2,
              ),
              subtitle: Text(
                widget.job.jobDetail ?? "",
                maxLines: 2,
              ),
              trailing: IconButton(
                  onPressed: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteView(),
                        ));*/
                    getFav(); //kontrol et favlanmışsa kaldır değilse ekle
                  },
                  icon: Icon(Icons.star)),
              iconColor: starLight ? Colors.yellow : Colors.grey,
            ),
            Padding(
              padding: context.paddingLow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.job.jobTime ?? "sdasdads"),
                  Text(widget.job.cost ?? "")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getFav() async {
    await FireStoreServisi().addFav(widget.job);
  }

  checkFav() async {
    bool isFav = await FireStoreServisi().checkStar(widget.job.id ?? "");
    setState(() {
      starLight = isFav;
    });
    return isFav;
  }
}
