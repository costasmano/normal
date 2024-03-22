//%attributes = {"invisible":true}
If (False:C215)
	//P_ReviewInspcts
	//Look at Pending Inspection Reports
	//
	//Modified 
	//Jun-2002 : Use wildcard for Dive inspections DV@
	Mods_2004_CM11
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(11/22/05 14:36:06)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(3/28/2006 09:13:20)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/11/2006 15:52:44)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(8/31/2006 11:42:10)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(8/29/2007 12:29:56)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/2/2007 10:45:09)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/17/07 11:56:47)
	Mods_2007_CM_5401
	//Use sets instead of arrays to merge inspections
	// Modified by: costasmanousakis-(Designer)-(1/29/08 12:03:57)
	Mods_2008_CM_5402
	//  `Added MTA Insp approval check;
	//  `Modified DCR to use the PERS_Group DCRInspApp.
	// Modified by: costasmanousakis-(Designer)-(5/6/09 11:24:05)
	Mods_2009_05
	//  `Exclude Freeze Thaw inspections for MHD Area Engineers
	// Modified by: costasmanousakis-(Designer)-(1/5/10 11:57:12)
	Mods_2009_12
	//Allowed the DCR to see their old 'Legacy' MDC inspections also.
	// Modified by: costasmanousakis-(Designer)-(2/12/10 13:43:23)
	Mods_2010_02
	//  `Added temporary special case for Mark Griffin
	// Modified by: costasmanousakis-(Designer)-(4/2/10 16:49:44)
	Mods_2010_04
	//  `Exclude  Freeze Thaw inspections that have been approved by DBIE
	// Modified by: costasmanousakis-(Designer)-(4/9/10 10:10:07)
	Mods_2010_04
	//  `Adjusted selection so that old MTA reviewers can review legacy MTA inspections
	// Modified by: costasmanousakis-(Designer)-(6/22/10 08:38:14)
	Mods_2010_06
	//  `Added handling for inspection responsibility for Dist 6
	// Modified by: costasmanousakis-(Designer)-(10/19/10 14:42:40)
	Mods_2010_10
	//Added check to show inspections where current user is the DBIE
	// Modified by: costasmanousakis-(Designer)-(8/25/11 11:11:44)
	Mods_2011_08
	//  `Added special case for Doug Consentino
	// Modified by: costasmanousakis-(Designer)-(10/17/11 11:07:26)
	Mods_2011_10
	//  `Testing new way of getting reviewable inspections
	//  `Also moved declaration of ARRAY STRING(20;aDistrictSelect;0) to the beginning
	// Modified by: costasmanousakis-(Designer)-(10/18/11 10:19:52)
	Mods_2011_10
	//  `Added  ut_TestUser in the testing part
	// Modified by: costasmanousakis-(Designer)-(10/24/11 11:24:15)
	Mods_2011_10
	//Replaced aDistrictSelect InspRespDescSel_atxt
	// Modified by: costasmanousakis-(Designer)-(11/10/11 08:22:24)
	Mods_2011_11
	//  `Enabled the new method of displaying pending inspections
	// Modified by: Costas Manousakis-(Designer)-(3/12/12 14:53:04)
	Mods_2012_03
	//  `Removed the extra code for testing, and the old way of retrieving inspections
	// Modified by: Costas Manousakis-(Designer)-(1/16/13 14:05:57)
	Mods_2013_01
	//  `Added calls to ut_Read_Write_Tables ("READ";.. to set  unneeded tables to RO before opening
	
	Mods_2013_05  //r003 ` Remove rail and tunnel inspection types for engineeers who are not in those groups
	//Modified by: Charles Miller (5/14/13 13:48:37)
	Mods_2019_07  //replace inspection review with a list box 
	//Modified by: Chuck Miller (7/25/19 15:23:20)
	Mods_2020_08  //Changed method of opening window so we would have close box for all from
	//NewWindow to ut_OpenNewWindow 
	//Modified by: CJ (8/11/20 15:55:40)
	// Modified by: Costas Manousakis-(Designer)-(3/17/21 15:39:27)
	Mods_2021_03
	//  `adjusted start window width based on LB form width
End if 

If (False:C215)
	ARRAY LONGINT:C221($aLInspsRevd; 0)
	ARRAY LONGINT:C221($aLInspsByMe; 0)
	ARRAY LONGINT:C221($aLInspsComb; 0)
End if 
ut_TestUser
InitProcessVar
C_BOOLEAN:C305(INSP_OneStepApprove_b)
INSP_OneStepApprove_b:=False:C215
REDUCE SELECTION:C351([Inspections:27]; 0)
pFile:=->[Inspections:27]
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
MainTitle:=""
C_LONGINT:C283(vApproveLvl)  //level of approval for user.
//1 : reviewer DBIE
//2 : final approval
//0 : Nothing
vApproveLvl:=0
C_BOOLEAN:C305(INSP_SelectbyRespNew_b)  //new method of creating the Select by district dropdown
INSP_SelectbyRespNew_b:=False:C215
ARRAY TEXT:C222(InspRespSelect_atxt; 0)
ARRAY TEXT:C222(InspRespDescSel_atxt; 0)


//◊CurrentUser_PID
//Select depending on current user ---
//Underwater only for UOE,
//for DBIEs their districts except underwater
//for area eng their districts (1,2,3 or 4,5) except underwater
//for others allowed to get in here all of the ones they created
//Approval is 2,  Rejected is 1, Not Reviewed yet : 0
C_BOOLEAN:C305(INSP_TESTING_B)
INSP_TESTING_B:=True:C214
SHORT_MESSAGE("Retrieving data. Please wait…")
INSP_InspReviewControl
C_TEXT:C284($InspResps_txt)
$InspResps_txt:=INSP_MyReviewInspections
If ($InspResps_txt="")
	MainTitle:="Pending Inspection Reports"
Else 
	MainTitle:="Pending "+$InspResps_txt+" Inspection Reports"
End if 

ut_Read_Write_Tables("READ"; ->[Bridge MHD NBIS:1]; ->[RAILBridgeInfo:37]; ->[TunnelInfo:151]; ->[BridgeInfoLink:149])
ut_Read_Write_Tables("READ"; ->[Element Cat:32]; ->[ElementDict:30]; ->[Personnel:42]; ->[Inspection Type:31])
ut_Read_Write_Tables("READ"; ->[Common Notes:54]; ->[BMS Categories:49]; ->[CS Notes:53]; ->[BMS Elements:47])
ut_Read_Write_Tables("READ"; ->[Cond States:51]; ->[Cat CS Notes:55]; ->[CS Actions:52]; ->[Element Costs:50]; ->[Environments:48])

RELATE ONE SELECTION:C349([Inspections:27]; [Bridge MHD NBIS:1])
DISTINCT VALUES:C339([Bridge MHD NBIS:1]InspResp:173; InspRespSelect_atxt)
ARRAY TEXT:C222(InspRespDescSel_atxt; Size of array:C274(InspRespSelect_atxt))
C_LONGINT:C283($loop_L; $RespIndx_L)
For ($loop_L; 1; Size of array:C274(InspRespSelect_atxt))
	$RespIndx_L:=Find in array:C230(<>aInspRcod; InspRespSelect_atxt{$loop_L})
	If ($RespIndx_L>0)
		InspRespDescSel_atxt{$loop_L}:=<>aInspRdes{$RespIndx_L}
	Else 
		InspRespDescSel_atxt{$loop_L}:=InspRespSelect_atxt{$loop_L}
	End if 
	
End for 
INSP_SelectbyRespNew_b:=True:C214
vApproveLvl:=<>INSP_MaxApprovalLevel_L

CLOSE WINDOW:C154  //close message window

SET MENU BAR:C67(3)  //load menu bar 3 - blank one. just to have edit (cut copy paste)
FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")  //Changed Dec-2001 from "Inspection"

FORM SET OUTPUT:C54([Inspections:27]; "InspectionReview_LB")

C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10//Mar-2003:added for correctness
$RecSel:=String:C10(Records in selection:C76([Inspections:27]))
COPY NAMED SELECTION:C331([Inspections:27]; "UserRegionA")  //save the selection

UpdatWindArray(""; Current process:C322)
C_LONGINT:C283($win_L; $width; $ht)
FORM GET PROPERTIES:C674([Inspections:27]; "InspectionReview_LB"; $width; $ht)
$win_L:=ut_OpenNewWindow($width; 450; 1; Plain form window:K39:10; MainTitle+"["+$RecSel+"]"; "ut_CloseCancel")

SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
DIALOG:C40([Inspections:27]; "InspectionReview_LB")

CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154