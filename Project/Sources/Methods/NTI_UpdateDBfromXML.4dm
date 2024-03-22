//%attributes = {"invisible":true}
//Method: NTI_UpdateDBfromXML
//Description
// Update the database from XML Files. if xml trees are passed, both must be passed
// Parameters
// $0: $UpdateOK_b
// $1 : $NTI_DEFECT_ELEM_TREE (optional)
// $2 : $NTI_DEFECT_LANG_TREE (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/04/18, 12:37:37
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	
	C_BOOLEAN:C305(NTI_UpdateDBfromXML; $0)
	C_TEXT:C284(NTI_UpdateDBfromXML; $1)
	C_TEXT:C284(NTI_UpdateDBfromXML; $2)
	C_TEXT:C284(NTI_UpdateDBfromXML; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	
End if 
//

C_TEXT:C284($NTI_DEFECT_ELEM_TREE; $NTI_DEFECT_LANG_TREE)

C_BOOLEAN:C305($0; $Updated_b; $UpdateDefElem_b; $UpdateDefectLan_b)
$Updated_b:=False:C215
$UpdateDefElem_b:=False:C215
$UpdateDefectLan_b:=False:C215

If (Count parameters:C259>0)
	$NTI_DEFECT_ELEM_TREE:=$1
	$NTI_DEFECT_LANG_TREE:=$2
Else 
	CONFIRM:C162("Use Element defect tree in resources or choose a file?"; "Resources"; "File")
	C_TEXT:C284($File_txt)
	C_LONGINT:C283($DefFolder_L)
	$DefFolder_L:=5
	If (OK=1)
		$NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
	Else 
		$File_txt:=Select document:C905($DefFolder_L; ".xml"; "Select an Element_defect tree xml file"; 0)
		$NTI_DEFECT_ELEM_TREE:=DOM Parse XML source:C719(Document)
	End if 
	CONFIRM:C162("Use Defect Language tree in resources or choose a file?"; "Resources"; "File")
	
	If (OK=1)
		$NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
	Else 
		$File_txt:=Select document:C905($DefFolder_L; ".xml"; "Select a Defect language tree xml file"; 0)
		$NTI_DEFECT_LANG_TREE:=DOM Parse XML source:C719(Document)
	End if 
	
End if 

C_TEXT:C284($defectRef_txt; $stateRef_txt; $ElemRef_txt; $ElemCategory_txt; $ElemName_txt)
C_TEXT:C284($Errors_txt)
C_LONGINT:C283($loop_L; $defectVal_L; $ElemVal_L)
C_TEXT:C284($lastOnErr_txt; $ElemName_txt)
ARRAY TEXT:C222($Messages_atxt; 0)
$lastOnErr_txt:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")
C_LONGINT:C283($loop_L)

ARRAY TEXT:C222($DefectRefs_atxt; 0)
$defectRef_txt:=DOM Find XML element:C864($NTI_DEFECT_LANG_TREE; "NTIDEFECTLANG/Defect"; $DefectRefs_atxt)

If (Size of array:C274($DefectRefs_atxt)=0)
	ALERT:C41("There were no Defect Language elements in the XML!")
Else 
	For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
		DOM GET XML ATTRIBUTE BY NAME:C728($DefectRefs_atxt{$loop_L}; "Name"; $ElemName_txt)
		
		ARRAY TEXT:C222($StateRefs_atxt; 0)
		$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
		
		C_TEXT:C284($State_lang_txt; $DefectNotes_txt)
		C_LONGINT:C283($loop2_L; $state_L)
		ARRAY TEXT:C222($StateLang_atxt; 4)
		
		For ($loop2_L; 1; 4)
			$StateLang_atxt{$loop2_L}:=""
		End for 
		
		For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
			DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $State_lang_txt)
			$StateLang_atxt{$state_L}:=$State_lang_txt
		End for 
		$DefectNotes_txt:=""
		For ($loop2_L; 1; 4)
			$DefectNotes_txt:=$DefectNotes_txt+"<CS"+String:C10($loop2_L)+">"+$StateLang_atxt{$loop2_L}+"</CS"+String:C10($loop2_L)+">"
		End for 
		
		QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$defectVal_L)
		
		If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
			//not found - need to create it
			CREATE RECORD:C68([NTI_ELEM_DEFS:182])
			[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$defectVal_L
			[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
			[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
			[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="Y"
			[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:="N"
			[NTI_ELEM_DEFS:182]REPORTED:16:="N"
			[NTI_ELEM_DEFS:182]NOTES:17:=$DefectNotes_txt
			[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
			SAVE RECORD:C53([NTI_ELEM_DEFS:182])
			APPEND TO ARRAY:C911($Messages_atxt; "Created Defect"+Char:C90(Tab:K15:37)+String:C10($defectVal_L)\
				+Char:C90(Tab:K15:37)+$ElemName_txt\
				+Char:C90(Tab:K15:37)+$DefectNotes_txt)
			UNLOAD RECORD:C212([NTI_ELEM_DEFS:182])
		Else 
			//update if needed
			
			If (ut_LoadRecordInteractive(->[NTI_ELEM_DEFS:182]))
				[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
				[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
				[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="Y"
				[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:="N"
				[NTI_ELEM_DEFS:182]REPORTED:16:="N"
				[NTI_ELEM_DEFS:182]NOTES:17:=$DefectNotes_txt
				If (Modified record:C314([NTI_ELEM_DEFS:182]))
					[NTI_ELEM_DEFS:182]MODDATETIME:8:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
					[NTI_ELEM_DEFS:182]MODDATETIME:8:=Current user:C182
					SAVE RECORD:C53([NTI_ELEM_DEFS:182])
					APPEND TO ARRAY:C911($Messages_atxt; "Updated defect"+Char:C90(Tab:K15:37)+String:C10($defectVal_L)\
						+Char:C90(Tab:K15:37)+$ElemName_txt\
						+Char:C90(Tab:K15:37)+$DefectNotes_txt)
				Else 
					APPEND TO ARRAY:C911($Messages_atxt; "No changes for defect"+Char:C90(Tab:K15:37)+String:C10($defectVal_L))
				End if 
				UNLOAD RECORD:C212([NTI_ELEM_DEFS:182])
				
			Else 
				ALERT:C41("Could not load record with key "+String:C10($defectVal_L)+" to modify it!")
				APPEND TO ARRAY:C911($Messages_atxt; "Locked Record for defect"+Char:C90(Tab:K15:37)+String:C10($defectVal_L))
				
			End if 
			
		End if 
		
	End for 
	$UpdateDefectLan_b:=True:C214
End if 

C_TEXT:C284($ElemCategory_txt; $ElemName_txt; $ProtSys_txt; $Reported_txt; $Units_txt; $BinOnly_txt; $TinOnly_txt)
C_LONGINT:C283($SubsetKey_L)
ARRAY TEXT:C222($Elementrefs_atxt; 0)
$ElemRef_txt:=DOM Find XML element:C864($NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; $Elementrefs_atxt)


If (Size of array:C274($Elementrefs_atxt)=0)
	ALERT:C41("There were no Elements in the XML!")
	
Else 
	
	For ($loop_L; 1; Size of array:C274($Elementrefs_atxt))
		ARRAY TEXT:C222($ElemDefects_atxt; 0)
		DOM GET XML ELEMENT VALUE:C731($Elementrefs_atxt{$loop_L}; $ElemVal_L)
		$ElemName_txt:=""
		$ElemCategory_txt:=""
		$ProtSys_txt:=""
		$Reported_txt:=""
		$Units_txt:=""
		$BinOnly_txt:=""
		$TinOnly_txt:=""
		$SubsetKey_L:=0
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Category"; $ElemCategory_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Name"; $ElemName_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "ProtectiveSystem"; $ProtSys_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Reported"; $Reported_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Unit"; $Units_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "BINOnly"; $BinOnly_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "TINOnly"; $TinOnly_txt)
		DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "SubsetKey"; $SubsetKey_L)
		
		QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$ElemVal_L)
		
		If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
			CREATE RECORD:C68([NTI_ELEM_DEFS:182])
			
			[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$ElemVal_L
			[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
			[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
			[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1:=$ElemCategory_txt
			[NTI_ELEM_DEFS:182]REPORTED:16:=$Reported_txt
			[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="N"
			[NTI_ELEM_DEFS:182]ELEM_BINONLY:18:=$BinOnly_txt
			[NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19:=$TinOnly_txt
			[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:=$ProtSys_txt
			[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12:=$Units_txt
			[NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13:=$SubsetKey_L
			[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
			
			SAVE RECORD:C53([NTI_ELEM_DEFS:182])
			UNLOAD RECORD:C212([NTI_ELEM_DEFS:182])
			APPEND TO ARRAY:C911($Messages_atxt; "Created Element"+Char:C90(Tab:K15:37)\
				+String:C10($ElemVal_L)+Char:C90(Tab:K15:37)\
				+$ElemName_txt+Char:C90(Tab:K15:37)+$ElemCategory_txt+Char:C90(Tab:K15:37)+$Units_txt+Char:C90(Tab:K15:37)+$ProtSys_txt+Char:C90(Tab:K15:37)+$Reported_txt)
		Else 
			
			If (ut_LoadRecordInteractive(->[NTI_ELEM_DEFS:182]))
				[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
				[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
				[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1:=$ElemCategory_txt
				[NTI_ELEM_DEFS:182]REPORTED:16:=$Reported_txt
				[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:=$ProtSys_txt
				[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12:=$Units_txt
				[NTI_ELEM_DEFS:182]ELEM_BINONLY:18:=$BinOnly_txt
				[NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19:=$TinOnly_txt
				[NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13:=$SubsetKey_L
				[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="N"
				If (Modified record:C314([NTI_ELEM_DEFS:182]))
					[NTI_ELEM_DEFS:182]MODDATETIME:8:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
					[NTI_ELEM_DEFS:182]MODDATETIME:8:=Current user:C182
					SAVE RECORD:C53([NTI_ELEM_DEFS:182])
					UNLOAD RECORD:C212([NTI_ELEM_DEFS:182])
					APPEND TO ARRAY:C911($Messages_atxt; "Updated element"+Char:C90(Tab:K15:37)\
						+String:C10($ElemVal_L))
				Else 
					APPEND TO ARRAY:C911($Messages_atxt; "No changes to element"+Char:C90(Tab:K15:37)\
						+String:C10($ElemVal_L))
				End if 
				
			Else 
				ALERT:C41("Could not load Element "+String:C10($ElemVal_L))
				APPEND TO ARRAY:C911($Messages_atxt; "Locked Record for element"+Char:C90(Tab:K15:37)+String:C10($ElemVal_L))
			End if 
			
		End if 
		
	End for 
	
	$UpdateDefElem_b:=True:C214
End if 

ON ERR CALL:C155($lastOnErr_txt)

$Updated_b:=$UpdateDefElem_b & $UpdateDefectLan_b
$0:=$Updated_b

If (Size of array:C274($Messages_atxt)>0)
	C_TEXT:C284($errFile_txt)
	$errFile_txt:=""
	If (Count parameters:C259>2)
		$errFile_txt:=$3
	Else 
		
		$errFile_txt:=Select document:C905("XML_to_DB_messages"+\
			Replace string:C233(FN_Date2DateTime(Current date:C33(*); Current time:C178(*)); ":"; "_")+".txt"; \
			".txt"; "Choose File to save Log of updates/changes"; File name entry:K24:17)
		
		If (OK=1)
			$errFile_txt:=Document
			
		Else 
			$errFile_txt:=""
		End if 
		
	End if 
	
	If ($errFile_txt#"")
		C_TIME:C306($errFileDoc_t)
		$errFileDoc_t:=Create document:C266($errFile_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($Messages_atxt))
			SEND PACKET:C103($errFileDoc_t; $Messages_atxt{$loop_L}+Char:C90(Carriage return:K15:38))
		End for 
		CLOSE DOCUMENT:C267($errFileDoc_t)
		SHOW ON DISK:C922($errFile_txt)
		
	End if 
	
Else 
	ALERT:C41("No discrepancies were found between XML files and DB")
End if 
//End NTI_UpdateDBfromXML