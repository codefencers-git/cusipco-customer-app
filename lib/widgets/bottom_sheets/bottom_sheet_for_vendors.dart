import 'package:cusipco/widgets/bottom_sheets/bottom_sheet_for_book_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/Global/web_view_screen.dart';
import 'package:cusipco/model/book_appo_model.dart';
import 'package:cusipco/model/skincare_detail_model.dart' as Skin;
import 'package:cusipco/screens/main_screen/checkout/checkout_for_other.dart';
import 'package:cusipco/screens/main_screen/my_account/booking_result_screen.dart';
import 'package:cusipco/service/book_appo_services.dart';
import 'package:cusipco/service/time_slot_service/time_slot_model.dart';
import 'package:cusipco/service/time_slot_service/time_slot_service.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/button_widget/rounded_button_widget.dart';
import 'package:cusipco/widgets/general_widget.dart';
import 'package:cusipco/widgets/text_boxes/text_box_with_sufix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class BottomSheetVendors extends StatefulWidget {
  BottomSheetVendors({
    Key? key,
    required this.model,
    required this.urlPerameter,
  }) : super(key: key);
  final Skin.SkincareDetailsModel? model;
  final String urlPerameter;

  @override
  State<BottomSheetVendors> createState() => _BottomSheetVendorsState();
}

class _BottomSheetVendorsState extends State<BottomSheetVendors> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? time;
  int? select;
  var vendorSelection;
  bool isNextClicked = false;
  DateTime currentDate = DateTime.now().add(Duration(days: 1));
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    setInitalDate();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  setInitalDate() {
    _dateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
    Provider.of<TimeSlotService>(context, listen: false).getTimeSlot(
        id: widget.model!.data.ownerId,
        date: _dateController.text,
        mode: "",
        context: context);
  }

  @override
  Widget build(BuildContext context) {

    var vendorList = widget.model!.data.vendors;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.3,
        color: ThemeClass.whiteColor,
        child: Form(
          key: _formKey,
          child: TabBarView(
            controller: _tabController,
            children: [
              selectVendorSheetTab(vendorList),
              bookAppointmentSheetTab()
            ],
          ),
        ),
      );
    });
  }

  Widget selectVendorSheetTab(var vendorList){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Book an Appointment',
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: ThemeClass.blueColor,
                )),
          ],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.model!.data.image[0].toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  widget.model!.data.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeClass.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  widget.model!.data.owner,
                  style: TextStyle(
                    fontSize: 10,
                    color: ThemeClass.blueColor,
                  ),
                ),
                trailing: Text(
                  "₹${widget.model!.data.salePrice}",
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeClass.blueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Vendor",
                style: TextStyle(
                  fontSize: 14,
                  color: ThemeClass.blueColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: ListView(
                  children: [
                    ...vendorList.map((vendor) => _vendorListItem(
                        id: vendor.id,
                        name: vendor.name,
                        address: vendor.address,
                        profileImage: vendor.profileImage))
                  ],
                ),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonWidget(
              title: 'Next',
              color: ThemeClass.blueColor,
              callBack: () async {
                if(vendorSelection != null){
                  _tabController.animateTo(1);
                } else {
                  Fluttertoast.showToast(msg: "Please select vendor !");
                }
                //if (_formKey.currentState!.validate()) {
                  // Navigator.pop(context);
                  // showBottomSheet(
                  //     context: context,
                  //     builder: (context) {
                  //       return BottomSheetBookApointment(
                  //           model: widget.model,
                  //           urlPerameter: widget.urlPerameter);
                  //     });
                  // _bookAppointMent();
                //}
              }),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget bookAppointmentSheetTab(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Book an Appointment',
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: ThemeClass.blueColor,
                )),
          ],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.model!.data.image[0].toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  widget.model!.data.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeClass.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  widget.model!.data.owner,
                  style: TextStyle(
                    fontSize: 10,
                    color: ThemeClass.blueColor,
                  ),
                ),
                trailing: Text(
                  "₹${widget.model!.data.salePrice}",
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeClass.blueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select a Date",
                style: TextStyle(
                  fontSize: 14,
                  color: ThemeClass.blueColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFiledWidget(
                backColor: ThemeClass.greyColorBackgorund,
                oniconTap: () {
                  _selectDate(context);
                },
                hinttext: "Date",
                controllers: _dateController,
                icon: "assets/images/calender_icon.png",
                isClickable: true,
                isReadOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return GlobalVariableForShowMessage
                        .EmptyErrorMessage +
                        "Date";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Select a Slot",
                style: TextStyle(
                  fontSize: 14,
                  color: ThemeClass.blueColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 175,
                child: Consumer<TimeSlotService>(
                    builder: (context, TimeSlotService, child) {
                      if (TimeSlotService.isLoading == true) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: CircularProgressIndicator(
                            color: ThemeClass.blueColor,
                          ),
                        );
                      }

                      if (TimeSlotService.isError) {
                        return Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(TimeSlotService.errorMessage,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ));
                      }

                      if (TimeSlotService.timeSlotList.isEmpty) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text("No Slots Availalble",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                        );
                      }

                      return SizedBox(
                        child: GridView.builder(
                            itemCount:
                            TimeSlotService.timeSlotList.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 4 / 1.8),
                            itemBuilder: (context, index) {
                              return _buildTrainerBox(
                                  TimeSlotService.timeSlotList, index);
                            }),
                      );
                    }),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonWidget(
              title: 'Submit',
              color: ThemeClass.blueColor,
              callBack: () async {
                if (_formKey.currentState!.validate()) {
                  _bookAppointMent();
                }
              }),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  _vendorListItem(
      {String? id, String? name, String? address, String? profileImage}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: NetworkImage(profileImage!), fit: BoxFit.cover)),
          height: 40,
          width: 40,
        ),
        Container(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 200,
                child: Expanded(
                    child: Text(
                  name!,
                  maxLines: 1,
                ))),
            Text(
              address!,
              style: TextStyle(color: Colors.grey, fontSize: 12),
              maxLines: 1,
            )
          ],
        ),
        Spacer(),
        Radio(
          value: int.parse(id!),
          groupValue: vendorSelection,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              vendorSelection = val!;
            });
          },
        ),
      ],
    );
  }

  InkWell _buildTrainerBox(List<TimeSlot> timing, int index) {
    final data = timing[index];
    return InkWell(
      onTap: () {
        setState(() {
          select = index;
          time = data.slug;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: select == index
              ? ThemeClass.blueColor
              : ThemeClass.greyColorBackgorund,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              data.title.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                  color: select == index
                      ? ThemeClass.whiteColor
                      : ThemeClass.greyColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  _bookAppointMent() async {
    if (time != null) {
      Navigator.pop(context);
      pushNewScreen(
        context,
        screen: CheckoutForOtherScreen(
          moduleView: 1,
          id: widget.model!.data.id.toString(),
          chanrges: widget.model!.data.salePrice == ""
              ? "${widget.model!.data.price}"
              : "${widget.model!.data.salePrice}",
          date: _dateController.text.toString(),
          module: widget.urlPerameter,
          payableAmount: widget.model!.data.payableAmount.toString(),
          time: time.toString(),
          name: widget.model!.data.title.toString(),
          mode: "",
          tax: widget.model!.data.tax != null
              ? widget.model!.data.tax.toString()
              : "",
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    } else {
      showToast("Please Select Time.");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now().add(Duration(days: 1)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ThemeClass.blueColor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ThemeClass.blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        currentDate = pickedDate;
        _dateController.text = formattedDate;

        select = null;
        time = null;
      });

      setInitalDate();
    }
  }

  InkWell _buildSlotTime(
      Skin.Data model, int index, void Function(void Function()) seState) {
    final data = 0;
    return InkWell(
      onTap: () {
        // print(data.slug);
        // print(data.title);
        seState(() {
          select = index;
          // time = data.slug;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: select == index
              ? ThemeClass.blueColor
              : ThemeClass.greyColorBackgorund,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "data.title",
              textAlign: TextAlign.center,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                  color: select == index
                      ? ThemeClass.whiteColor
                      : ThemeClass.greyColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  showBookAppoinment() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet 1'),
                ElevatedButton(
                  child: const Text('Show second modal 2'),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.redAccent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet 2'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
