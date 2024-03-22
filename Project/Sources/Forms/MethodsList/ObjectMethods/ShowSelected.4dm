//Method: MethodsList.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/17, 15:45:07
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//

If (LBGeneric_ab>0)
	C_LONGINT:C283($OpenCount_L)
	C_LONGINT:C283($loop_L)
	$OpenCount_L:=0
	C_TEXT:C284($path_txt)
	
	For ($loop_L; Size of array:C274(LBGeneric_ab); 1; -1)
		If (Not:C34(LBGeneric_ab{$loop_L}))
			DELETE FROM ARRAY:C228(LBGeneric_atxt; $loop_L; 1)
		End if 
	End for 
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

//End MethodsList.Button1