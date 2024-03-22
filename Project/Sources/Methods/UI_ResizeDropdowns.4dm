//%attributes = {"invisible":true}
//Method: UI_ResizeDropdowns
//Description
// Resize Dropdowns on a form for Mac - need to be 10 pts more than font ht
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-30, 18:54:56
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
End if 
//
If (Is macOS:C1572)
	ARRAY TEXT:C222($objects_atxt; 0)
	FORM GET OBJECTS:C898($objects_atxt)
	
	C_LONGINT:C283($loop_L; $fontsize; $oL; $oT; $oR; $oB; $margin)
	$margin:=10
	For ($loop_L; 1; Size of array:C274($objects_atxt))
		If (OBJECT Get type:C1300(*; $objects_atxt{$loop_L})=Object type popup dropdown list:K79:13)
			$fontsize:=OBJECT Get font size:C1070(*; $objects_atxt{$loop_L})
			OBJECT GET COORDINATES:C663(*; $objects_atxt{$loop_L}; $oL; $oT; $oR; $oB)
			If (($oB-$oT)<($fontsize+$margin))
				OBJECT SET COORDINATES:C1248(*; $objects_atxt{$loop_L}; $oL; $oT; $oR; ($oT+$fontsize+$margin))
				
			End if 
		End if 
	End for 
	
End if 
//End UI_ResizeDropdowns