//%attributes = {"invisible":true}
// ----------------------------------------------------
// SR_ControlQuarterlyPrint
// User name (OS): charlesmiller
// Date and time: 12/10/09, 17:10:06
// ----------------------------------------------------
// Description
// Add this to button on output form to print
//
// Parameters
//$1 pass in Out or IN. Not passed in will default to output (Many records)
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r001 CJ Miller`12/10/09, 17:07:20     `Integrate new status report
	Mods_2009_12  // r001 CJ Miller`12/17/09, 10:56:29        `Make changes to new status report
	//Allow for calling from input and output methods
End if 

C_TEXT:C284($Selection_txt)
$Selection_txt:="OUT"
If (Count parameters:C259=1)
	C_TEXT:C284($1)
	$Selection_txt:=$1
End if 
ARRAY LONGINT:C221($RecordNumbers_al; 0)
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
Case of 
	: ($Selection_txt="O@")
		ARRAY LONGINT:C221($RecordNumbers_al; Records in selection:C76([Status Report:69]))
		SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([Status Report:69]); [Status Report:69]; $RecordNumbers_al)
		
	: ($Selection_txt="I@")
		ARRAY LONGINT:C221($RecordNumbers_al; 1)
		$RecordNumbers_al{1}:=Record number:C243([Status Report:69])
		
	Else 
		$Continue_b:=False:C215
		ALERT:C41("Incorrect parameter pass in - Must be OUT or IN. "+$Selection_txt+" was passed in.")
End case 

If ($Continue_b)
	
	SR_ProcessQuarterly(->$RecordNumbers_al)
	
End if 
//End SR_ControlQuarterlyPrint