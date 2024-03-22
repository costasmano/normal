//LP [BMS Inspections];"Inspections In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305(vCanned)
C_BOOLEAN:C305(vAddBlank)

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		vCanned:=False:C215
		If ([BMS Inspections:44]Inspection ID:1=0)
			//This is a new record.    
			Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
			[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3
			//      [BMS Inspections]Insp Date:=Current date  `This is set in the date script.
			[BMS Inspections:44]Metric:14:=False:C215  //Change this default after all old inspections are entered.
			TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
			[BMS Inspections:44]Modified By:7:=Current user:C182
			
			//This record must be saved at the beginning to prevent [Cond Units] records
			//from being orphaned by a cancel.
			//Implementing transactions might be a better method.
			SAVE RECORD:C53([BMS Inspections:44])
			
			//Record the log.
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")
			InitChangeStack(1)
			PushChange(1; ->[BMS Inspections:44]Insp Date:4)
			PushChange(1; ->[BMS Inspections:44]Span Group No:3)
			PushChange(1; ->[BMS Inspections:44]DBrInspEngr:5)
			PushChange(1; ->[BMS Inspections:44]Modified By:7)
			PushChange(1; ->[BMS Inspections:44]DateCreated:8)
			PushChange(1; ->[BMS Inspections:44]TimeCreated:9)
			PushChange(1; ->[BMS Inspections:44]Agency:13)
			PushChange(1; ->[BMS Inspections:44]TeamLeader:6)
			
			If (vAddBlank)
				//The user asked for a blank inspection (no elements).
				//Reset this flag; the default is to duplicate the previous inspection.
				vAddBlank:=False:C215
			Else 
				//Duplicate the set of element records for the inspection selected to be copied
				DUPLIC_INSP_NEW
			End if 
			
			//The field Metric may have been updated, so save it.
			SAVE RECORD:C53([BMS Inspections:44])
			PushChange(1; ->[BMS Inspections:44]Metric:14)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
			
		End if 
		
		InitChangeStack(1)
		
		//Team Member scrollable area
		ARRAY INTEGER:C220(aInspTeamID; 0)
		RELATE MANY:C262([BMS Inspections:44])
		SELECTION TO ARRAY:C260([BMS Field Trip:56]Person ID:2; aInspTeamID)
		$j:=Size of array:C274(aInspTeamID)
		ARRAY TEXT:C222(aInspTeam; $j)  //Command Replaced was o_ARRAY string length was 44
		For ($i; 1; $j)
			//Should do this find in entire personnel file, not just current team members.    
			$k:=Find in array:C230(aPeople_ID; aInspTeamID{$i})
			If ($k>0)
				aInspTeam{$i}:=aPeople{$k}
			Else 
				aInspTeam{$i}:="Invalid Person ID"
			End if 
		End for 
		
	: (Form event code:C388=On Validate:K2:3)
		//    TRACE
		If (Modified record:C314([BMS Inspections:44]))
			TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
			[BMS Inspections:44]Modified By:7:=Current user:C182
			If ([BMS Inspections:44]Modified By:7#Old:C35([BMS Inspections:44]Modified By:7))
				PushChange(1; ->[BMS Inspections:44]Modified By:7)
			End if 
			If ([BMS Inspections:44]DateModified:10#Old:C35([BMS Inspections:44]DateModified:10))
				PushChange(1; ->[BMS Inspections:44]DateModified:10)
			End if 
			PushChange(1; ->[BMS Inspections:44]TimeModified:11)
			
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
		End if 
		
End case 

//Select and sort Condition Unit records for this inspection.
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15))
	//TRACE
	
	If ([BMS Inspections:44]Metric:14)
		tbMetric:=1
		tbEnglish:=0
	Else 
		tbMetric:=0
		tbEnglish:=1
	End if 
	
	//This test is necessary because 4D behaves erratically (i.e., deletes an innocent
	//Condition Unit record) when a relate many and sort are performed after a cancel.
	If (vCanned=False:C215)
		DISPL_CUs
	End if 
End if 