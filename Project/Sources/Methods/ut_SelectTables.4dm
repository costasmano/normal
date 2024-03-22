//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/16/09, 14:42:06
	// ----------------------------------------------------
	// Method: ut_SelectTables
	// Description
	// 
	// 
	// Parameters
	// $1 : $TblList_ptr
	// ----------------------------------------------------
	
	Mods_2009_06
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 10:39:08)
	Mods_2015_09
	//  `The TwoListMove dialog is a Project Form now
End if 
C_POINTER:C301($1; $TblList_ptr)

C_LONGINT:C283($vlTable; $NumAlltables_L)
$NumAlltables_L:=Get last table number:C254
ARRAY TEXT:C222(asTables; $NumAlltables_L)  //Command Replaced was o_ARRAY string length was 31
ARRAY LONGINT:C221(TableNos_aL; $NumAlltables_L)
For ($vlTable; 1; $NumAlltables_L)
	asTables{$vlTable}:=Table name:C256($vlTable)
	TableNos_aL{$vlTable}:=$vlTable
End for 

SORT ARRAY:C229(asTables; TableNos_aL)
C_LONGINT:C283(UseList_HL; OmitList_HL)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
TWOLIST_MOVEONLY_B:=False:C215
C_LONGINT:C283($numTbls_2_L; $loop_L)
$TblList_ptr:=$1
$numTbls_2_L:=Size of array:C274($TblList_ptr->)
If ($numTbls_2_L>0)
	ARRAY LONGINT:C221(SelectTables_aL; $numTbls_2_L)
	ARRAY TEXT:C222(SelectTables_as; $numTbls_2_L)  //Command Replaced was o_ARRAY string length was 31
	For ($loop_L; 1; $numTbls_2_L)
		SelectTables_aL{$loop_L}:=Table:C252($TblList_ptr->{$loop_L})
		SelectTables_as{$loop_L}:=Table name:C256($TblList_ptr->{$loop_L})
	End for 
	SORT ARRAY:C229(SelectTables_as; SelectTables_aL)
	OmitList_HL:=ut_ArrayToHL(->SelectTables_as; ""; ->SelectTables_aL)
	For ($loop_L; $NumAlltables_L; 1; -1)
		If (Find in array:C230(SelectTables_aL; TableNos_aL{$loop_L})>0)
			DELETE FROM ARRAY:C228(TableNos_aL; $loop_L; 1)
			DELETE FROM ARRAY:C228(asTables; $loop_L; 1)
		End if 
		
	End for 
	
Else 
	OmitList_HL:=New list:C375
End if 
UseList_HL:=ut_ArrayToHL(->asTables; ""; ->TableNos_aL)
C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
vCancelBtntxt:="Cancel"
vOKBtnTxt:="Proceed"
vUseListLbl_txt:="Available Tables"
vOmitLbl_txt:="Selected Tables"
C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l; $numSelectTables_L; $i; $Ref)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt; $Name)
FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
DIALOG:C40("TwoListMove")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	$numSelectTables_L:=Count list items:C380(OmitList_HL)
	ARRAY LONGINT:C221(SelectTables_aL; $numSelectTables_L)
	ARRAY TEXT:C222(SelectTables_as; $numSelectTables_L)  //Command Replaced was o_ARRAY string length was 31
	ARRAY POINTER:C280($TblList_ptr->; $numSelectTables_L)
	For ($i; 1; $numSelectTables_L)
		GET LIST ITEM:C378(OmitList_HL; $i; $Ref; $Name)
		SelectTables_as{$i}:=$Name
		SelectTables_aL{$i}:=$Ref
		$TblList_ptr->{$i}:=Table:C252($Ref)
	End for 
	
End if 

If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 
TWOLIST_MOVEONLY_B:=False:C215  //set to the default