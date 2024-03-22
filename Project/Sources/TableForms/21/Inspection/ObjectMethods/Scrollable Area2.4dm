If (False:C215)
	//Object Method: hL2 on [Dialogs];"Inspection"
	//Purpose: create elements for Dive Inspection
	//accept drags from hL1
	//by: Albert Leung
	//Date Created: 3/31/2001
	
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 16:17:06)
	Mods_2006_CM03
End if 

C_POINTER:C301($vpSrcObj)
C_LONGINT:C283($vlSrcElem; $vlPID; $vlItemRef)
C_BOOLEAN:C305($vbExpanded)
C_TEXT:C284($vsItemText)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//These are required
		hList2:=New list:C375
		//Populate this with existing elements
		SET CURSOR:C469(4)
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1#0)
		ARRAY INTEGER:C220($A; 0)
		SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $A)
		SORT ARRAY:C229($A)
		For ($i; 1; Size of array:C274($A))
			QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$A{$i})
			//Don't add elements that are parents
			If (Not:C34([ElementDict:30]IsParent:5))
				AddElemtoHlist(->hList2; $A{$i}; ""; 0; False:C215)
			End if 
		End for 
		SET CURSOR:C469(0)
	: (Form event code:C388=On Drag Over:K2:13)
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		//If ($vpSrcObj=Get pointer("hList1"))
		////Accept objects only from hList1      
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
	: (Form event code:C388=On Begin Drag Over:K2:44)
		C_LONGINT:C283($col; $row)
		Use (Storage:C1525)
			Storage:C1525.dragAndDrop:=New shared object:C1526
			//If (Not(Undefined(Storage.dragAndDrop)))
			Use (Storage:C1525.dragAndDrop)
				Storage:C1525.dragAndDrop.source:=FORM Event:C1606.objectName
				LISTBOX GET CELL POSITION:C971(hList1; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
		
	: (Form event code:C388=On Drop:K2:12)
		//Get the information about the drag and drop source object
		//C_POINTER($vpSrcObj)
		//C_LONGINT($vlSrcElem; $vlPID; $hSublist)
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		
		C_TEXT:C284($src_name)
		C_LONGINT:C283($Src_element; $Src_process; $dropRow_L; $ColNum_L)
		
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$src_name:=Storage:C1525.dragAndDrop.source
					$Src_element:=Storage:C1525.dragAndDrop.index
					$Src_process:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		
		//GET LIST ITEM(hList1; $vlSrcElem; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
		GET LIST ITEM:C378(hList1; $Src_element; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
		
		If (List item position:C629(hList2; $vlItemRef)=0)
			//Don't add if it already exists      
			AddElemtoHlist(->hList2; $vlItemRef; $vsItemText; $hSublist; True:C214)
			ut_ExpandList(->hList2)
		End if 
End case 

