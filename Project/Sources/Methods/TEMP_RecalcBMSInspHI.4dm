//%attributes = {"invisible":true}
// Method: TEMP_RecalcBMSInspHI
// Description
//  ` Temp utility to calculate the HI Values for past inspections if they have
//  ` not been calculated.  Only Designer can execute this method
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/31/10, 20:57:13
	// ----------------------------------------------------
	
	Mods_2010_02
	// Modified by: Costas Manousakis-(Designer)-(9/28/15 14:49:15)
	Mods_2015_09_bug
	//  `for NBE inspections need to load the [Inspections]  record
	//  `Use a confirm before running the update
End if 
If (Current user:C182="Designer")
	C_DATE:C307($StartDateSearch_d)
	$StartDateSearch_d:=Date:C102(Request:C163("Enter Starting date "; "01/01/2007"))
	If ($StartDateSearch_d#!00-00-00!)
		READ WRITE:C146([BMS Inspections:44])
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>=$StartDateSearch_d)
		QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]INSP_TotV:16=0)
		C_LONGINT:C283($Records_L; $CurrCount_L; $UpdatedRecs_L)
		$Records_L:=Records in selection:C76([BMS Inspections:44])
		$UpdatedRecs_L:=0
		C_BOOLEAN:C305($UpdateHI_b)
		$UpdateHI_b:=False:C215
		If ($Records_L>0)
			CONFIRM:C162("Found "+String:C10($Records_L)+" BMS Inspection records with zero Total Value! Upate the HI for them?"; "Update"; "Cancel")
			$UpdateHI_b:=(OK=1)
		End if 
		If ($UpdateHI_b)
			
			If (Type:C295(ptr_Changes)=Array 2D:K8:24)
			Else 
				ARRAY POINTER:C280(ptr_Changes; 0; 0)
			End if 
			InitChangeStack(1)
			C_LONGINT:C283(<>ProgressPID)
			<>ProgressPID:=StartProgress("BMSHIUpdate"; "Button"; "Updating HI for BMS Inspections")
			UpdateProgress(0; $Records_L)  //Start the progress
			READ ONLY:C145([Combined Inspections:90])
			READ ONLY:C145([Inspections:27])
			FIRST RECORD:C50([BMS Inspections:44])
			While (Not:C34(End selection:C36([BMS Inspections:44])) & Not:C34(<>Abort))
				$CurrCount_L:=Selected record number:C246([BMS Inspections:44])
				UpdateProgress($CurrCount_L; $Records_L)
				//need to load the [inspections] record
				QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BMSInspID:3=[BMS Inspections:44]Inspection ID:1)
				LOAD RECORD:C52([Combined Inspections:90])
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
				LOAD RECORD:C52([Inspections:27])
				INSP_HICalcControl("ALL"; 1)
				If ([BMS Inspections:44]INSP_TotV:16>0)
					//Save only if there were some results
					FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
					SAVE RECORD:C53([BMS Inspections:44])
					$UpdatedRecs_L:=$UpdatedRecs_L+1
				End if 
				NEXT RECORD:C51([BMS Inspections:44])
			End while 
			POST OUTSIDE CALL:C329(<>ProgressPID)
			ALERT:C41("Evaluated "+String:C10($CurrCount_L)+" BMS Inspections.  Updated H.I. for "+String:C10($UpdatedRecs_L)+"!")
		Else 
			ALERT:C41("No Inspections with Missing HI found for date after "+String:C10($StartDateSearch_d))
		End if 
		READ ONLY:C145([BMS Inspections:44])
		UNLOAD RECORD:C212([BMS Inspections:44])
	Else 
		ALERT:C41("Invalid Date entered!  Search canceled!")
	End if 
	
End if 