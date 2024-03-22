//Method: ReLogRecords.LinkTablemenu
// object method to define a [table]field to link fields to
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/15/21, 19:23:49
	// ----------------------------------------------------
	//Created : 
	Mods_2021_07
End if 
//
C_POINTER:C301($menu_ptr; $Fieldname_ptr; $saveData_ptr)
$menu_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($tablemask_L)
$tablemask_L:=100000
Case of 
	: (Form event code:C388=On Load:K2:1)
		$Fieldname_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LinkToField")
		C_LONGINT:C283($numTables; $i)
		$numTables:=Get last table number:C254
		ARRAY LONGINT:C221($TablePtr_aL; $numTables)
		ARRAY TEXT:C222($PickTableName_as; $numTables)  //Command Replaced was o_ARRAY string length was 32
		For ($i; $numTables; 1; -1)
			If (Is table number valid:C999($i))
				$TablePtr_aL{$i}:=$i
				$PickTableName_as{$i}:=Table name:C256($i)
			Else 
				DELETE FROM ARRAY:C228($TablePtr_aL; $i; 1)
				DELETE FROM ARRAY:C228($PickTableName_as; $i; 1)
			End if 
		End for 
		SORT ARRAY:C229($PickTableName_as; $TablePtr_aL)
		$menu_ptr->:=ut_ArrayToHL(->$PickTableName_as; ""; ->$TablePtr_aL)
		C_LONGINT:C283($loop_L; $numFields_L)
		For ($loop_L; Size of array:C274($TablePtr_aL); 1; -1)
			$numFields_L:=Get last field number:C255($TablePtr_aL{$loop_L})
			ARRAY LONGINT:C221($fieldNum_aL; $numFields_L)
			ARRAY TEXT:C222($fieldName_atxt; $numFields_L)
			For ($i; $numFields_L; 1; -1)
				If (Is field number valid:C1000($TablePtr_aL{$loop_L}; $i))
					$fieldNum_aL{$i}:=$i+($TablePtr_aL{$loop_L}*$tablemask_L)
					$fieldName_atxt{$i}:=Field name:C257($TablePtr_aL{$loop_L}; $i)
				Else 
					DELETE FROM ARRAY:C228($fieldNum_aL; $i; 1)
					DELETE FROM ARRAY:C228($fieldName_atxt; $i; 1)
				End if 
			End for 
			SORT ARRAY:C229($fieldName_atxt; $fieldNum_aL)
			C_LONGINT:C283($Fieldmenu)
			$Fieldmenu:=ut_ArrayToHL(->$fieldName_atxt; ""; ->$fieldNum_aL)
			SET LIST ITEM:C385($menu_ptr->; $TablePtr_aL{$loop_L}; $PickTableName_as{$loop_L}; $TablePtr_aL{$loop_L}; \
				$Fieldmenu; True:C214)
		End for 
		OBJECT SET TITLE:C194(*; "LinkToField"; "")
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($tablenum_L; $itempos; $Fieldnum_L; $tableFieldNum_L)
		C_TEXT:C284($tblname)
		$itempos:=Selected list items:C379($menu_ptr->)
		GET LIST ITEM:C378($menu_ptr->; $itempos; $tableFieldNum_L; $tblname)
		$tablenum_L:=$tableFieldNum_L\$tablemask_L
		$Fieldnum_L:=$tableFieldNum_L%$tablemask_L
		C_TEXT:C284($fieldName_txt)
		$fieldName_txt:="["+Table name:C256($tablenum_L)+"]"+Field name:C257($tablenum_L; $Fieldnum_L)
		
		//field must be integer, longint , or alpha and unique field
		C_LONGINT:C283($fieldType_L; $fieldLen_l)
		C_BOOLEAN:C305($indx; $unique)
		
		GET FIELD PROPERTIES:C258($tablenum_L; $Fieldnum_L; $fieldType_L; $fieldLen_l; $indx; $unique)
		If (($fieldType_L=Is integer:K8:5) | ($fieldType_L=Is longint:K8:6) | ($fieldType_L=Is alpha field:K8:1)) & $unique
			$saveData_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "fieldsToLog")
			C_OBJECT:C1216($fields_o)
			If (Length:C16($saveData_ptr->)>0)
				$fields_o:=JSON Parse:C1218($saveData_ptr->)
			End if 
			OB SET:C1220($fields_o; "linktable"; $tablenum_L)
			OB SET:C1220($fields_o; "linkfield"; $Fieldnum_L)
			OB SET:C1220($fields_o; "linkfieldname"; "["+Table name:C256($tablenum_L)+"]"+Field name:C257($tablenum_L; $Fieldnum_L))
			C_TEXT:C284($fields_objtext)
			$fields_objtext:=JSON Stringify:C1217($fields_o)
			$saveData_ptr->:=$fields_objtext  //save the object in the form var
			OBJECT SET TITLE:C194(*; "LinkToField"; $fieldName_txt)
		Else 
			
			ALERT:C41("Selected field "+$fieldName_txt+" is type '"+fGetDataType($fieldType_L)+"' and "+\
				Choose:C955($unique; "Unique"; "NotUnique")+\
				"! it must be either integer, longint, or alpha AND Unique")
			
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		CLEAR LIST:C377($menu_ptr->; *)
		
End case 

//End ReLogRecords.LinkTablemenu