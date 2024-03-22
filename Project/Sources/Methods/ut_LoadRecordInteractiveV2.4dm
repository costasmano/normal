//%attributes = {"invisible":true}
// Method: ut_LoadRecordInteractivev2
// Description
// Will try to load but can allow loading in RO mode
// 
// Parameters
// $0 : $retCode : 0 -cancel 1 - load RW , 2 - load RO
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/14/09, 17:58:23
	// ----------------------------------------------------
	
	Mods_2009_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($0; $retCode)
C_POINTER:C301($1; $TablePointer)
$TablePointer:=$1
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
$retCode:=0

If (Read only state:C362($TablePointer->)=True:C214)
	UNLOAD RECORD:C212($TablePointer->)
	READ WRITE:C146($TablePointer->)
	LOAD RECORD:C52($TablePointer->)
Else 
	LOAD RECORD:C52($TablePointer->)
End if 
C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)
C_LONGINT:C283($Process_i)
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
			C_LONGINT:C283($UserChoise_L)
			$UserChoise_L:=ut_3Option_Confirm($LockMsg_txt; "TryAgain"; "Cancel"; "Open RO")
			Case of 
				: ($UserChoise_L=1)
					LOAD RECORD:C52($TablePointer->)
					If (Locked:C147($TablePointer->))
						SET CURSOR:C469(4)
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322; 120)
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322; 360)
						SET CURSOR:C469(0)
					Else 
						$retCode:=1
						$Complete_b:=True:C214
					End if 
				: ($UserChoise_L=2)
					$Complete_b:=True:C214
					
				: ($UserChoise_L=3)
					$retCode:=2
					$Complete_b:=True:C214
					
			End case 
			
		End if 
		
	Until ($Complete_b=True:C214)
	
Else 
	$retCode:=1
End if 

$0:=$retCode
