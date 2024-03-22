//%attributes = {"invisible":true}
// Method: ut_LoadRecordInteractive
// Description
//  ` Copy and adjusted from ut_LoadRecord
// will keep trying to load until user cancels. 
// Parameters
// $0 : $RecordLoaded_b
// $1 : $TablePointer
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/14/07, 09:33:52
	// ----------------------------------------------------
	
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 09:38:31)
	Mods_2007_CM08
	// Modified by: costasmanousakis-(Designer)-(11/18/07 20:21:09)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(4/10/09 11:01:13)
	Mods_2009_04
	//Added delimiters [] around table name. user, processes;
	//Also check for deleted record!
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2023-04-10 13:45:06)
	Mods_2023_04
	//  `use only one delay process command instead of two
End if 
C_BOOLEAN:C305($0; $RecordLoaded_b)
$RecordLoaded_b:=False:C215
C_POINTER:C301($1; $TablePointer)
$TablePointer:=$1
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215

If (Read only state:C362($TablePointer->)=True:C214)
	UNLOAD RECORD:C212($TablePointer->)
	READ WRITE:C146($TablePointer->)
	LOAD RECORD:C52($TablePointer->)
Else 
	LOAD RECORD:C52($TablePointer->)
End if 
C_LONGINT:C283($Process_i)
C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)
If (Locked:C147($TablePointer->))
	C_TEXT:C284($LockMsg_txt)
	Repeat 
		LOCKED BY:C353($TablePointer->; $Process_i; $User_txt; $Machine_txt; $ProcessName_txt)
		If ($Process_i=-1)
			ALERT:C41("Requested record in table ["+Table name:C256($TablePointer)+"] has been deleted!")
			$Complete_b:=True:C214
		Else 
			If ($User_txt="")
				$LockMsg_txt:="Required record in table ["+Table name:C256($TablePointer)
				$LockMsg_txt:=$LockMsg_txt+"] is Locked in your process ["+$ProcessName_txt+"]"+<>sCR
			Else 
				$LockMsg_txt:="Required record in table ["+Table name:C256($TablePointer)
				$LockMsg_txt:=$LockMsg_txt+"] is Locked by "+$User_txt+" on machine ["+$Machine_txt
				$LockMsg_txt:=$LockMsg_txt+"] in process ["+$ProcessName_txt+"]"+<>sCR
			End if 
			$LockMsg_txt:=$LockMsg_txt+"Wait 5 seconds and try again?"
			G_MyConfirm($LockMsg_txt; "TryAgain"; "Cancel")
			If (OK=1)
				LOAD RECORD:C52($TablePointer->)
				If (Locked:C147($TablePointer->))
					SET CURSOR:C469(4)
					IDLE:C311
					DELAY PROCESS:C323(Current process:C322; 480)
					SET CURSOR:C469(0)
				Else 
					$RecordLoaded_b:=True:C214
					$Complete_b:=True:C214
				End if 
			Else 
				$Complete_b:=True:C214
			End if 
			
		End if 
		
	Until ($Complete_b=True:C214)
	
Else 
	$RecordLoaded_b:=True:C214
End if 
$0:=$RecordLoaded_b