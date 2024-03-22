//%attributes = {"invisible":true}
//Method: SIA_SelectAvailableBIN
//Description
// allow user to choose one of the available BINs for a new record.
// BINs that do not exist in the DB , or where ITEM6A and Item 7 = Other available
// Parameters
// $0: $AvailableBin_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/12/16, 15:44:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
	C_TEXT:C284(SIA_SelectAvailableBIN; $0)
	// Modified by: Costas Manousakis-(Designer)-(12/27/16 11:14:31)
	Mods_2016_12
	//  `do not check for  BINs marked "Other Available", only look for BIN numbers not used
	//  ` this must be re-written so that it saves the new bridge record with the selected BIN and then the semaphore is cleared.
	//  ` Do not allow user to Cancel from selection if there are unused BINs found
	//  ` return a blank only if there are no unused BINs.
	//  ` this method will be called on the on Load event of the  [Bridge MHD NBIS];"BDEPT Input" form
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:17:42)
	Mods_2023_04
	//  `Remove IDLE after Delay process
End if 
//
C_TEXT:C284($0)

ARRAY TEXT:C222($AvailableBINs_atxt; 0)
ARRAY TEXT:C222($otherAvailBINS_atxt; 0)
ARRAY TEXT:C222($Labels_atxt; 0)
While (Semaphore:C143("SIAAVAILBINCHECK"))
	ALERT:C41("Press OK to wait for a minute to check for BIN numbers that are not being used.")
	DELAY PROCESS:C323(Current process:C322; (1*60*60))  //wait 1 minutes
	//IDLE
End while 

SHORT_MESSAGE("Scanning For Unused BINs...")
C_LONGINT:C283($startT_L; $EndT_L)
$startT_L:=Tickcount:C458
ut_MissingBINStoArray(->$AvailableBINs_atxt)
$EndT_L:=Tickcount:C458
$EndT_L:=$EndT_L-$startT_L
If (False:C215)
	//do not check for existing BINs marked as available here
	Begin SQL
		Select [Bridge MHD NBIS].[BIN] from [Bridge MHD NBIS]
		where [Bridge MHD NBIS].[Item6A] like 'OTHER AVAILABLE%'
		and [Bridge MHD NBIS].[Item7] like 'OTHER AVAILABLE%'
		into :$otherAvailBINS_atxt ;
	End SQL
	
End if 
CLOSE WINDOW:C154
ARRAY TEXT:C222($Labels_atxt; Size of array:C274($AvailableBINs_atxt))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($AvailableBINs_atxt))
	$Labels_atxt{$loop_L}:=$AvailableBINs_atxt{$loop_L}+" (missing)"
End for 

SORT ARRAY:C229($AvailableBINs_atxt; >)

C_LONGINT:C283($choise_L)
$choise_L:=-1

Repeat 
	$choise_L:=G_PickFromList(->$Labels_atxt; "Choose BIN from "+String:C10(Size of array:C274($AvailableBINs_atxt))+" available")
	If ($choise_L>0)
	Else 
		ALERT:C41("You must select a BIN from the list!")
	End if 
Until ($choise_L>0)

//save the BIN and the Bridge record
//[Bridge MHD NBIS]BIN:=$AvailableBINs_atxt{$choise_L}
//SAVE RECORD([Bridge MHD NBIS])

CLEAR SEMAPHORE:C144("SIAAVAILBINCHECK")

If ($choise_L>0)
	$0:=$AvailableBINs_atxt{$choise_L}
Else 
	$0:=""
End if 
//End SIA_SelectAvailableBIN