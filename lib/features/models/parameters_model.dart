class ParameterModel {
final int? id;
final String drawingNumber;
final String parameter;
final String specification;
final String instIdNo;
final String evaluation;


ParameterModel({
this.id,
required this.drawingNumber,
required this.parameter,
required this.specification,
required this.instIdNo,
required this.evaluation,
});


Map<String, dynamic> toMap() => {
'id': id,
'drawing_number': drawingNumber,
'parameter': parameter,
'specification': specification,
'inst_id_no': instIdNo,
'evaluation': evaluation,
};


factory ParameterModel.fromMap(Map<String, dynamic> m) => ParameterModel(
id: m['id'] as int?,
drawingNumber: m['drawing_number'] as String,
parameter: m['parameter'] as String,
specification: m['specification'] as String,
instIdNo: m['inst_id_no'] as String,
evaluation: m['evaluation'] as String,
);
}