import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/vertical_image_text.dart';

import '../../controllers/image_path.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_ , index){
          return VerticalImageText(image: ImagePath.bag, title: "Bag" , onTap: (){},);
        },
        itemCount: 6,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
