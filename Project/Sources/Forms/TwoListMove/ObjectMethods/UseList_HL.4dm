If (False:C215)
	//Object Method: hL2 on [Dialogs];"Inspection"
	//Purpose: create elements for Dive Inspection
	//accept drags from hL1
	//by: Albert Leung
	//Date Created: 3/31/2001
	
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 16:17:06)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(11/30/07 14:24:35)
	Mods_2007_CM_5401
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 

C_POINTER:C301($vpSrcObj)
C_LONGINT:C283($vlSrcElem; $vlPID; $vlItemRef)
C_BOOLEAN:C305($vbExpanded)
C_TEXT:C284($vsItemText)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//These are required
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
		
		C_TEXT:C284($src_name)
		C_LONGINT:C283($Src_element; $Src_process)
		
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
		
		//If ($vpSrcObj=Get pointer("OmitList_HL"))
		If ($src_name="OmitList_HL")
			//Accept objects only from hList1      
			$0:=0
		Else 
			$0:=-1
		End if 
	: (Form event code:C388=On Drop:K2:12)
		G_MoveBtns_OM("MOVEL")
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			G_MoveBtns_OM("MOVER")
			InDoubleClick_B:=False:C215
			
		End if 
		
End case 

