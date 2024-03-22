If (False:C215)
	
	//SC vElemNo on layout [Cond Units];"Cond Units In".
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	
	//*** IMPORTANT NOTE ***
	//Although it is considered bad 4D programming to have scripts rely
	//on the order of execution, I was forced to do so here.
	//This script assumes that the scripts for aEnv and aElem execute first.
	//This is controlled by placing them "further back" on the layout.
	//If this placement is modified, erratic results could follow.
	//E.g., GP SETUP_CSs won't have an element number to work with.
	//E.g., changes will not be logged properly
	
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 16:32:42)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(3/2/2006 16:15:40)
	Mods_2006_CM03
End if 

C_LONGINT:C283(vElemNo)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($Text)
C_BOOLEAN:C305(vbInspectionLocked)
C_LONGINT:C283(vCurrentPontisID_L)
C_BOOLEAN:C305(vNewCURecord_b)
REDRAW:C174(aElem)

Case of 
	: (Form event code:C388=On Load:K2:1)
		vNewCURecord_b:=False:C215
		Case of 
			: (([Cond Units:45]Inspection ID:2=0) & (vbInspectionLocked))
				//do nothing        
			: (([Cond Units:45]Inspection ID:2=0) & Not:C34(vbInspectionLocked) & (vCurrentPontisID_L=0))
				//do nothing        
			: ((([Cond Units:45]Inspection ID:2=0) & Not:C34(vbInspectionLocked)) | (Is new record:C668([Cond Units:45])))
				//This is a brand new record.  
				Case of 
					: (Not:C34(Is record loaded:C669([BMS Inspections:44])))
						ALERT:C41("Relation Error while creating new Pontis Element! - No Parent Inspection!")
						CANCEL:C270
					: ([BMS Inspections:44]Inspection ID:1#vCurrentPontisID_L)
						ALERT:C41("Relation Error while creating new Pontis Element! - Mismatched Parent Inspection!")
						CANCEL:C270
					Else 
						vNewCURecord_b:=True:C214
						Inc_Sequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
						[Cond Units:45]Inspection ID:2:=vCurrentPontisID_L
						SAVE RECORD:C53([Cond Units:45])
						//Record the log.
						LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2; "Cond Unit ID")
						//It is assumed that aElem and aEnv have already set Element ID & Environment.
						InitChangeStack(2)
						PushChange(2; ->[Cond Units:45]Element ID:3)
						PushChange(2; ->[Cond Units:45]Environment:4)
						FlushGrpChgs(2; ->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
						InitChangeStack(2)  //reset the stack again
				End case 
				
			Else 
				//This is an existing record.
				InitChangeStack(2)
				//These two if statements will automatically correct an element number or
				//environment inadvertently stored as zero.  This assumes that aElem and aEnv
				//have already set Element ID & Environment.
				If ([Cond Units:45]Element ID:3#Old:C35([Cond Units:45]Element ID:3))
					PushChange(2; ->[Cond Units:45]Element ID:3)
				End if 
				If ([Cond Units:45]Environment:4#Old:C35([Cond Units:45]Environment:4))
					PushChange(2; ->[Cond Units:45]Environment:4)
				End if 
				
		End case 
		
		If ([Cond Units:45]Percent:6)
			rbP:=1
			rbQ:=0
		Else 
			rbP:=0
			rbQ:=1
		End if 
		
		If ([BMS Inspections:44]Metric:14)
			sbMetric:=1
			sbEnglish:=0
		Else 
			sbMetric:=0
			sbEnglish:=1
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		COPY NAMED SELECTION:C331([BMS Elements:47]; "Element")
		QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element No:2=vElemNo)
		If (Records in selection:C76([BMS Elements:47])=0)
			$Text:="'"+String:C10(vElemNo)+"' is not a valid Element Number.  "
			$Text:=$Text+"Try the popup menu on the right."
			ALERT:C41($Text)
			USE NAMED SELECTION:C332("Element")
			vElemNo:=[BMS Elements:47]Element No:2
			//Stay in the same enterable object (vElemNo).
			GOTO OBJECT:C206(vElemNo)
		Else 
			aElem:=Find in array:C230(aElemID; [BMS Elements:47]Element ID:1)
			aElem{0}:=String:C10(aElem)  //Save this choice as the new default.
			[Cond Units:45]Element ID:3:=aElemID{aElem}
			If ([Cond Units:45]Element ID:3#Old:C35([Cond Units:45]Element ID:3))
				PushChange(2; ->[Cond Units:45]Element ID:3)
			End if 
		End if 
		CLEAR NAMED SELECTION:C333("Element")
		SETUP_CSs
End case 