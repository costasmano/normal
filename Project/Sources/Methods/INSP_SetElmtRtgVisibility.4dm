//%attributes = {"invisible":true}
//Method: INSP_SetElmtRtgVisibility
//Description
//  `Set the visibility of load rating fields and add if needed a record for [ElmtRatingLoads]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/15/14, 15:24:07
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
	// Modified by: Costas Manousakis-(Designer)-(10/26/15 13:34:48)
	Mods_2015_10_bug
	//  `Create a [ElmtRatingLoads] record only if the table is not in READ only
End if 
//
C_TEXT:C284(INSP_RevenueINPLbl_txt; INSP_WorkCarINPLbl_txt)

C_BOOLEAN:C305($CheckElmLoads_b)
$CheckElmLoads_b:=False:C215
OBJECT SET VISIBLE:C603(*; "@loadrating@"; False:C215)
Case of 
	: (INSP_MBTABridgeType_txt="Commuter")
		OBJECT SET VISIBLE:C603(*; "@MBTComm@"; True:C214)
		$CheckElmLoads_b:=True:C214
	: (INSP_MBTABridgeType_txt="Highway")
		OBJECT SET VISIBLE:C603(*; "@MBTHigh@"; True:C214)
		$CheckElmLoads_b:=True:C214
	: (INSP_MBTABridgeType_txt="Transit")
		OBJECT SET VISIBLE:C603(*; "@MBTTrans@"; True:C214)
		$CheckElmLoads_b:=True:C214
	Else 
		OBJECT SET VISIBLE:C603(*; "@Default@"; True:C214)
		
End case 

If ($CheckElmLoads_b)
	
	If (Is record loaded:C669([ElmtRatingLoads:158]) & ([ElmtRatingLoads:158]ElmSafetyID:2=[ElementsSafety:29]ElmSafetyID:7))
		
	Else 
		QUERY:C277([ElmtRatingLoads:158]; [ElmtRatingLoads:158]ElmSafetyID:2=[ElementsSafety:29]ElmSafetyID:7)
		If (Not:C34(Read only state:C362([ElmtRatingLoads:158])))
			If (Records in selection:C76([ElmtRatingLoads:158])=0)
				CREATE RECORD:C68([ElmtRatingLoads:158])
				[ElmtRatingLoads:158]ElmSafetyID:2:=[ElementsSafety:29]ElmSafetyID:7
				Inc_Sequence("ElmtRatingLoads"; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
				SAVE RECORD:C53([ElmtRatingLoads:158])
				LogNewRecord(->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2; "ElmtRatingLoads")
			End if 
			
		End if 
		
	End if 
	C_TEXT:C284($RevCarDesc_txt; $workCarDesc_txt; $OtherElmtRev_txt; $OtherElmtWork_txt)
	$RevCarDesc_txt:=""
	$workCarDesc_txt:=""
	
	If (Is record loaded:C669([RAILBridgeInfo:37]))
		$workCarDesc_txt:=Uppercase:C13([RAILBridgeInfo:37]Rating_WorkCar_desc_s:40)
		$RevCarDesc_txt:=Uppercase:C13([RAILBridgeInfo:37]Rating_RevCar_desc_s:30)
	End if 
	
	If (($RevCarDesc_txt#"") & ([Inspections:27]Rating_RevCar_desc_s:220=""))
		[Inspections:27]Rating_RevCar_desc_s:220:=$RevCarDesc_txt
		PushChange(1; ->[Inspections:27]Rating_RevCar_desc_s:220)
		
	End if 
	If (($workCarDesc_txt#"") & ([Inspections:27]Rating_WorkCar_desc_s:219=""))
		[Inspections:27]Rating_WorkCar_desc_s:219:=$workCarDesc_txt
		PushChange(1; ->[Inspections:27]Rating_WorkCar_desc_s:219)
		
	End if 
	
End if 

//End INSP_SetElmtRtgVisibility