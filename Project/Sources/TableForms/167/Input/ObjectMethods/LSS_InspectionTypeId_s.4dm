
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 11:37:51
//----------------------------------------------------
//Method: Object Method: [LSS_refInspectionType];"Input".LSS_InspectionTypeId_s
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 11:37:52)
	// Modified by: Costas Manousakis-(Designer)-(9/13/18 17:34:14)
	Mods_2018_09_bug
	//  `fixed order of $Key_atxt
End if 
If (Is new record:C668([LSS_refInspectionType:167]))
	C_TEXT:C284($QueryBy_txt)
	C_LONGINT:C283($Selection_L)
	
	$QueryBy_txt:=" "+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Sign"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Light"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Signal"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"ITS"+Char:C90(1)
	
	ARRAY TEXT:C222($Key_atxt; 0)
	APPEND TO ARRAY:C911($Key_atxt; "")
	APPEND TO ARRAY:C911($Key_atxt; "HS")
	APPEND TO ARRAY:C911($Key_atxt; "LI")
	APPEND TO ARRAY:C911($Key_atxt; "SI")
	APPEND TO ARRAY:C911($Key_atxt; "IT")
	$Selection_L:=Pop up menu:C542($QueryBy_txt)
	C_TEXT:C284($Key_txt)
	
	If ($Selection_L>1)
		$Key_txt:=$Key_atxt{$Selection_L}+"%"
		Begin SQL
			select max([LSS_refInspectionType].[LSS_InspectionTypeId_s])
			from [LSS_refInspectionType]
			where
			[LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$Key_txt
			into :$Key_txt;
		End SQL
		$Key_txt:=Replace string:C233($Key_txt; $Key_atxt{$Selection_L}+"-"; "")
		[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1:=$Key_atxt{$Selection_L}+"-"+String:C10(Num:C11($Key_txt)+1; "00000")
		OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		OBJECT SET ENTERABLE:C238(*; "LSS_InspectionTypeId_s"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_InspectionTypeId_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_InspectionTypeId_s"; <>Color_Not_Editable)
	End if 
End if 
//End Object Method: [LSS_refInspectionType].Input.LSS_InspectionTypeId_s