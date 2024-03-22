//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/08/11, 14:10:48
//----------------------------------------------------
//Method: ut_LoadRecordonServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//
	//Modified by: Charles Miller (12/8/11 14:10:50)
	
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
	
	Repeat 
		IDLE:C311
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
					IDLE:C311
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


//End ut_LoadRecordonServer