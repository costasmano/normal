//%attributes = {"invisible":true}
//Method: FORM_FixHairLine
//Description
// fixes printing problem of hairlines in 15.2 by making their size at least 1 pix
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/15/16, 12:48:48
	// ----------------------------------------------------
	//Created : 
	Mods_2016_09
End if 
//
ARRAY TEXT:C222($obj_atxt; 0)
FORM GET OBJECTS:C898($obj_atxt)
C_LONGINT:C283($loop_L; $Wi_L; $H_L; $left; $top; $right; $bott)
C_TEXT:C284($format_txt)
For ($loop_L; 1; Size of array:C274($obj_atxt))
	Case of 
		: (OBJECT Get type:C1300(*; $obj_atxt{$loop_L})=Object type rectangle:K79:32)
			
		: (OBJECT Get type:C1300(*; $obj_atxt{$loop_L})=Object type line:K79:33)
			
			OBJECT GET BEST SIZE:C717(*; $obj_atxt{$loop_L}; $Wi_L; $H_L)
			OBJECT GET COORDINATES:C663(*; $obj_atxt{$loop_L}; $left; $top; $right; $bott)
			
			Case of 
				: ($Wi_L=0)
					OBJECT MOVE:C664(*; $obj_atxt{$loop_L}; 0; 0; 1; 0)
				: ($H_L=0)
					OBJECT MOVE:C664(*; $obj_atxt{$loop_L}; 0; 0; 0; 1)
			End case 
		Else 
	End case 
End for 

//End FORM_FixHairLine