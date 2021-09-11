import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,  // -> a truyền vào đây việc cần làm của cái nút
    required this.buttonTitle, //-> cái này dùng để hiển thị tên nút  -> cái complêt là do biến này cung cấp
    required this.textStyle,  //-> cái này chính là style dành cho tên nút -> style của complêt do cái này cung cấp
    required this.height, // -> cái này chính là chiều cao của nút  -> chiều cao của nút đo cái này cung cấp
    this.customerInfo,
  }) : super(key: key);
  final void Function() onTap; // onTap -> là một cái hàm
  final String buttonTitle; // -> đây là một chuỗi
  final TextStyle textStyle; // -> đây là textStyle dành cho widget Text
  final double height; // -> đây là chiều cao của cái nút
  final CustomerInfo? customerInfo; // -> đây là dữ liệu mình cần xử lý khi sử dụng cái nút
  // đó là code cũ của e, giờ xem thử a viết lại class này như thế nào á
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> { // đây là trạng thái của CustomButton, mỗi đối tượng tạo ra sẽ có một trạng thái

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(); // khởi tạo fỉebase
  late CustomerInfo customer = new CustomerInfo();  // khai báo trạng thía của CustomButton, biến customer để nhận thông tin truyền tùe class xuống
  final db = FirebaseFirestore.instance; // lấy db = Firebáe.....
  @override
  @override
  void initState() {  // khởi tạo trạng thái cho nút (cho CustomButton ấy)
    customer = new CustomerInfo(); // lấy dự liệu từ class gửi qua (thực thế là lấy dữ liệu từ đối tượng)
    super.initState(); // 
  }
  @override
  Widget build(BuildContext context) { // hàm build, CustomButton sẽ trả về cho mình
    return SingleChildScrollView( // single child view
      child: FutureBuilder( // -> chờ để khởi tạo firebáe
        future: _initialization,
        builder: (context, snapshot){
          if (snapshot.hasError) { // nếu như khởi tạo thất phải thì trả về Container chứa text là erro
            return Container(
              child: Center(child: Text('Eror'),),
            );
          }
          if (snapshot.connectionState == ConnectionState.done){ // nếu như _initialization đã thực hiện xong thì trả về
            return Container( // đây là cái nút 
                height: widget.height, // -> height ??? lấy từ class CustomButton, được truyền vào thông qua biến height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient( // cái này là phần màu gradient vàng cam của nút
                    colors: [Color(0xFFF8A170), Color(0xFFFFCD61)], 
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                // phần trên là phần trang trí cho cái nút (màu mè ....)
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.buttonTitle, // -> Trong FlatButton có một cái Text với nội dung buttonTitle lấy từ class sang ? tên nút
                      style: widget.textStyle, // -> sử dụng style lấy từ class 
                    ),
                  ),
                  // nhưng mà thứ nó thực sự làm là ở onPress này, a truyền hàm vào onTap mà chưa sử dụng
                  // hôm trước cái nút vẫn hoạt động bình thường (vẫn check được) là do a chưa xoá phần code của e ở đây á,
                  // nay a chỉnh nhưng mà chưa hiểu nên nó ko chạy á
                  onPressed: (){ // sự kiện onpress của cái nút, đay là những gì mà cái nút làm khi người ta bấm
                    // để sử dngj được onTap
                    widget.onTap(); // như này thì những gì a bắt nó làm ở hàm ontap mới được thực hiện
                    
                    // vì cái CustomButton này được dùng ở nhiều nơi nên a không nên cho code cứng vào đây
                    // tại cái on
                  },
                ),
              );
          }

          return Container(child: Center(child: Text('Loading'),));
   
        },
      ),
    );
  }
}
