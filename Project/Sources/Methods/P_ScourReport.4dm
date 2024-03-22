//%attributes = {"invisible":true}
If (False:C215)
	//by: Susie Hwang
	//created: 4/21/2006
	//Mods_2006_SH01
	Mods_2022_05  //Changed code to use Listboxes when available 
	//Modified by: Chuck Miller (5/31/22 16:39:47)
	
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?
C_POINTER:C301(pFile)  //The file that is current
C_TEXT:C284(DefInLay)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(DefOutLay)  // Command Replaced was o_C_STRING length was 255

pFile:=->[Scour Report:129]
DefInLay:="I_ScourReport"  //Default input layout
DefOutLay:="Output"  //Default output layout
C_LONGINT:C283($wO; $HO; $WI; $HI)
FORM GET PROPERTIES:C674([Scour Report:129]; "I_ScourReport"; $wO; $HO)
If (ut_UseListBox(Current method name:C684))
	DefOutLay:=DefOutLay+"_LB"
End if 
FORM GET PROPERTIES:C674([Scour Report:129]; DefOutLay; $WI; $HI)
If ($WI>$wO)
	$wO:=$WI
End if 
If ($HO>$HI)
	$HI:=$HO
End if 
C_BOOLEAN:C305(SC_ScourReportRW_b)

SC_ScourReportRW_b:=(GRP_4DUIDinGroup(<>CurrentUser_UID; "ScourReportRW")>0)

MainTitle:="Bridge Scour Evaluations"
If (Not:C34(SC_ScourReportRW_b))
	READ ONLY:C145([Scour Report:129])
End if 

GModSelection(->[Scour Report:129]; DefInLay; DefOutLay; MainTitle; $wO; $HI; 1; Plain window:K34:13; 3; ->[Scour Report:129]ReportDate:1; "<")