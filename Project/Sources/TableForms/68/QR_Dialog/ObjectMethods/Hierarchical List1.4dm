// Object Method: Report_FieldsList_l

// Created by Dave Batton on Feb 4, 2003

C_LONGINT:C283($sourceNumber; $sourceProcess; $itemRef)
C_POINTER:C301($sourceObject)
C_TEXT:C284($itemText)

Case of 
	: (Form event code:C388=On Drag Over:K2:13)
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		//If (($sourceObject=(->Report_SortList_l)) & ($sourceNumber>0))
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
				LISTBOX GET CELL POSITION:C971(Report_FieldsList_l; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
	: (Form event code:C388=On Drop:K2:12)
		
		C_TEXT:C284($sourceObjectName)
		C_LONGINT:C283($Src_element; $Src_process; $dropRow_L; $ColNum_L)
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$sourceObjectName:=Storage:C1525.dragAndDrop.source
					$Src_element:=Storage:C1525.dragAndDrop.index
					$Src_process:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		
		//Allow the user to delete items from the Sort list by dragging them back.
		If ($sourceObjectName="Hierarchical List3")  //(->Report_SortList_l))
			$sourceObject:=OBJECT Get pointer:C1124(Object named:K67:5; $sourceObjectName)
			GET LIST ITEM:C378($sourceObject->; $sourceNumber; $itemRef; $itemText)
			DELETE FROM LIST:C624(Report_SortList_l; $itemRef)
			REDRAW:C174(Report_SortList_l)  // Command Replaced was o_REDRAW LIST 
			Report_Edtr_SetSorts
		End if 
End case 
