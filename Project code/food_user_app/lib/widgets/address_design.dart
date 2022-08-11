import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../mainScreen/placed_order_screen.dart';
import '../maps/maps.dart';
import '../models/address.dart';

class AddressDesign extends StatefulWidget
{
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  _AddressDesignState createState() => _AddressDesignState();
}



class _AddressDesignState extends State<AddressDesign>
{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //select this address
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [

            //address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex!,
                  value: widget.value!,
                  activeColor: Colors.green,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                               Text(
                                   widget.model!.name.toString()
                              ),
                              Text(   " : الاسم",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                               Text(
                                  widget.model!.phoneNumber.toString()
                              ),
                              Text(     " : رقم الهاتف",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                               Text(
                                  widget.model!.flatNumber.toString()
                               ),
                              Text( " : رقم الشقة",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                               Text(
                                  widget.model!.city.toString()
                              ),
                              Text(  " : المدينة",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                               Text(
                                  widget.model!.state.toString()
                              ),
                              Text( " : العنوان",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                               Text(
                                widget.model!.fullAddress.toString(),
                               ),
                              Text(" : العنوان بالكامل", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //button
            ElevatedButton(
              child: const Text("افحص على الخريطة"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              onPressed: ()
              {
                MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);

                //MapsUtils.openMapWithAddress(widget.model!.fullAddress!);
              },
            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count 
                ? ElevatedButton(
                      child: const Text("طلب"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: ()
                      {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (c)=> PlacedOrderScreen(
                              addressID: widget.addressID,
                              totalAmount: widget.totalAmount,
                              sellerUID: widget.sellerUID,
                            )
                          )
                        );
                      },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
