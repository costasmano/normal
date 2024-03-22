//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/04/07, 13:58:21
	// ----------------------------------------------------
	// Method: PRJ_LTR_FHA_fill 
	// Description
	// 
	// PRJ_LTR_FHA_fill ($i;$town;$BDept;$Item7;$Item6;$FirstFileNum)
	// 
	// Parameters
	// $1 : $first_Detail_FINAL_txt
	// ----------------------------------------------------
	
	//Mods_2007_CM12_5301
End if 
C_LONGINT:C283($1; $i; $6; $FirstFileNum)
C_TEXT:C284($2; $town; $3; $BDept; $4; $Item7; $5; $Item6; $7; $Template)
$i:=$1
$FirstFileNum:=$6
$town:=$2
$BDept:=$3
$Item7:=$4
$Item6:=$5
$Template:=$7
Case of 
	: ($Template="WRtemplate_FHA_LTR")
		Case of 
			: ($i=1)
				vAssignmentList:=vAssignmentList+$town+": BRIDGE NO. "+$BDept+Char:C90(13)+<>sTab+<>sTab+<>sTab+$Item7
				vAssignmentList:=vAssignmentList+" OVER "+$Item6+Char:C90(13)
			: ($i>1)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$town+": BRIDGE NO. "+$BDept+Char:C90(13)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$Item7+" OVER "+$Item6+Char:C90(13)
			: ($i=0)
				vAssignmentList:="SUBJECT:"+Char:C90(9)+vAssignmentList
				vAssignmentList:=vAssignmentlist+<>sTab+<>sTab+<>sTab+"Project File No. "+String:C10($FirstFileNum)
				vAssignmentList:=Uppercase:C13(vAssignmentlist)
		End case 
	: ($Template="WRTemplate_TransToFHWAOfPSE_LTR")
		Case of 
			: ($i=1)
				vAssignmentList:=vAssignmentList+$town+", BRIDGE NO. "+$BDept+Char:C90(13)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$Item7+" OVER "+$Item6+Char:C90(13)
			: ($i>1)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$town+", BRIDGE NO. "+$BDept+Char:C90(13)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$Item7+" OVER "+$Item6+Char:C90(13)
			: ($i=0)
				vAssignmentList:="SUBJECT:"+Char:C90(9)+vAssignmentList
				vAssignmentList:=vAssignmentlist+<>sTab+<>sTab+<>sTab+"Project File No. "+String:C10($FirstFileNum)
				vAssignmentList:=Uppercase:C13(vAssignmentList)
		End case 
		
End case 