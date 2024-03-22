//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/22/06, 16:10:32
	// ----------------------------------------------------
	// Method: INV_InspDone
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (INV_InventInspLocked)
				CANCEL:C270
				CANCEL TRANSACTION:C241
			Else 
				If (Modified record:C314([InventoryPhotoInsp:112]))
					C_TEXT:C284($msg; $opt1; $opt2; $opt3)
					C_LONGINT:C283($userChoice)  //Command Replaced was o_C_INTEGER
					$msg:="Closing Inventory Photo Inspection"+Char:C90(13)+"Do you want to save the changes you made?"
					If (Is new record:C668([InventoryPhotoInsp:112]))
						$msg:=$msg+Char:C90(13)+"If you Don't save, the new inventory photo inspection will be deleted."
					End if 
					$opt1:="Cancel"
					$opt2:="Don't Save"
					$opt3:="Save"
					$userChoice:=ut_3Option_Confirm($msg; $opt1; $opt2; $opt3)
					
					Case of 
						: ($userChoice=1)
							
						: ($userChoice=2)
							//Canceling transaction gets rid of all related photos
							CANCEL:C270
							CANCEL TRANSACTION:C241
						: ($userChoice=3)
							INV_SaveInvInsp
							ACCEPT:C269
					End case 
					
				Else 
					CANCEL:C270
					CANCEL TRANSACTION:C241
				End if 
		End case 
		
End case 