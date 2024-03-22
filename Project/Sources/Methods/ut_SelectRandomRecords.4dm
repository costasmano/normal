//%attributes = {"invisible":true}
//Method: ut_SelectRandomRecords
//Description
// Create a random set of records from the current selection of a table
// Parameters
// $1 : $CurrTable_ptr
// $2 : $NumberOfRecords_L
// $3 : $Options_txt (highilght them, change the selection, put them in a set or selection)
// $4 : $SetorSelectionName_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/01/19, 14:17:35
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
	
	C_POINTER:C301(ut_SelectRandomRecords; $1)
	C_LONGINT:C283(ut_SelectRandomRecords; $2)
	C_TEXT:C284(ut_SelectRandomRecords; $3)
	C_TEXT:C284(ut_SelectRandomRecords; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(6/10/20 13:36:47)
	Mods_2020_06
	//  `force JSON Parse to return an object
End if 
//
C_TEXT:C284($paramS)
C_LONGINT:C283($Menu_L)
$Menu_L:=Menu selected:C152
C_POINTER:C301($Table_ptr)
C_LONGINT:C283($NumRecs)
C_TEXT:C284($Op_txt)
C_TEXT:C284($SelOrSetName_txt; $postprocCmd_txt)

If ($Menu_L=0)
	//not from a menu - need the parameters to the method
	C_POINTER:C301($1)
	$Table_ptr:=$1
	C_LONGINT:C283($2)
	$NumRecs:=$2
	C_TEXT:C284($3)
	$Op_txt:=$3
Else 
	//from a menu 
	$paramS:=Get selected menu item parameter:C1005
	//Params must be a json object
	//attributes are "numRecs", "option", "name"
	// {"numRecs":100,"option":"changeselection","name":"nameofsetorselection"}
	$Table_ptr:=Current form table:C627
	C_OBJECT:C1216($params_o)
	$params_o:=JSON Parse:C1218($paramS; Is object:K8:27)
	$NumRecs:=OB Get:C1224($params_o; "numRecs"; Is longint:K8:6)
	$Op_txt:=OB Get:C1224($params_o; "option"; Is text:K8:3)
	$SelOrSetName_txt:=OB Get:C1224($params_o; "name"; Is text:K8:3)
	$postprocCmd_txt:=OB Get:C1224($params_o; "postProc"; Is text:K8:3)
End if 

ARRAY LONGINT:C221($RecordNumbers_aL; 0)
LONGINT ARRAY FROM SELECTION:C647($Table_ptr->; $RecordNumbers_aL)
ARRAY LONGINT:C221($randomSet_aL; 0)
ut_GetRandomSet(->$RecordNumbers_aL; ->$randomSet_aL; $NumRecs)

Case of 
	: ($Op_txt="changesel@")
		CREATE SELECTION FROM ARRAY:C640($Table_ptr->; $randomSet_aL; "$TempSelection")
		USE NAMED SELECTION:C332("$TempSelection")
		CLEAR NAMED SELECTION:C333("$TempSelection")
		
	: ($Op_txt="Hilite")
		CREATE SET FROM ARRAY:C641($Table_ptr->; $randomSet_aL; "$TempSet")
		HIGHLIGHT RECORDS:C656($Table_ptr->; "$TempSet")
		CLEAR SET:C117("$TempSet")
		
	: ($Op_txt="createsel@")
		C_TEXT:C284($4)
		$SelOrSetName_txt:=$4
		CREATE SELECTION FROM ARRAY:C640($Table_ptr->; $randomSet_aL; $SelOrSetName_txt)
		
	: ($Op_txt="createset@")
		C_TEXT:C284($4)
		$SelOrSetName_txt:=$4
		CREATE SET FROM ARRAY:C641($Table_ptr->; $randomSet_aL; $SelOrSetName_txt)
		
End case 

If ($postprocCmd_txt#"")
	EXECUTE FORMULA:C63($postprocCmd_txt)
End if 

//End ut_SelectRandomRecords