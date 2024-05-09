//%attributes = {}
//Method: LSS_InitSchedInspDate
//Description
// initialize the Next scheduled inspection date and Cycle values
// for all inventory records
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 27, 2024, 13:45:52
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
End if 
//
//Process all active inventory records, do a custom search, search from structure numbers in clipoboard
C_LONGINT:C283($searchoption_L)
$searchoption_L:=Pop up menu:C542("Process all active;Do a custom search;Search from clipboard")
If ($searchoption_L>0)
	// set to RO because any QUERYs will lock a record
	READ ONLY:C145([LSS_Inventory:165])
	
	C_OBJECT:C1216($Lssinventory_o; $LssRecord_o; $RoutineInsp_o; $lockStatus_o; $damorSpecInsp_o)
	C_COLLECTION:C1488($lockedStructures_c; $NoNextSchedDate_c)
	$lockedStructures_c:=New collection:C1472
	$NoNextSchedDate_c:=New collection:C1472
	
	Case of 
		: ($searchoption_L=1)
			$Lssinventory_o:=ds:C1482.LSS_Inventory.query("LSS_Status_s = :1"; "Active")
			
		: ($searchoption_L=2)
			
			QUERY:C277([LSS_Inventory:165])
			If (OK=1)
				$Lssinventory_o:=Create entity selection:C1512([LSS_Inventory:165])
			Else 
				$Lssinventory_o:=New object:C1471
			End if 
			
		: ($searchoption_L=3)
			C_TEXT:C284($ClipTextCopy)
			$ClipTextCopy:=Get text from pasteboard:C524
			C_TEXT:C284($Delimeter_txt)
			$Delimeter_txt:=Char:C90(Carriage return:K15:38)
			Case of 
				: (Position:C15(Char:C90(9); $ClipTextCopy)>0)
					$Delimeter_txt:=Char:C90(Tab:K15:37)
				: (Position:C15(","; $ClipTextCopy)>0)
					$Delimeter_txt:=","
				: (Position:C15((Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)); $ClipTextCopy)>0)
					$Delimeter_txt:=(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))
				: (Position:C15(Char:C90(Line feed:K15:40); $ClipTextCopy)>0)
					$Delimeter_txt:=Char:C90(Line feed:K15:40)
					
			End case 
			ARRAY TEXT:C222($InventoryKeys_atxt; 0)
			ut_NewTextToArray($ClipTextCopy; ->$InventoryKeys_atxt; $Delimeter_txt)
			QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_StructureNumber_s:6; $InventoryKeys_atxt)
			$Lssinventory_o:=Create entity selection:C1512([LSS_Inventory:165])
			
	End case 
	
	C_LONGINT:C283($Cycle_L; $indx_L)
	$Cycle_L:=Num:C11(ut_GetSysParameter("LSS_DefaultCycle"; "4"))
	$indx_L:=0
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Initializing Cycle and next sched insp date"; $Lssinventory_o.length; True:C214; " anc structure"; 3)
	
	For each ($LssRecord_o; $Lssinventory_o) Until (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
		//update progress
		$indx_L:=$indx_L+1
		UpdateProgressNew($progress_o; $indx_L)
		
		$lockStatus_o:=$LssRecord_o.lock()
		//[LSS_Inspection]LSS_InspectionTypeId_s
		Case of 
			: ($lockStatus_o.success)
				//locked the record
				//change cycle only if it is 0
				
				If ($LssRecord_o.LSS_Cycle_L=0)
					$LssRecord_o.LSS_Cycle_L:=$Cycle_L  // years
				End if 
				
				//find the last initial or routine inspection
				//$RoutineInsp_o:=$LssRecord_o.Link_92_return.query("LSS_InspectionTypeId_s = :1 or LSS_InspectionTypeId_s = :2";"@1";"@2").orderBy("LSS_InspectionDate_d DESC")
				//$RoutineInsp_o:=$LssRecord_o.Link_92_return.query("LSS_InspectionTypeId_s IN :1";"@1;@2").orderBy("LSS_InspectionDate_d DESC")
				$RoutineInsp_o:=$LssRecord_o.Link_92_return.query("LSS_InspectionTypeId_s IN :1 and LSS_InspectionDate_d > :2 "; New collection:C1472("@1"; "@2"); !00-00-00!).orderBy("LSS_InspectionDate_d DESC")
				$damorSpecInsp_o:=$LssRecord_o.Link_92_return.query("LSS_InspectionTypeId_s IN :1"; New collection:C1472("@3"; "@4")).orderBy("LSS_InspectionDate_d DESC")
				//next date is last inps date + cycle years  or year built at 7/1
				Case of 
					: ($RoutineInsp_o.length>0)
						$LssRecord_o.LSS_NextSchedInsp_d:=Add to date:C393($RoutineInsp_o.first().LSS_InspectionDate_d; $LssRecord_o.LSS_Cycle_L; 0; 0)
					: (Num:C11($LssRecord_o.LSS_YearBuilt_s)>0)
						$LssRecord_o.LSS_NextSchedInsp_d:=Date:C102("7/1/"+String:C10(Num:C11($LssRecord_o.LSS_YearBuilt_s)))
					: ($damorSpecInsp_o.length>0)
						$LssRecord_o.LSS_NextSchedInsp_d:=Add to date:C393($damorSpecInsp_o.first().LSS_InspectionDate_d; $LssRecord_o.LSS_Cycle_L; 0; 0)
					Else 
						$NoNextSchedDate_c.push($LssRecord_o.LSS_StructureNumber_s)
				End case 
				$LssRecord_o.save()
				$lockStatus_o:=$LssRecord_o.unlock()
			Else 
				ALERT:C41("Inventory record "+$LssRecord_o.LSS_StructureNumber_s+" could not be loaded for updating\n"+\
					JSON Stringify:C1217($lockStatus_o))
				//save structure number for a later update.
				$lockedStructures_c.push($LssRecord_o.LSS_StructureNumber_s)
		End case 
		
	End for each 
	
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	C_TEXT:C284($lockstructs_txt; $doc_txt)
	C_OBJECT:C1216($file_o)
	$doc_txt:=""
	If ($NoNextSchedDate_c.length>0)
		ALERT:C41("There were "+String:C10($NoNextSchedDate_c.length)+" structures where the next sched insp date could not be set!\n"+\
			"The structure numbers will be placed in a text file!")
		$lockstructs_txt:=$NoNextSchedDate_c.join("\n")
		$doc_txt:=Select document:C905(""; ".txt"; "Choose file to save Str numbers with no next insp date"; File name entry:K24:17)
		If (OK=1)
			$doc_txt:=Document
			$file_o:=File:C1566(Document; fk platform path:K87:2)
			$file_o.setText($lockstructs_txt)
		End if 
	End if 
	
	If ($lockedStructures_c.length>0)
		ALERT:C41("There were "+String:C10($lockedStructures_c.length)+" structures that were locked!\n"+\
			"The structure numbers will be placed in a text file!")
		$lockstructs_txt:=$lockedStructures_c.join("\n")
		$doc_txt:=Select document:C905(""; ".txt"; "Choose file to save locked Str numbers"; File name entry:K24:17)
		If (OK=1)
			$doc_txt:=Document
			$file_o:=File:C1566(Document; fk platform path:K87:2)
			$file_o.setText($lockstructs_txt)
		End if 
	End if 
	
	If ($doc_txt#"")
		//show the last file saved
		SHOW ON DISK:C922($doc_txt)
		
	End if 
End if   // end if searchoption>0

//End LSS_InitSchedInspDate   