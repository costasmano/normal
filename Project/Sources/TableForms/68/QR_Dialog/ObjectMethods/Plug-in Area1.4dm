// Object Method: Report_Area_i

// Created by Dave Batton on Feb 6, 2003

C_LONGINT:C283($column; $sourceNumber; $sourceProcess; $tableNum; $fieldNum; $column)
C_LONGINT:C283($itemRef; $row)
C_POINTER:C301($sourceObject; $fieldPtr)
C_TEXT:C284($itemText)

Case of 
	: (Form event code:C388=On Drag Over:K2:13)
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		//If ($sourceObject=(->Report_FieldsList_l))
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
		
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
		
		$sourceObject:=OBJECT Get pointer:C1124(Object named:K67:5; $sourceObjectName)
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		GET LIST ITEM:C378($sourceObject->; Selected list items:C379($sourceObject->); $itemRef; $itemText)
		
		$tableNum:=$itemRef\1000
		$fieldNum:=$itemRef%1000
		
		If ($fieldNum=0)  // A table name was dropped.
			BEEP:C151
		Else 
			$fieldPtr:=Field:C253($tableNum; $fieldNum)
			QR INSERT COLUMN:C748(Self:C308->; QR Get drop column:C747(Self:C308->); $fieldPtr)
		End if 
End case 


QR GET SELECTION:C793(Self:C308->; $column; $row)
If ($row=0)
	OBJECT SET ENABLED:C1123(Report_DeleteColumnButton_i; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(Report_DeleteColumnButton_i; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
