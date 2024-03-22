//Method: "MethodsList".FilterByAttr
//Description
// search current list by method attributes
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/05/17, 16:31:00
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
End if 
//
C_TEXT:C284($attribute_txt; $part2_txt; $value_txt; $attrValue_txt)
C_BOOLEAN:C305($value_b; $test_b)
If (Self:C308->>0)
	C_LONGINT:C283($SelfIndex_L)
	$SelfIndex_L:=Self:C308->
	$attribute_txt:=Substring:C12(Self:C308->{$SelfIndex_L}; 1; Position:C15(" "; Self:C308->{$SelfIndex_L})-1)
	$part2_txt:=""
	If (Position:C15("."; $attribute_txt)>0)
		$part2_txt:=Substring:C12($attribute_txt; Position:C15("."; $attribute_txt)+1)
		$attribute_txt:=Substring:C12($attribute_txt; 1; Position:C15("."; $attribute_txt)-1)
	End if 
	
	$value_txt:=Substring:C12(Self:C308->{$SelfIndex_L}; Position:C15(" : "; Self:C308->{$SelfIndex_L})+3)
	$value_b:=($value_txt="true")
	ARRAY TEXT:C222($Filtered_atxt; 0)
	ARRAY TEXT:C222($Filtered_atxt; Size of array:C274(LBGeneric_atxt))
	C_LONGINT:C283($loop_L; $next_L; $progress_L)
	C_TEXT:C284($path_txt)
	C_OBJECT:C1216($attributes_o)
	$progress_L:=Progress New
	Progress SET TITLE($progress_L; "Filtering for "+$attribute_txt+" = "+$value_txt)
	For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
		If (Match regex:C1019("(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d - )"; LBGeneric_atxt{$loop_L}; 1))
			$path_txt:=Substring:C12(LBGeneric_atxt{$loop_L}; 23)
		Else 
			$path_txt:=LBGeneric_atxt{$loop_L}
		End if 
		If ($path_txt="[@")  //skip any form object
		Else 
			METHOD GET ATTRIBUTES:C1334($path_txt; $attributes_o)
			If ($part2_txt#"")
				$attrValue_txt:=String:C10(OB Get:C1224(OB Get:C1224($attributes_o; $attribute_txt); $part2_txt))
			Else 
				$attrValue_txt:=String:C10(OB Get:C1224($attributes_o; $attribute_txt))
			End if 
			If ($attrValue_txt=$value_txt)
				$Filtered_atxt{$loop_L}:=LBGeneric_atxt{$loop_L}
			End if 
		End if 
		
	End for 
	C_LONGINT:C283($loop_L)
	For ($loop_L; Size of array:C274($Filtered_atxt); 1; -1)
		If ($Filtered_atxt{$loop_L}="")
			DELETE FROM ARRAY:C228($Filtered_atxt; $loop_L)
		End if 
	End for 
	
	Progress QUIT($progress_L)
	
	COPY ARRAY:C226($Filtered_atxt; LBGeneric_atxt)
	
	C_TEXT:C284($title_txt)
	$title_txt:=Get window title:C450
	C_LONGINT:C283($countPos_L)
	C_BOOLEAN:C305($match_b)
	ARRAY LONGINT:C221($posFound_aL; 0)
	ARRAY LONGINT:C221($lenFound_aL; 0)
	
	$match_b:=Match regex:C1019("(.*)( \\()(\\d+)(\\))$"; $title_txt; 1; $posFound_aL; $lenFound_aL)
	If ($match_b)
		//the main title is the first pattern in the match regex
		$title_txt:=Substring:C12($title_txt; $posFound_aL{1}; $lenFound_aL{1})
	End if 
	
	SET WINDOW TITLE:C213($title_txt+" ("+String:C10(Size of array:C274(LBGeneric_atxt))+")")
	
	
End if 

//End MethodsList.Popup Drop down List