import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';

class NCRFormWidget extends StatelessWidget {
  const NCRFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              // Header row with kfc logo and company name
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'kfc',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'KOVAII FINE COAT ( P ) LIMITED',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Second header row
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'NON CONFORMITY REPORT / CORRECTIVE AND PREVENTIVE ACTION REPORT ( INPROCESS/FINAL/ CUSTOMER )',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // Third header row
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '( FOR CONCESSIONAL ACCEPTANCE / REJECTION )',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // First data row - NCR NO, DATE, DEPARTMENT
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('NCR NO', flex: 2),
                    _buildCell('C.C.001', flex: 2),
                    _buildCell('DATE', flex: 2),
                    _buildCell('13.06.2023', flex: 2),
                    _buildCell('DEPARTMENT', flex: 2),
                    _buildCell('CED', flex: 2),
                  ],
                ),
              ),

              // Second data row - ITEM NAME, ROUTE CARD NO
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('ITEM NAME', flex: 2),
                    _buildCell('PAINTING COOLER', flex: 4),
                    _buildCell('ROUTE CARD NO', flex: 2),
                    _buildCell('-', flex: 2),
                  ],
                ),
              ),

              // Third data row - DRAWING NO, REV NO, INS.REPORT NO
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('DRAWING NO', flex: 2),
                    _buildCell('1536.032.1000 , 1536.032.200', flex: 3),
                    _buildCell('REV NO', flex: 1),
                    _buildCell('-', flex: 1),
                    _buildCell('INS.REPORT NO', flex: 2),
                    _buildCell('', flex: 3),
                  ],
                ),
              ),

              // Fourth data row - MATERIAL, INSP. QTY, NC.QTY
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('MATERIAL', flex: 2),
                    _buildCell('ALUMINIUM', flex: 4),
                    _buildCell('INSP. QTY', flex: 2),
                    _buildCell('4 NOS', flex: 2),
                    _buildCell('NC.QTY', flex: 1),
                    _buildCell('4 NOS', flex: 1),
                  ],
                ),
              ),

              // Fifth data row - NC ITEM ID.NO
              Container(
                height: 35,
                child: Row(children: [_buildCell('NC ITEM ID.NO', flex: 12)]),
              ),

              // Sixth data row - PROCESS SHEET NO, REV NO, CUSTOMER
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('PROCESS SHEET NO', flex: 2),
                    _buildCell('-', flex: 2),
                    _buildCell('REV NO', flex: 1),
                    _buildCell('-', flex: 1),
                    _buildCell('CUSTOMER', flex: 2),
                    _buildCell('AKG INDIA ( P ) LIMITED', flex: 4),
                  ],
                ),
              ),

              // Seventh data row - TYPE INSPECTION
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell('TYPE INSPECTION :', flex: 2),
                    _buildCell('IN HOUSE', flex: 2),
                    _buildCell('BOUGHTOUT', flex: 2),
                    _buildCell('SUB CONTRACT', flex: 2),
                    _buildCell('CUSTOMER COMPLAINT', flex: 4),
                  ],
                ),
              ),

              // Eighth data row - PROCESS STAGE, OPERATION NO
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildCell(
                      'PROCESS STAGE : RAW MATERIAL / PROOF MACHINING /FINAL MACHINING/OTHERS',
                      flex: 10,
                    ),
                    _buildCell('OPERATION NO :', flex: 2),
                  ],
                ),
              ),

              // Images section
              Container(
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                         
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'DEVIATION OBSERVED :',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                           // right: BorderSide(color: Colors.black, width: 1),
                           // bottom: BorderSide(color: Colors.black, width: 1),
                           // left: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Container(
                          child: Center(
                            child: Image(
                              image: NetworkImage(
                                "https://th.bing.com/th/id/R.b2854124f30f2c1b248ba593befe3f75?rik=V7ERbOrjYYDOgw&riu=http%3a%2f%2fgetdrawings.com%2fimage%2fengineering-drawing-59.jpg&ehk=%2fOLWGPhPyWFxtn0CmNnWKLJ%2budg%2fI4HseIlJZYBIgsc%3d&risl=&pid=ImgRaw&r=0",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 25),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                           // right: BorderSide(color: Colors.black, width: 1),
                          //  bottom: BorderSide(color: Colors.black, width: 1),
                           // left: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Container(
                          child: Center(
                            child: Image(
                              image: NetworkImage(
                                "https://th.bing.com/th/id/R.c3d6735ee7fc63e9b1c2446c0898faa1?rik=%2b5njA0Xo4IxOQA&riu=http%3a%2f%2fgetdrawings.com%2fimg2%2ftypes-of-tolerance-in-engineering-drawing-23.jpg&ehk=s1gjC0OsoJkqrWeDEzpiuP6x4wBZtNp9KDKn4MRbbZQ%3d&risl=&pid=ImgRaw&r=0",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
divider1(),
              // Dimension serial no row
              Container(
                height: 35,
                child: Row(
                  children: [_buildCell('DIMENSION SERIAL NO :', flex: 12)],
                ),
              ),

              // Inspector signature row
              Container(
                height: 40,
                child: Row(
                  children: [
                    _buildCell('INSPECTOR NAME', flex: 2),
                    _buildCell('DULAL DUTTA', flex: 3),
                    _buildCell('SIGNATURE', flex: 3),
                    _buildCell('', flex: 2),
                    _buildCell('DATE', flex: 2),
                  ],
                ),
              ),

              // HOD signature row
              Container(
                height: 40,
                child: Row(
                  children: [
                    _buildCell('NAME OF HOD', flex: 2),
                    _buildCell('GANESH', flex: 3),
                    _buildCell('SIGNATURE', flex: 3),
                    _buildCell('', flex: 2),
                    _buildCell('DATE', flex: 2),
                  ],
                ),
              ),

              // Approved by signature row
              Container(
                height: 40,
                child: Row(
                  children: [
                    _buildCell('APPROVED BY', flex: 2),
                    _buildCell('RAJKUMAR', flex: 3),
                    _buildCell('SIGNATURE', flex: 3),
                    _buildCell('', flex: 2),
                    _buildCell('DATE', flex: 2),
                  ],
                ),
              ),

              // Final row - Route cause
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'ROUTE CAUSE : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'CORRECTIVE ACTION : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'PREVENTIVE ACTION : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'DISPOSITION ACTION : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'VERIFICATION ON EFFECTIVENESS OF CORRECTIVE ACTION / PREVENTIVE ACTION : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //signature 
   Container(
                height: 40,
                child: Row(
                  children: [
                    _buildCell('VERIFIED BY (NAME)', flex: 2),
                    _buildCell('', flex: 3),
                    _buildCell('SIGNATURE:', flex: 4),
                    _buildCell('DATE', flex: 1),
                    _buildCell('', flex: 2),
                    
                  ],
                ),
              ),

               Container(
                height: 150,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'REFERENCE FOR VERIFICATION:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

               Container(
                height: 40,
                child: Row(
                  children: [
                    _buildCell('VERIFIED BY (NAME)', flex: 2),
                    _buildCell('', flex: 3),
                    _buildCell('SIGNATURE:', flex: 4),
                    _buildCell('DATE', flex: 1),
                    _buildCell('', flex: 2),
                    
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black, width: 1),
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
