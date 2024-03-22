//Method: BMSExternalClientControl.StartTransferatInterval
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 12:03:25
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	// Modified by: Costas Manousakis-(Designer)-(8/26/20 17:44:06)
	Mods_2020_08_bug
	//  `moved alert after launch
End if 
//
C_LONGINT:C283($Lpid; $LPIDTransf_L)
$Lpid:=LProcessID("Delayed Transfer")
$LPIDTransf_L:=LProcessID("Data Transfer")
If ($LPIDTransf_L>0)
	ALERT:C41("A Data Transfer is already in progress. You should make sure that you set the start time of the Delayed transfer past the expected finish of the current transfer!")
End if 
$Lpid:=LSpawnProcess("ut_DelayDBSynch"; <>LStackSize; "Delayed Transfer"; True:C214; False:C215)
ALERT:C41("Launched Delay transfer process with ID "+String:C10($Lpid))
//End BMSExternalClientControl.StartTransferatInterval