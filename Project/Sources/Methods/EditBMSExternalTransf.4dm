//%attributes = {"invisible":true}
//Method: EditBMSExternalTransf
//Description
// edit the BMSEXternal_transfer record in ServerProcesses
// Parameters
// $1 : if not passed launch a process
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 13:20:29
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	
	C_TEXT:C284(EditBMSExternalTransf; $1)
End if 
//

If (Count parameters:C259=0)
	If (Not:C34(<>fQuit))
		C_LONGINT:C283($Lpid_L)
		
		$Lpid_L:=LSpawnProcess(Current method name:C684; 0; "Edit BMSExternal Rec"; True:C214; False:C215; "run")
	Else 
		ALERT:C41("Application is quiting!!!")
	End if 
Else 
	C_TEXT:C284($1)
	C_LONGINT:C283($FW; $FL; $winID_L)
	QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="BMSExternal_Transfer")
	
	If (Records in selection:C76([ServerProcesses:87])=1)
		
		If (ut_LoadRecordInteractive(->[ServerProcesses:87]))
			FORM SET INPUT:C55([ServerProcesses:87]; "Input")
			C_LONGINT:C283($FW; $FL; $winID_L)
			FORM GET PROPERTIES:C674([ServerProcesses:87]; "Input"; $FW; $FL)
			$winID_L:=Open form window:C675([ServerProcesses:87]; "Input"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			MODIFY RECORD:C57([ServerProcesses:87])
			CLOSE WINDOW:C154($winID_L)
			
		Else 
			ALERT:C41("Could not load record to modify it!")
		End if 
		
	Else 
		ALERT:C41("ServerProcess Record for BMSExternal_Transfer not found!")
	End if 
	
	
End if 

//End EditBMSExternalTransf