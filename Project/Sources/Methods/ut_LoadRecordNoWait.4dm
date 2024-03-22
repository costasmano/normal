//%attributes = {"invisible":true}
//Method: ut_LoadRecordNoWait
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/16/19, 15:09:29
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05  //New method so if we do not want to wait
	Compiler_Utilities
End if 
//
C_BOOLEAN:C305($0; $RecordLoaded_b)
$RecordLoaded_b:=False:C215
C_POINTER:C301($1; $TablePointer)
$TablePointer:=$1
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
C_LONGINT:C283($NumberOfTrys_l; $HaveTried_l)
$NumberOfTrys_l:=0
$HaveTried_l:=0



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
		MESSAGE:C88(Table name:C256($TablePointer)+" Locked by "+$User_txt+" on machine "+$Machine_txt)
		DELAY PROCESS:C323(Current process:C322; 15)
	End if 
	Repeat 
		
		If (Locked:C147($TablePointer->)=False:C215)
			$RecordLoaded_b:=True:C214
			$Complete_b:=True:C214
		Else 
			$RecordLoaded_b:=False:C215
			$Complete_b:=True:C214
		End if 
		
	Until ($Complete_b=True:C214)
Else 
	$RecordLoaded_b:=True:C214
End if 
$0:=$RecordLoaded_b
//End ut_LoadRecordNoWait