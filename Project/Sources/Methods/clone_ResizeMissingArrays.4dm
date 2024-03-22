//%attributes = {"invisible":true}
//Method: clone_ResizeMissingArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/12/18, 12:20:30
	// ----------------------------------------------------
	//Created : 
	Compiler_clone
	Mods_2018_06
End if 
//
C_LONGINT:C283($1; $Size_L; $Loop_L)
$Size_L:=$1
C_POINTER:C301($Array_ptr)
C_TEXT:C284($part_txt)

For ($Loop_L; 1; Size of array:C274(clone_MissingArrayNames_atxt))
	$Array_ptr:=Get pointer:C304(clone_MissingArrayNames_atxt{$Loop_L})
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_NewTextToArray(clone_MissingArrayNames_atxt{$Loop_L}; ->$Parts_atxt; "_")
	$part_txt:=$Parts_atxt{Size of array:C274($Parts_atxt)}
	Case of 
		: ($part_txt="atxt")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY TEXT:C222($Array_ptr->; $Size_L)
		: ($part_txt="aL")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY LONGINT:C221($Array_ptr->; $Size_L)
		: ($part_txt="ai")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY INTEGER:C220($Array_ptr->; $Size_L)
		: ($part_txt="ar")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY REAL:C219($Array_ptr->; $Size_L)
		: ($part_txt="atm")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY TIME:C1223($Array_ptr->; $Size_L)
		: ($part_txt="ad")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY DATE:C224($Array_ptr->; $Size_L)
		: ($part_txt="ab")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY BOOLEAN:C223($Array_ptr->; $Size_L)
		: ($part_txt="ap")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY PICTURE:C279($Array_ptr->; $Size_L)
		: ($part_txt="ablb")
			CLEAR VARIABLE:C89($Array_ptr->)
			ARRAY BLOB:C1222($Array_ptr->; $Size_L)
	End case 
End for 
//End clone_ResizeMissingArrays