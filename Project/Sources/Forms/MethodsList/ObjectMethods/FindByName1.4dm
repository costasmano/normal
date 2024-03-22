//Method: MethodsList.FindByName1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/05/20, 15:53:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03  //ADD button to Methods List Form _ This is utility method
	
End if 
//
C_LONGINT:C283($Loop_L; $Size_L; $InnerLoop_L)
$Size_L:=Size of array:C274(LBGeneric_atxt)

ARRAY TEXT:C222($Dates_atxt; $Size_L)
ARRAY TEXT:C222($Times_atxt; $Size_L)
ARRAY TEXT:C222($Changes_atxt; $Size_L)
ARRAY TEXT:C222($TypeColumn_atxt; $Size_L)

ARRAY TEXT:C222($FormName_atxt; $Size_L)
ARRAY TEXT:C222($remainder_atxt; $size_l)


For ($Loop_L; 1; $Size_L)
	ARRAY TEXT:C222($parts_atxt; 0)
	ARRAY TEXT:C222($DateTimes_atxt; 0)
	ut_NewTextToArray(LBGeneric_atxt{$Loop_L}; ->$parts_atxt; " - ")
	ut_NewTextToArray($parts_atxt{1}; ->$DateTimes_atxt; "T")
	$Dates_atxt{$Loop_L}:=$DateTimes_atxt{1}
	$Times_atxt{$Loop_L}:=$DateTimes_atxt{2}
	ARRAY TEXT:C222($Changes_atxt; 0)
	ut_NewTextToArray($parts_atxt{2}; ->$Changes_atxt; "/")
	
	Case of 
		: (Size of array:C274($Changes_atxt)=1)
			$TypeColumn_atxt{$Loop_L}:="[Method]"
			$FormName_atxt{$Loop_L}:=$Changes_atxt{1}
		: ($Changes_atxt{1}="[tableForm]")
			$TypeColumn_atxt{$Loop_L}:=$Changes_atxt{1}
			$FormName_atxt{$Loop_L}:=$Changes_atxt{2}+"/"+$Changes_atxt{3}
			If (Size of array:C274($Changes_atxt)>3)
				$remainder_atxt{$Loop_L}:=$Changes_atxt{4}
				For ($innerLoop_L; 5; Size of array:C274($Changes_atxt))
					$remainder_atxt{$Loop_L}:=$remainder_atxt{$Loop_L}+","+$Changes_atxt{$innerLoop_L}
				End for 
			End if 
		: ($Changes_atxt{1}="[projectForm]")
			$TypeColumn_atxt{$Loop_L}:=$Changes_atxt{1}
			$FormName_atxt{$Loop_L}:=$Changes_atxt{2}
			If (Size of array:C274($Changes_atxt)>2)
				$remainder_atxt{$Loop_L}:=$Changes_atxt{3}
				For ($innerLoop_L; 4; Size of array:C274($Changes_atxt))
					$remainder_atxt{$Loop_L}:=$remainder_atxt{$Loop_L}+","+$Changes_atxt{$innerLoop_L}
				End for 
			End if 
		: ($Changes_atxt{1}="[databaseMethod]")
			$TypeColumn_atxt{$Loop_L}:=$Changes_atxt{1}
			$FormName_atxt{$Loop_L}:=$Changes_atxt{2}
			
			
		Else 
			
			$TypeColumn_atxt{$Loop_L}:=$Changes_atxt{1}
			$FormName_atxt{$Loop_L}:=$Changes_atxt{2}
			$remainder_atxt{$Loop_L}:=$Changes_atxt{3}
			For ($innerLoop_L; 4; Size of array:C274($Changes_atxt))
				$remainder_atxt{$Loop_L}:=$remainder_atxt{$Loop_L}+","+$Changes_atxt{$innerLoop_L}
			End for 
			
	End case 
	
	
	
End for 
ARRAY TEXT:C222($Selected_atxt; 0)
C_TEXT:C284($Doc_txt; $result_txt)

$Doc_txt:=Select document:C905(""; "CSV"; "Create CSV for selected Methods"; File name entry:K24:17; $Selected_atxt)
If (OK=1)
	$Doc_txt:=$Selected_atxt{1}
	$result_txt:="Last Change Date,Last Change Time,Description"+Char:C90(Carriage return:K15:38)
	$result_txt:=$result_txt+ut_ArrayToText_CSV(","; \
		->$Dates_atxt; \
		->$Times_atxt; \
		->$TypeColumn_atxt; \
		->$FormName_atxt; \
		->$remainder_atxt)
	
	
	TEXT TO DOCUMENT:C1237($Doc_txt; $result_txt; UTF8 text without length:K22:17)
	
	
	
End if 
//End MethodsList.FindByName1