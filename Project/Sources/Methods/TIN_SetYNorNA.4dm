//%attributes = {"invisible":true}
//Method: TIN_SetYNorNA($fieldPointer)
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/28/17, 11:41:27
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
C_POINTER:C301($1)
If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	ARRAY TEXT:C222($Key_atxt; 0)
	ARRAY TEXT:C222($Key_atxt; 4)
	$Key_atxt{1}:=""
	$Key_atxt{2}:="Y"
	$Key_atxt{3}:="N"
	$Key_atxt{4}:="NR"
	C_LONGINT:C283($Selection_L)
	C_TEXT:C284($QueryBy_txt)
	$QueryBy_txt:=" "+Char:C90(1)+"Y"+Char:C90(1)+"N"+Char:C90(1)+"NR"+Char:C90(1)
	C_LONGINT:C283($T; $L; $B; $R)
	OBJECT GET COORDINATES:C663($1->; $L; $T; $R; $B)
	$Selection_L:=Pop up menu:C542($QueryBy_txt; 0; $R; ($T+$B)/2)
	If ($Selection_L>0)
		$1->:=$Key_atxt{$Selection_L}
	End if 
	
End if 


//End TIN_SetYNorNA