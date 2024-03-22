//%attributes = {"invisible":true}
//Method: LSS_RatingPopup
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/10/15, 16:48:51
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	
	C_POINTER:C301(LSS_RatingPopup; $1)
	
End if 
//
C_POINTER:C301($1)

C_POINTER:C301($Fld_ptr)

$Fld_ptr:=$1

C_LONGINT:C283($choise_L; $oL; $oT; $oR; $oB; $WL; $WT; $WR; $WB; $def_L)
ARRAY TEXT:C222($Ratings_atxt; 0)
C_TEXT:C284($RatingsMenu_txt)
$RatingsMenu_txt:=" ;N;1;2;3;4;H;R;X"
ut_TextToArray($RatingsMenu_txt; ->$Ratings_atxt; ";")
$def_L:=Find in array:C230($Ratings_atxt; $Fld_ptr->)
If ($def_L>0)
Else 
	$def_L:=0
End if 
OBJECT GET COORDINATES:C663(Self:C308->; $oL; $oT; $oR; $oB)
$choise_L:=Pop up menu:C542($RatingsMenu_txt; $def_L)
If ($choise_L>0)
	$Fld_ptr->:=$Ratings_atxt{$choise_L}
	//Choose($choise_L;"";" ";"N";"1";"2";"3";"4";"H";"R";"X")
End if 

//End LSS_RatingPopup