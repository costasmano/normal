//%attributes = {"invisible":true}
//Method: CreateRandomSelection
//Description
// Create a random selection from the current selection of a table
// Parameters
// $1 : $Table_ptr
// $2 : $numOfRandomnlyChosenrecords
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-07T00:00:00, 13:10:20
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_POINTER:C301(CreateRandomSelection; $1)
	C_LONGINT:C283(CreateRandomSelection; $2)
End if 
//

C_POINTER:C301($1; $Tbl_ptr)
C_LONGINT:C283($2)
C_LONGINT:C283($TableNum_L; $numRandom_L)
$TableNum_L:=Table:C252($1)
$numRandom_L:=$2
If (Is table number valid:C999($TableNum_L))
	$Tbl_ptr:=Table:C252($TableNum_L)
	ARRAY LONGINT:C221($recordNums_aL; 0)
	SELECTION TO ARRAY:C260($Tbl_ptr->; $recordNums_aL)
	If ($numRandom_L>0)
		ARRAY LONGINT:C221($RandomRecords_aL; 0)
		GetRandomArrayElmts(->$recordNums_aL; $numRandom_L; ->$RandomRecords_aL)
		CREATE SELECTION FROM ARRAY:C640($Tbl_ptr->; $RandomRecords_aL)
	End if 
	
End if 

//End CreateRandomSelection