//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/10, 09:31:10
	// ----------------------------------------------------
	// Method: Method: ut_SelectionFromUserSet
	// Description
	// Create or restore a selection from the UserSet in the same order as the current selection of a Table
	// 
	// Parameters
	// $1 : $Action_txt ("Create"| "Restore")
	// $2 : $Table_ptr
	// $3 : $StartingSel_txt
	// $4 : $TempHighliteSet_txt
	
	// ----------------------------------------------------
	
	Mods_2010_08
End if 
C_TEXT:C284($1; $Action_txt)
$Action_txt:=$1
C_POINTER:C301($2; $Table_ptr)
$Table_ptr:=$2
C_TEXT:C284($3; $StartingSel_txt; $4; $TempHighliteSet_txt)
$StartingSel_txt:=$3
$TempHighliteSet_txt:=$4
Case of 
	: ($Action_txt="CREATE")
		C_LONGINT:C283($RecordsInSele_L; $LRecsInSet; $i)
		$RecordsInSele_L:=Records in selection:C76($Table_ptr->)
		ARRAY LONGINT:C221($InspRecNums_aL; $RecordsInSele_L)
		SELECTION TO ARRAY:C260($Table_ptr->; $InspRecNums_aL)
		COPY NAMED SELECTION:C331($Table_ptr->; $StartingSel_txt)
		$LRecsInSet:=Records in set:C195("UserSet")
		USE SET:C118("UserSet")
		CREATE SET:C116($Table_ptr->; $TempHighliteSet_txt)
		ARRAY LONGINT:C221($InspUSetRecNums_aL; $LRecsInSet)
		SELECTION TO ARRAY:C260($Table_ptr->; $InspUSetRecNums_aL)
		For ($i; $RecordsInSele_L; 1; -1)
			If (Find in array:C230($InspUSetRecNums_aL; $InspRecNums_aL{$i})>0)
			Else 
				DELETE FROM ARRAY:C228($InspRecNums_aL; $i)
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640($Table_ptr->; $InspRecNums_aL)
		ARRAY LONGINT:C221($InspRecNums_aL; 0)
		ARRAY LONGINT:C221($InspUSetRecNums_aL; 0)
		
	: ($Action_txt="RESTORE")
		
		USE NAMED SELECTION:C332($StartingSel_txt)
		CLEAR NAMED SELECTION:C333($StartingSel_txt)
		HIGHLIGHT RECORDS:C656($TempHighliteSet_txt)
		CLEAR SET:C117($TempHighliteSet_txt)
		
End case 

