// Object Method: Report_SortList_l

// Created by Dave Batton on Feb 4, 2003

C_LONGINT:C283($tableNum; $fieldNum; $itemRef; $dropPosition)
C_LONGINT:C283($position; $sourceNumber; $sourceProcess; $beforeItemRef; $column)
C_LONGINT:C283($icon; $mouseX; $mouseY; $styles; $mouseButton)
C_POINTER:C301($fieldPtr; $sourceObject)
C_TEXT:C284($itemText; $beforeItemitemText)
C_BOOLEAN:C305($enterable)

Case of 
	: (Form event code:C388=On Load:K2:1)
		Report_Gen_ClearList(Self:C308)
		
		
	: (Form event code:C388=On Drag Over:K2:13)
		//$0:=-1  // Deny the drag, unless we okay it below.
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		//If ($sourceNumber>0)
		//GET LIST ITEM($sourceObject->; $sourceNumber; $itemRef; $itemText)
		//$tableNum:=$itemRef\1000
		//$fieldNum:=$itemRef%1000
		//Case of 
		//: ($sourceObject=(Self))
		//$0:=0
		//: (($sourceObject=(->Report_FieldsList_l)) & ($fieldNum>0))
		//$0:=0
		//End case 
		//End if 
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		C_LONGINT:C283($col; $row)
		
		Use (Storage:C1525)
			Storage:C1525.dragAndDrop:=New shared object:C1526
			//If (Not(Undefined(Storage.dragAndDrop)))
			Use (Storage:C1525.dragAndDrop)
				Storage:C1525.dragAndDrop.source:=FORM Event:C1606.objectName
				LISTBOX GET CELL POSITION:C971(Report_SortList_l; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
	: (Form event code:C388=On Drop:K2:12)
		
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		C_TEXT:C284($sourceObjectName)
		C_LONGINT:C283($Src_element; $Src_process; $dropRow_L; $ColNum_L)
		//_O_DRAG AND DROP PROPERTIES($src_ptr; $Src_element; $Src_process)
		
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$sourceObjectName:=Storage:C1525.dragAndDrop.source
					$Src_element:=Storage:C1525.dragAndDrop.index
					$Src_process:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		
		$sourceObject:=OBJECT Get pointer:C1124(Object named:K67:5; $sourceObjectName)
		
		$dropPosition:=Drop position:C608  // Because we may need to change this.
		GET LIST ITEM:C378($sourceObject->; $sourceNumber; $itemRef; $itemText)
		$tableNum:=$itemRef\1000
		$fieldNum:=$itemRef%1000
		
		//If the object is from this list, we're just moving it.  We'll do that by deleting it
		//   and then recreating it in the enw position.  This is where we delete it.
		If ($sourceObject=Self:C308)
			DELETE FROM LIST:C624(Self:C308->; $itemRef)
			If ($sourceNumber<$dropPosition)
				$dropPosition:=$dropPosition-1
			End if 
		End if 
		
		If ($fieldNum#0)  // Don't allow a table name drop.
			$position:=List item position:C629(Self:C308->; $itemRef)
			If (($position=0) | ($sourceObject=Self:C308))  // Make sure it's not already in this list.
				$itemText:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum; $fieldNum)
				If ($dropPosition>0)
					GET LIST ITEM:C378(Self:C308->; $dropPosition; $beforeItemRef; $beforeItemitemText)
					INSERT IN LIST:C625(Self:C308->; $beforeItemRef; $itemText; $itemRef)
				Else 
					APPEND TO LIST:C376(Self:C308->; $itemText; $itemRef)
				End if 
				SET LIST ITEM PROPERTIES:C386(Self:C308->; $itemRef; False:C215; Plain:K14:1; Report_AscendingIcon_l)
				
				REDRAW:C174(Self:C308->)  // Command Replaced was o_REDRAW LIST 
				
				// Now make sure this field is available in the report.
				$fieldPtr:=Field:C253($tableNum; $fieldNum)
				$column:=QR Find column:C776(Report_Area_l; $fieldPtr)
				If ($column=-1)
					$column:=QR Count columns:C764(Report_Area_l)+1
					QR INSERT COLUMN:C748(Report_Area_l; $column; $fieldPtr)
				End if 
				QR SET SELECTION:C794(Report_Area_l; $column; 0)
			End if 
			
			Report_Edtr_SetSorts
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		GET MOUSE:C468($mouseX; $mouseY; $mouseButton)
		OBJECT GET COORDINATES:C663(Self:C308->; $left; $top; $right; $bottom)
		Case of 
			: (($mouseX>$left) & ($mouseX<=($left+15)))
				GET LIST ITEM:C378(Self:C308->; Selected list items:C379(Self:C308->); $itemRef; $itemText)
				GET LIST ITEM PROPERTIES:C631(Self:C308->; $itemRef; $enterable; $styles; $icon)
				If ($icon=Report_AscendingIcon_l)
					$icon:=Report_DescendingIcon_l
				Else 
					$icon:=Report_AscendingIcon_l
				End if 
				SET LIST ITEM PROPERTIES:C386(Self:C308->; $itemRef; $enterable; $styles; $icon)
				REDRAW:C174(Self:C308->)  // Command Replaced was o_REDRAW LIST 
				Report_Edtr_SetSorts
		End case 
End case 
