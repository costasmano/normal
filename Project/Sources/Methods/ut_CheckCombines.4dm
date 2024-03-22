//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/05, 16:12:21
	// ----------------------------------------------------
	// Method: ut_CheckCombines
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(10/5/2006 11:30:01)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(3/7/11 08:57:26)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
End if 

SHORT_MESSAGE("Please Wait...")
ARRAY TEXT:C222($CombBins_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIBINs_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($BMSBINs_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY LONGINT:C221($CombBMSIDS_aL; 0)
ARRAY LONGINT:C221($CombNBIIDS_aL; 0)
ARRAY LONGINT:C221($CombIDS_aL; 0)
ARRAY LONGINT:C221($NBIIDs_aL; 0)
ARRAY LONGINT:C221($BMSIDs_aL; 0)
ARRAY DATE:C224($Combdates_aD; 0)
ARRAY DATE:C224($NBIDates_aD; 0)
ARRAY DATE:C224($BMSDates_aD; 0)
ARRAY TEXT:C222($CombType_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIType_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIModBy_aS; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($BMSModBy_aS; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($NBIBINID_aS; 0)  //Command Replaced was o_ARRAY string length was 16
ARRAY TEXT:C222($BMSBINID_aS; 0)  //Command Replaced was o_ARRAY string length was 16
SET CURSOR:C469(4)
QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BIN:1#"")
SELECTION TO ARRAY:C260([Combined Inspections:90]BIN:1; $CombBins_aS; [Combined Inspections:90]BMSInspID:3; $CombBMSIDS_aL)
SELECTION TO ARRAY:C260([Combined Inspections:90]NBISInspID:2; $CombNBIIDS_aL; [Combined Inspections:90]InspDate:4; $Combdates_aD)
SELECTION TO ARRAY:C260([Combined Inspections:90]InspType:5; $CombType_aS; [Combined Inspections:90]ID:6; $CombIDS_aL)
REDUCE SELECTION:C351([Combined Inspections:90]; 0)
ALL RECORDS:C47([Inspections:27])
SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $NBIBINs_aS; [Inspections:27]InspID:2; $NBIIDs_aL; [Inspections:27]Insp Date:78; $NBIDates_aD; [Inspections:27]Insp Type:6; $NBIType_aS; [Inspections:27]Modified By:134; $NBIModBy_aS)
REDUCE SELECTION:C351([Inspections:27]; 0)
ALL RECORDS:C47([BMS Inspections:44])
SELECTION TO ARRAY:C260([BMS Inspections:44]BIN:2; $BMSBINs_aS; [BMS Inspections:44]Inspection ID:1; $BMSIDs_aL; [BMS Inspections:44]Insp Date:4; $BMSDates_aD; [BMS Inspections:44]Modified By:7; $BMSModBy_aS)
REDUCE SELECTION:C351([BMS Inspections:44]; 0)

C_LONGINT:C283($NumCombs; $NumNBIs; $NumBMSs; $i; $j; $k)
$NumCombs:=Size of array:C274($CombBins_aS)
$NumNBIs:=Size of array:C274($NBIBINs_aS)
$NumBMSs:=Size of array:C274($BMSBINs_aS)
ARRAY TEXT:C222($NBIBINID_aS; $NumNBIs)  //Command Replaced was o_ARRAY string length was 16
ARRAY TEXT:C222($BMSBINID_aS; $NumBMSs)  //Command Replaced was o_ARRAY string length was 16
For ($i; 1; $NumNBIs)
	$NBIBINID_aS{$i}:=$NBIBINs_aS{$i}+String:C10($NBIIDs_aL{$i})
End for 
For ($i; 1; $NumBMSs)
	$BMSBINID_aS{$i}:=$BMSBINs_aS{$i}+String:C10($BMSIDs_aL{$i})
End for 
ARRAY TEXT:C222($CombBMSBINID_aS; $NumCombs)  //Command Replaced was o_ARRAY string length was 16
ARRAY TEXT:C222($CombNBIBINID_aS; $NumCombs)  //Command Replaced was o_ARRAY string length was 16

For ($i; 1; $NumCombs)
	$CombBMSBINID_aS{$i}:=$CombBins_aS{$i}+String:C10($CombBMSIDS_aL{$i})
	$CombNBIBINID_aS{$i}:=$CombBins_aS{$i}+String:C10($CombNBIIDS_aL{$i})
End for 

CLOSE WINDOW:C154

C_BOOLEAN:C305(vbOnScreenMessage; vbToFileMessage)
ut_StartMessage(3; "CombineCheck")
C_TEXT:C284($MessageOutput_T)
$MessageOutput_T:=Document
C_TEXT:C284($CombBMSBINID_S; $CombNBIBINID_S)  // Command Replaced was o_C_STRING length was 16
For ($i; 1; $NumCombs)
	$CombBMSBINID_S:=$CombBins_aS{$i}+String:C10($CombBMSIDS_aL{$i})
	$CombNBIBINID_S:=$CombBins_aS{$i}+String:C10($CombNBIIDS_aL{$i})
	$k:=0
	$j:=0
	If ($CombBMSIDS_aL{$i}>0)
		$k:=Find in array:C230($BMSBINID_aS; $CombBMSBINID_S)
	End if 
	
	$j:=Find in array:C230($NBIBINID_aS; $CombNBIBINID_S)
	Case of 
		: ($k<0)
			ut_Message("No BMS Match "+$CombBMSBINID_S+"-"+String:C10($CombIDS_aL{$i})+<>sCR)
		: ($k>0)
			If (Abs:C99($BMSDates_aD{$k}-$Combdates_aD{$i})>21)
				ut_Message("Bad BMS date match "+$CombBMSBINID_S+"-"+String:C10($CombIDS_aL{$i})+" : "+String:C10($BMSDates_aD{$k})+"#"+String:C10($Combdates_aD{$i})+<>sCR)
				QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]ID:6=$CombIDS_aL{$i})
				If (Records in selection:C76([Combined Inspections:90])=1)
					READ WRITE:C146([BMS Inspections:44])
					QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
					If (Records in selection:C76([BMS Inspections:44])=1)
						If (Not:C34(Locked:C147([BMS Inspections:44])))
							QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[BMS Inspections:44]BIN:2)
							[BMS Inspections:44]Insp Date:4:=[Combined Inspections:90]InspDate:4
							SAVE RECORD:C53([BMS Inspections:44])
							LogChanges(->[BMS Inspections:44]Insp Date:4; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
							ut_Message("     .... Error Fixed"+<>sCR)
						Else 
							ut_Message("     .... BMS Record Locked!"+<>sCR)
						End if 
					End if 
				End if 
				
			End if 
	End case 
	Case of 
		: ($j<0)
			ut_Message("No NBI Match "+$CombNBIBINID_S+"-"+String:C10($CombIDS_aL{$i})+<>sCR)
		: ($j>0)
			If ($NBIDates_aD{$j}#$Combdates_aD{$i})
				ut_Message("Bad NBI date match "+$CombNBIBINID_S+"-"+String:C10($CombIDS_aL{$i})+" : "+" : "+String:C10($NBIDates_aD{$j})+"#"+String:C10($Combdates_aD{$i})+<>sCR)
			End if 
			If ($NBIType_aS{$j}#$CombType_aS{$i})
				ut_Message("Bad NBI type match "+$CombNBIBINID_S+"-"+String:C10($CombIDS_aL{$i})+" : "+" : "+$NBIType_aS{$j}+"#"+$CombType_aS{$i}+<>sCR)
			End if 
			
	End case 
	
End for 
For ($i; 1; $NumNBIs)
	$k:=Find in array:C230($CombNBIBINID_aS; $NBIBINID_aS{$i})
	If ($k<0)
		ut_Message("Orphan NBI Inspection "+$NBIBINID_aS{$i}+<>sCR)
	End if 
End for 
For ($i; 1; $NumBMSs)
	$k:=Find in array:C230($CombBMSBINID_aS; $BMSBINID_aS{$i})
	If ($k<0)
		ut_Message("Orphan BMS Inspection "+$BMSBINID_aS{$i}+<>sCR)
	End if 
End for 

ut_CloseMessage
ARRAY TEXT:C222($CombBins_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIBINs_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($BMSBINs_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY LONGINT:C221($CombBMSIDS_aL; 0)
ARRAY LONGINT:C221($CombNBIIDS_aL; 0)
ARRAY LONGINT:C221($CombIDS_aL; 0)
ARRAY LONGINT:C221($NBIIDs_aL; 0)
ARRAY LONGINT:C221($BMSIDs_aL; 0)
ARRAY DATE:C224($Combdates_aD; 0)
ARRAY DATE:C224($NBIDates_aD; 0)
ARRAY DATE:C224($BMSDates_aD; 0)
ARRAY TEXT:C222($CombType_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIType_aS; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIModBy_aS; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($BMSModBy_aS; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($NBIBINID_aS; 0)  //Command Replaced was o_ARRAY string length was 16
ARRAY TEXT:C222($BMSBINID_aS; 0)  //Command Replaced was o_ARRAY string length was 16
SET CURSOR:C469(0)
C_TEXT:C284($mypath)
$mypath:=GetPath(Application file:C491)
ut_OpenDocument($mypath+$MessageOutput_T)
