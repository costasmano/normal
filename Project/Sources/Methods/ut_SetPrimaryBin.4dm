//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SetPrimaryBin
// User name (OS): charlesmiller
// Date and time: 03/24/10, 11:18:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_03  //r004 CJ Miller`03/24/10, 11:18:28      `
End if 
START TRANSACTION:C239
READ ONLY:C145(*)
ARRAY DATE:C224($Created_ad; 0)
ARRAY TEXT:C222($Bins_as; 0)  //Command Replaced was o_ARRAY string length was 3
C_TEXT:C284($BDEPT_s)  // Command Replaced was o_C_STRING length was 6
C_LONGINT:C283($Loop_l)
QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
CREATE SET:C116([PRJ_ProjectDetails:115]; "ChangedSet")
For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
	If (ut_LoadRecord(->[PRJ_ProjectDetails:115]; 5))
		$BDEPT_s:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BDEPT_s)
		If (Records in selection:C76([Bridge MHD NBIS:1])>0)
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $Bins_as; [Bridge MHD NBIS:1]DateCreated:192; $Created_ad)
			MULTI SORT ARRAY:C718($Created_ad; <; $Bins_as; >)
			[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=$Bins_as{1}
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			
		End if 
	Else 
		
		
	End if 
	NEXT RECORD:C51([PRJ_ProjectDetails:115])
End for 
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
USE SET:C118("ChangedSet")
QR REPORT:C197([PRJ_ProjectDetails:115]; Char:C90(1))
CONFIRM:C162("Keep Changes"; "Yes"; "Revert")


If (OK=1)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	
End if 
//End ut_SetPrimaryBin