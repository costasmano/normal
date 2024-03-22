//%attributes = {"invisible":true}
//Method: LSS_CheckForSave
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/06/18, 13:27:33
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03_bug
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:11:53)
	Mods_2023_04
	//  `Removed IDLE after delay process
End if 
//
C_BOOLEAN:C305($WaitMsg_b)


$WaitMsg_b:=True:C214
C_LONGINT:C283($Count_L)
C_TIME:C306($E_tm; $S_tm)
$S_tm:=Current time:C178
LSS_InventorySemaphore_txt:=[LSS_Inventory:165]LSS_Route_s:9+"-"+[LSS_Inventory:165]LSS_InventoryType_s:28+"-"+String:C10([LSS_Inventory:165]LSS_District_L:3; "00")
While (Semaphore:C143(LSS_InventorySemaphore_txt))  //so only one add to inventory operation at a time can be done
	
	If ($WaitMsg_b)
		ALERT:C41("Will have to wait for other save inventory item process to end first!")
	Else 
		$Count_L:=$Count_L+1
		If ($Count_L>20)
			$E_tm:=Current time:C178
			ALERT:C41("Still waiting!  If you see this message twice notify MADOT BMS Support as elapsed time is "+String:C10($E_tm-$S_tm)+" for "+[LSS_Inventory:165]LSS_Route_s:9+"-"+[LSS_Inventory:165]LSS_InventoryType_s:28+"-"+String:C10([LSS_Inventory:165]LSS_District_L:3; "00"))
			$Count_L:=0
		End if 
	End if 
	$WaitMsg_b:=False:C215
	DELAY PROCESS:C323(Current process:C322; 120)
	//IDLE
End while 
//End LSS_CheckForSave