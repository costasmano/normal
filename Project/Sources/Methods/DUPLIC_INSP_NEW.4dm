//%attributes = {"invisible":true}
If (False:C215)
	//GP DUPLIC_INSP_NEW
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Duplicate existing, related condition unit records for this new inspection.
	
	//modified Jun-2002 : to pick a BMS inspection to copy by a process variable 
	//   indicating the inspection ID to be copied.
	
	Mods_2005_CM06
	// Modified by: Costas Manousakis-(Designer)-(3/24/15 13:03:14)
	Mods_2015_03
	//  `changed title to say CoRe
End if 

C_BOOLEAN:C305($1; $vbMessagesON)

C_LONGINT:C283($NewInspID; $NoCUs)
C_LONGINT:C283($i; $j; $recs)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_BOOLEAN:C305($metric)

If (Count parameters:C259=1)
	$vbMessagesON:=$1
Else 
	$vbMessagesON:=False:C215
End if 


$NewInspID:=[BMS Inspections:44]Inspection ID:1
$BIN:=[BMS Inspections:44]BIN:2
//save the current inspection --
COPY NAMED SELECTION:C331([BMS Inspections:44]; "New Inspection")
//get the inspection ID to copy from
//vInsptoCopy has been defined in the Duplicate button method
//in form [Bridge MHD NBIS]"Pontis".

QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=vInsptoCopy)
$recs:=Records in selection:C76([BMS Inspections:44])
If ($recs=1)
	$metric:=[BMS Inspections:44]Metric:14
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=vInsptoCopy)
	$NoCUs:=Records in selection:C76([Cond Units:45])
	If ($NoCUs>0)
		COPY NAMED SELECTION:C331([Cond Units:45]; "Cond Units")
		If ($vbMessagesON)
			MESSAGE:C88(<>sCR+"   Copying "+String:C10($NoCUs)+" Pontis CoRe Elements...")
		End if 
		
		For ($i; 1; $NoCUs)
			If ($vbMessagesON)
				MESSAGE:C88(String:C10($i)+"...")
			End if 
			DUPLICATE RECORD:C225([Cond Units:45])
			[Cond Units:45]Cond Unit ID:1:=0  //This must be zero for Inc_Sequence.
			Inc_Sequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
			//      $NewCUID:=[Cond Units]Cond Unit ID
			[Cond Units:45]Inspection ID:2:=$NewInspID
			SAVE RECORD:C53([Cond Units:45])
			LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2; "Cond Unit ID")
			InitChangeStack(2)
			PushChange(2; ->[Cond Units:45]Element ID:3)
			PushChange(2; ->[Cond Units:45]Environment:4)
			PushChange(2; ->[Cond Units:45]Total Quantity:5)
			If ([Cond Units:45]Percent:6)
				PushChange(2; ->[Cond Units:45]Percent:6)
			End if 
			For ($j; 1; vMaxCSs)
				If (a_ptr_CSfld{$j}->#0)
					PushChange(2; a_ptr_CSfld{$j})
				End if 
			End for 
			If ([Cond Units:45]Comment:7#"")
				PushChange(2; ->[Cond Units:45]Comment:7)
			End if 
			FlushGrpChgs(2; ->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
			
			USE NAMED SELECTION:C332("Cond Units")
			NEXT RECORD:C51([Cond Units:45])
			COPY NAMED SELECTION:C331([Cond Units:45]; "Cond Units")
		End for 
		CLEAR NAMED SELECTION:C333("Cond Units")
	End if 
Else 
	If ($recs<1)
		ALERT:C41("Error : Could not find Inspection ID "+String:C10(vInsptoCopy))
	Else 
		ALERT:C41("Error : Duplicate Inspections found for Inspection ID "+String:C10(vInsptoCopy))
	End if 
End if 
USE NAMED SELECTION:C332("New Inspection")
CLEAR NAMED SELECTION:C333("New Inspection")
If ($recs=1)
	//Use the previous setting for this new inspection too.
	[BMS Inspections:44]Metric:14:=$metric
End if 