//%attributes = {"invisible":true}
//Method: INSP_Data2Inventory
//Description
// Copy data from the inspection record to the inventory record
// this only copies required NBI data - not mass specific items
// meant to be called at the time of completion of the inspection report
// Parameters
// $0 : $OK_b 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/08/17, 14:58:19
	// ----------------------------------------------------
	//Created : 
	Mods_2017_09
	
	// Modified by: Costas Manousakis-(Designer)-(9/26/17 16:51:36)
	Mods_2017_09
	//  `calculate the change stack for the bridge table to be the last one $lastChangeStack_L
	
	C_BOOLEAN:C305(INSP_Data2Inventory; $0)
End if 
//

C_BOOLEAN:C305($0; $OK_b; $RecordLoaded_b; $one_b; $many_b; $Inv_RO_b)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
ARRAY POINTER:C280($FieldsToChange_aptr; 0)
ARRAY POINTER:C280($SourceFields_aptr; 0)
//determine any changes needed - only for MassDOT NBI bridges
If ([Bridge MHD NBIS:1]InspResp:173="DIST@") & [Bridge MHD NBIS:1]FHWARecord:174
	Case of 
		: ([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL")
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item90:161; ->[Inspections:27]Insp Date:78; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			
			If ([Inspections:27]InspRtnSpcMemFlag:209)
				INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item93C:171; ->[Inspections:27]Insp Date:78; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			End if 
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item36A:147; ->[Inspections:27]Railing36:22; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item36B:148; ->[Inspections:27]Transitions36:23; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item36C:149; ->[Inspections:27]ApprGrdRail36:24; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item36D:150; ->[Inspections:27]ApprGdRailEnd36:25; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item41:141; ->[Inspections:27]Item 41:77; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			
			Case of 
				: ([Inspections:27]Insp Type:6="RT@")
					INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item58:130; ->[Inspections:27]Item 58:79; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
					INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item59:131; ->[Inspections:27]Item 59:80; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
					INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item60:132; ->[Inspections:27]Item 60:81; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
					
				: ([Inspections:27]Insp Type:6="CUL")
					INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item62:134; ->[Inspections:27]Item 62:113; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
					
			End case 
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item61:133; ->[Inspections:27]Item 61:82; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			
		: ([Inspections:27]Insp Type:6="FCR")
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item93A:169; ->[Inspections:27]Insp Date:78; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item59:131; ->[Inspections:27]Item 59:80; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item60:132; ->[Inspections:27]Item 60:81; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			
		: ([Inspections:27]Insp Type:6="DVE") | ([Inspections:27]Insp Type:6="DVL")
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item93B:170; ->[Inspections:27]Insp Date:78; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			
		: ([Inspections:27]Insp Type:6="CMI")
			
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item93C:171; ->[Inspections:27]Insp Date:78; ->$FieldsToChange_aptr; ->$SourceFields_aptr)
			
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item58:130; ->[Inspections:27]Item 58:79; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item59:131; ->[Inspections:27]Item 59:80; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item60:132; ->[Inspections:27]Item 60:81; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			INSP_Data2InventoryCheck(->[Bridge MHD NBIS:1]Item62:134; ->[Inspections:27]Item 62:113; ->$FieldsToChange_aptr; ->$SourceFields_aptr; True:C214)
			
	End case 
	
End if 

If (Size of array:C274($FieldsToChange_aptr)>0)
	//there are changes needed - need to load the record
	$Inv_RO_b:=Read only state:C362([Bridge MHD NBIS:1])
	$RecordLoaded_b:=ut_LoadRecordInteractive(->[Bridge MHD NBIS:1])
	If ($RecordLoaded_b)
		C_LONGINT:C283($lastChangeStack_L)
		$lastChangeStack_L:=Size of array:C274(ptr_Changes)+1
		InitChangeStack($lastChangeStack_L)
		C_TEXT:C284($FieldsChange_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($FieldsToChange_aptr))
			($FieldsToChange_aptr{$loop_L})->:=($SourceFields_aptr{$loop_L})->
			$FieldsChange_txt:=$FieldsChange_txt+Field name:C257($FieldsToChange_aptr{$loop_L})+" to "
			
			Case of 
				: (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is alpha field:K8:1) | (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is text:K8:3)
					$FieldsChange_txt:=$FieldsChange_txt+$FieldsToChange_aptr{$loop_L}->
				: (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is integer:K8:5) | (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is real:K8:4) | (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is longint:K8:6)
					$FieldsChange_txt:=$FieldsChange_txt+String:C10($FieldsToChange_aptr{$loop_L}->)
				: (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is date:K8:7)
					$FieldsChange_txt:=$FieldsChange_txt+String:C10($FieldsToChange_aptr{$loop_L}->)
				: (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is time:K8:8)
					$FieldsChange_txt:=$FieldsChange_txt+String:C10($FieldsToChange_aptr{$loop_L}->)
				: (Type:C295($FieldsToChange_aptr{$loop_L}->)=Is boolean:K8:9)
					$FieldsChange_txt:=$FieldsChange_txt+Choose:C955($FieldsToChange_aptr{$loop_L}->; "Y"; "N")
				Else 
					$FieldsChange_txt:=$FieldsChange_txt+"(No text equivalent)"
			End case 
			$FieldsChange_txt:=$FieldsChange_txt+Char:C90(13)
			PushChange($lastChangeStack_L; $FieldsToChange_aptr{$loop_L})
		End for 
		
		If (Modified record:C314([Bridge MHD NBIS:1]))  //probably can be ignored since record has been modified above
			ut_BigAlert($FieldsChange_txt; "List of SIA fields updated")
			If ([Bridge MHD NBIS:1]DateModified:194#Current date:C33(*))
				[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
				PushChange($lastChangeStack_L; ->[Bridge MHD NBIS:1]DateModified:194)
			End if 
			[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
			PushChange($lastChangeStack_L; ->[Bridge MHD NBIS:1]TimeModified:195)
			If ([Bridge MHD NBIS:1]Modified By:191#Current user:C182)
				[Bridge MHD NBIS:1]Modified By:191:=Current user:C182
				PushChange($lastChangeStack_L; ->[Bridge MHD NBIS:1]Modified By:191)
			End if 
			
			FlushGrpChgs($lastChangeStack_L; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
			
		End if 
		
		
		If ($Inv_RO_b)
			//done with inv record - unload and load readonly if it was RO before we started
			UNLOAD RECORD:C212([Bridge MHD NBIS:1])
			READ ONLY:C145([Bridge MHD NBIS:1])
			LOAD RECORD:C52([Bridge MHD NBIS:1])
		End if 
		
		$OK_b:=True:C214
	Else 
		// they can re do this
		$OK_b:=False:C215
		
	End if 
	
	If ($Inv_RO_b)  //reset table to RO
		READ ONLY:C145([Bridge MHD NBIS:1])
	End if 
Else 
	$OK_b:=True:C214
End if 

$0:=$OK_b

SET AUTOMATIC RELATIONS:C310($one_b; $many_b)

//End INSP_Data2Inventory