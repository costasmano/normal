//%attributes = {"invisible":true}
C_LONGINT:C283(vmaxW; vmaxH)
C_TEXT:C284(vsMAxW; vsMAxH)  //<--- Added// Command Replaced was o_C_STRING length was 80
vmaxW:=0
vmaxH:=0
vsMAxW:=""
vsMAxH:=""
Test_FunGetaxFormDims(->[Inspections:27]; "Damage Form")
Test_FunGetaxFormDims(->[Inspections:27]; "Closed Bridge")
Test_FunGetaxFormDims(->[Inspections:27]; "Underwater Special Member")
Test_FunGetaxFormDims(->[Inspections:27]; "Dive LowCl")
Test_FunGetaxFormDims(->[Inspections:27]; "Dive Form")
Test_FunGetaxFormDims(->[Inspections:27]; "Culvert Form")
Test_FunGetaxFormDims(->[Inspections:27]; "Critical Member")
Test_FunGetaxFormDims(->[Inspections:27]; "Routine Form")
//Test_FunGetaxFormDims (->[Bridge Design];"Bridge Design In")
Test_FunGetaxFormDims(->[BMS Inspections:44]; "Inspections In")
Test_FunGetaxFormDims(->[Bridge MHD NBIS:1]; "SI & A Input")
Test_FunGetaxFormDims(->[Conslt Rating:63]; "Cslt Rating In")
Test_FunGetaxFormDims(->[Cons Inspection:64]; "Cslt Insp In")
Test_FunGetaxFormDims(->[NBIS Secondary:3]; "2nd In")
Test_FunGetaxFormDims(->[RatingReports:65]; "RatReportsIn")
Test_FunGetaxFormDims(->[Bridge MHD NBIS:1]; "BDEPT Input")
Test_FunGetaxFormDims(->[Bridge MHD NBIS:1]; "ID Input")
Test_FunGetaxFormDims(->[Bridge MHD NBIS:1]; "Other Info")

ALERT:C41("Max w = "+String:C10(vmaxW)+" "+vsMAxW+"  -Height="+String:C10(vmaxH)+" "+vsMAxH)