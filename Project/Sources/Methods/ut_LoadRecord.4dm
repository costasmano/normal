//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_LoadRecord
// User name (OS): cjmiller
// Date and time: 07/29/04, 11:57:06
// ----------------------------------------------------
// Description
// This method will repeatedly try and load records
//It can never not load record as updates can not occur until loaded and we caan n

// Parameters
//$1 pointer to table
//$2 if it exists the number of times to try and load record
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:45:47      ` Type all local variables for v11
	// Modified by: CJ Miller-(Designer)-(11/5/13 16:39:35)
	Mods_2013_11
	//  `don't show message if running on server
	// Modified by: Costas Manousakis-(Designer)-(3/18/21 14:33:33)
	Mods_2021_03
	//  `added process name and number to the message
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:46:12)
	Mods_2023_04
	//  `remove IDLE before Delay process
End if 
C_BOOLEAN:C305($0; $RecordLoaded_b)
$RecordLoaded_b:=False:C215
C_POINTER:C301($1; $TablePointer)
$TablePointer:=$1
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
C_LONGINT:C283($NumberOfTrys_l; $HaveTried_l)
$NumberOfTrys_l:=0
$HaveTried_l:=0
If (Count parameters:C259=2)
	C_LONGINT:C283($2)
	$NumberOfTrys_l:=$2
End if 


If (Read only state:C362($TablePointer->)=True:C214)
	UNLOAD RECORD:C212($TablePointer->)
	READ WRITE:C146($TablePointer->)
	LOAD RECORD:C52($TablePointer->)
Else 
	LOAD RECORD:C52($TablePointer->)
End if 

If (Locked:C147($TablePointer->))
	C_LONGINT:C283($Process_i)
	C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)
	LOCKED BY:C353($TablePointer->; $Process_i; $User_txt; $Machine_txt; $ProcessName_txt)
	If (Application type:C494=4D Server:K5:6)
	Else 
		GOTO XY:C161(5; 11)
		MESSAGE:C88(Table name:C256($TablePointer)+" Locked by "+$User_txt+" on machine "+$Machine_txt+\
			" in process "+$ProcessName_txt+" process number "+String:C10($Process_i))
	End if 
	Repeat 
		//IDLE
		DELAY PROCESS:C323(Current process:C322; 120)
		LOAD RECORD:C52($TablePointer->)
		
		If (Locked:C147($TablePointer->)=False:C215)
			$RecordLoaded_b:=True:C214
			$Complete_b:=True:C214
		End if 
		If ($NumberOfTrys_l>0)
			If ($Complete_b=False:C215)
				$HaveTried_l:=$HaveTried_l+1
				If ($HaveTried_l>$NumberOfTrys_l)
					$Complete_b:=True:C214
				Else 
					//IDLE
					DELAY PROCESS:C323(Current process:C322; 360)  //delay one second
				End if 
			End if 
		Else 
		End if 
	Until ($Complete_b=True:C214)
Else 
	$RecordLoaded_b:=True:C214
End if 
$0:=$RecordLoaded_b


//End ut_LoadRecordWithNoEnd