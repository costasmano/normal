//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: LSet2ReadWrite(pointer;boolean)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$0-1=READ ONLY 0=READ WRITE  -1=Record deleted or user canceled
	//$1 - pointer to file to set to read write
	//$2 - boolean - let user cancel out if desired
	
	//Purpose:   Sets files to read write and loads record
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_POINTER:C301($1; $pFile)
C_BOOLEAN:C305($2; $fReadOnly; $fAskUser)
C_LONGINT:C283($0; $LProcess; $OK)
C_TEXT:C284($sUser; $sMachine; $sName)  // Command Replaced was o_C_STRING length was 40

$pFile:=$1
$fAskUser:=$2
$fReadOnly:=Read only state:C362($pFile->)  //Return state to restore
$0:=Num:C11($fReadOnly=True:C214)

If ($0=1)
	UNLOAD RECORD:C212($pFile->)
	READ WRITE:C146($pFile->)
	LOAD RECORD:C52($pFile->)
End if 
$OK:=1

While (Locked:C147($pFile->) & ($OK=1))
	LOCKED BY:C353($pFile->; $LProcess; $sUser; $sMachine; $sName)
	
	If ($LProcess=-1)  //The record has been deleted
		If ($fAskUser)  //if not asking user probably the ALERT will lock things up
			ALERT:C41("The record has been deleted in the meantime.")
		End if 
		$0:=-1
		$OK:=0
		
	Else 
		
		If ($fAskUser)  //let the user cancel out if they want
			If ($sUser="")
				$sUser:="you"
			End if 
			CONFIRM:C162("The record is already used by "+$sUser+" in the process "+$sName+"."+<>sCR+"Do you want to wait?")
			If (OK=1)
				$fAskUser:=False:C215  //Set the flag so we don't keep asking
			Else 
				$0:=-1
				$OK:=-1
			End if 
		End if 
		
		If (OK=1)
			UNLOAD RECORD:C212($pFile->)
			DELAY PROCESS:C323(Current process:C322; 120)  //Wait two seconds
			LOAD RECORD:C52($pFile->)
		End if 
		
	End if   //$LProcess >0
End while 

If (($fReadOnly) & ($0=-1))  //	Restore file to read only if there was a problem
	UNLOAD RECORD:C212($pFile->)
	READ ONLY:C145($pFile->)
	If ($LProcess#-1)
		UNLOAD RECORD:C212($pFile->)
	End if 
End if 
//End of procedure 