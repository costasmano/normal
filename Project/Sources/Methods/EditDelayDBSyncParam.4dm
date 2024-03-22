//%attributes = {"invisible":true}
//Method: EditDelayDBSyncParam
//Description
// Ediy yhe DelayDBSync parameter record
// Parameters
// $1 : if not passed launch a process
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 16:26:34
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	C_TEXT:C284(EditDelayDBSyncParam; $1)
	
End if 
//

If (Count parameters:C259=0)
	If (Not:C34(<>fQuit))
		C_LONGINT:C283($Lpid_L)
		
		$Lpid_L:=LSpawnProcess(Current method name:C684; 0; "Edit DelayDBSync Rec"; True:C214; False:C215; "run")
	Else 
		ALERT:C41("Application is quiting!!!")
	End if 
Else 
	C_TEXT:C284($1)
	C_LONGINT:C283($FW; $FL; $winID_L)
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="DelayDBSyncParam")
	
	If (Records in selection:C76([Parameters:107])=1)
		
		If (ut_LoadRecordInteractive(->[Parameters:107]))
			C_LONGINT:C283($FW; $FL; $winID_L)
			FORM GET PROPERTIES:C674([Parameters:107]; "Input"; $FW; $FL)
			$winID_L:=Open form window:C675([Parameters:107]; "Input"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			FORM SET INPUT:C55([Parameters:107]; "Input")
			MODIFY RECORD:C57([Parameters:107])
			CLOSE WINDOW:C154($winID_L)
			
		Else 
			ALERT:C41("Could not load record to modify it!")
		End if 
		
	Else 
		ALERT:C41("Parameter Record for DelayDBSyncParam not found!")
	End if 
	
End if 

//End EditDelayDBSyncParam