//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/04/07, 14:20:32
	// ----------------------------------------------------
	// Method: PRJ_LTR_RevwCmmt_fill
	// Description
	// PRJ_LTR_RevwCmmt_fill ($i;$town;$BDept;$Item7;$Item6;$FirstFileNum)
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/23/08 16:52:29)
	Mods_2008_CM_5404  //Added bridge no, town, received date
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
	: ($Template="WRtemplate_ReviewComment_LTR")
		C_TEXT:C284(vPRJLTRBridgeNo_txt; vPRJLTRTown_txt; vPRJLTRRecvdDate_txt; vPRJLTRCityTown_txt)
		Case of 
			: ($i=1)
				vAssignmentList:=vAssignmentList+$town+": BRIDGE NO. "+$BDept+" ("+[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34+")"
				vAssignmentList1:=$Item7+" OVER "+$Item6+Char:C90(13)
				vPRJLTRBridgeNo_txt:=$BDept
				vPRJLTRTown_txt:=$town
				vPRJLTRCityTown_txt:=Lowercase:C14(F_GetCityOrTown($town))
				vPRJLTRRecvdDate_txt:=String:C10([PRJ_StructuralReview:119]SR_Received_d:7; Internal date long:K1:5)
			: ($i>1)
				vAssignmentList1:=vAssignmentList1+$town+": BRIDGE NO. "+$BDept+"("+[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34+")"+Char:C90(13)+$Item7+" OVER "+$Item6+Char:C90(13)
				vPRJLTRBridgeNo_txt:=$BDept
				vPRJLTRTown_txt:=$town
				vPRJLTRRecvdDate_txt:=String:C10([PRJ_StructuralReview:119]SR_Received_d:7; Internal date long:K1:5)
				
			: ($i=0)
				vAssignmentList1:=vAssignmentlist1+"Project File No. "+String:C10($FirstFileNum)
				vAssignmentList:=Uppercase:C13(vAssignmentlist)
				vAssignmentList1:=Uppercase:C13(vAssignmentlist1)
		End case 
	: ($Template="WRTemplate_TypeStudyReport_LTR")
		Case of 
			: ($i=1)
				vAssignmentList1:="Bridge No. "+[Bridge MHD NBIS:1]BDEPT:1+", in "+$town
				vAssignmentList:=vAssignmentList+$town+": BRIDGE NO. "+$BDept+Char:C90(13)+<>sTab+<>sTab+<>sTab
				vAssignmentList:=vAssignmentList+$Item7+" OVER "+$Item6+Char:C90(13)
			: ($i>1)
				VAssignmentList1:=vAssignmentList1+", "+"Bridge No. "+[Bridge MHD NBIS:1]BDEPT:1+", in "+$town
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$town+": BRIDGE NO. "+$BDept+Char:C90(13)
				vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+$Item7+" OVER "+$Item6+Char:C90(13)
			: ($i=0)
				vAssignmentList:="SUBJECT:"+Char:C90(9)+vAssignmentList
				vAssignmentList:=vAssignmentlist+<>sTab+<>sTab+<>sTab+"Project File No. "+String:C10($FirstFileNum)
				vAssignmentList:=Uppercase:C13(vAssignmentlist)
		End case 
		
End case 
