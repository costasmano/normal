If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/07/07, 13:41:50
	// ----------------------------------------------------
	// Method: Object Method: OmitList_HL
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(11/30/07 14:24:20)
	Mods_2007_CM_5401
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 

C_POINTER:C301($vpSrcObj)
C_LONGINT:C283($vlSrcElem; $vlPID; $vlItemRef; $hSublist; $vlPID; $dropPos; $Src_process; $vlTargetRef)
C_BOOLEAN:C305($vbExpanded)
C_TEXT:C284($vsItemText; $src_name)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//These are required
		InDoubleClick_B:=False:C215
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		C_LONGINT:C283($row; $col)
		Use (Storage:C1525)
			Storage:C1525.dragAndDrop:=New shared object:C1526
			//If (Not(Undefined(Storage.dragAndDrop)))
			Use (Storage:C1525.dragAndDrop)
				Storage:C1525.dragAndDrop.source:=FORM Event:C1606.objectName
				LISTBOX GET CELL POSITION:C971(UseList_HL; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
	: (Form event code:C388=On Drag Over:K2:13)
		
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$src_name:=Storage:C1525.dragAndDrop.source
					$Src_element:=Storage:C1525.dragAndDrop.index
					$Src_process:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		
		//If (($vpSrcObj=Get pointer("UseList_HL")) | ($vpSrcObj=Get pointer("OmitList_HL")))
		If (($src_name="UseList_HL") | ($src_name="OmitList_HL"))
			
			//Accept objects only from hList1 or myself
			$0:=0
		Else 
			$0:=-1
		End if 
	: (Form event code:C388=On Drop:K2:12)
		//Get the information about the drag and drop source object
		
		
		C_POINTER:C301($vpSrcObj)
		C_TEXT:C284($src_name)
		C_LONGINT:C283($Src_element; $Src_process)
		//s_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$src_name:=Storage:C1525.dragAndDrop.source
					$Src_element:=Storage:C1525.dragAndDrop.index
					$Src_process:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		
		//If (($vpSrcObj=Get pointer("UseList_HL")))
		If (($src_name="UseList_HL"))
			G_MoveBtns_OM("MOVER")
		Else 
			$dropPos:=Drop position:C608
			If ($dropPos#$vlSrcElem)
				If ($dropPos#-1)
					GET LIST ITEM:C378(OmitList_HL; $dropPos; $vlTargetRef; $vsItemText; $hSublist; $vbExpanded)
					GET LIST ITEM:C378(OmitList_HL; $vlSrcElem; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
					DELETE FROM LIST:C624(OmitList_HL; $vlItemRef; *)
					REDRAW:C174(OmitList_HL)  // Command Replaced was o_REDRAW LIST 
					INSERT IN LIST:C625(OmitList_HL; $vlTargetRef; $vsItemText; $vlItemRef)
				Else 
					GET LIST ITEM:C378(OmitList_HL; $vlSrcElem; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
					DELETE FROM LIST:C624(OmitList_HL; $vlItemRef; *)
					REDRAW:C174(OmitList_HL)  // Command Replaced was o_REDRAW LIST 
					APPEND TO LIST:C376(OmitList_HL; $vsItemText; $vlItemRef)
				End if 
				REDRAW:C174(OmitList_HL)  // Command Replaced was o_REDRAW LIST 
			End if 
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			G_MoveBtns_OM("MOVEL")
			InDoubleClick_B:=False:C215
			
		End if 
		
End case 

