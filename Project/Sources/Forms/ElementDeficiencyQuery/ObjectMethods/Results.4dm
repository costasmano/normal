//Method: ElementDeficiencyQuery.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/24/18, 11:35:21
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
If (Records in set:C195("FinalElementSet")=0)
	ALERT:C41("There are no records to be reported on so you can not open window with results")
Else 
	C_LONGINT:C283($PID_L)
	USE SET:C118("FinalElementSet")
	C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $QueryName_txt)
	$NamedSelectionName_txt:="<>LSS_ElementSet"
	$ProcessName_txt:="LSS_Elements"
	$Seq_txt:=String:C10(LNextView($ProcessName_txt)+1)
	$ProcessName_txt:=$ProcessName_txt+" "+$Seq_txt
	$NamedSelectionName_txt:=$NamedSelectionName_txt+"_"+$Seq_txt
	$QueryName_txt:="LSS_ElementQuery"
	COPY NAMED SELECTION:C331([LSS_ElementInspection:163]; $NamedSelectionName_txt)
	
	$PID_L:=New process:C317("LB_ControlListBoxDisplay"; 0; $ProcessName_txt; $QueryName_txt; Table:C252(->[LSS_ElementInspection:163]); "LSS Elements ["+$Seq_txt+"]"; $NamedSelectionName_txt)
End if 
//End ElementDeficiencyQuery.Button