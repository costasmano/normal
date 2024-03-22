//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/07, 16:48:48
	// ----------------------------------------------------
	// Method: PRJ_LTR_PSEAPP_fill
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($1; $i; $6; $FirstFileNum)
C_TEXT:C284($2; $town; $3; $BDept; $4; $Item7; $5; $Item6)
$i:=$1
$FirstFileNum:=$6
$town:=$2
$BDept:=$3
$Item7:=$4
$Item6:=$5
Case of 
	: ($i=1)
		vAssignmentList:=vAssignmentList+$town+":"+<>sTab+"BRIDGE NO. "+$BDept+Char:C90(13)+<>sTab+<>sTab+<>sTab+$Item7
		vAssignmentList:=vAssignmentList+" OVER "+$Item6+Char:C90(13)
	: ($i>1)
		vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+"BRIDGE NO. "+$BDept+Char:C90(13)
		vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$Item7+" OVER "+$Item6+Char:C90(13)
	: ($i=0)
		vAssignmentList:=vAssignmentlist+<>sTab+<>sTab+<>sTab+"PS&E"+Char:C90(13)
		vAssignmentList:=vAssignmentlist+<>sTab+<>sTab+<>sTab+"Project File No. "+String:C10($FirstFileNum)
End case 