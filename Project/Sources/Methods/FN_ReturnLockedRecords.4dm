//%attributes = {"invisible":true,"publishedSql":true,"executedOnServer":true}
//Method: FN_ReturnLockedRecords
//This method will run ion the server
//Description
//This method will return locked data for records being loaded by sql
// Parameters
// ----------------------------------------------------
//$1 blob which contains in sequence
//Table number variable
//Key field variable
//Type of key ("NUMBER" or anything else
//Key itself as text

If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/13/19, 14:45:39
	// ----------------------------------------------------
	//Created : 
	
	//Created by: Chuck Miller (8/15/19 14:06:06)
	//Example call below
	//If $Type_txt is = NUMBERR key and query used will be using $KeyValue_L otherwise it will be 
	//using $KeyValue_txt
	//VARIABLE TO BLOB($TableNumber_L;Send_Blb;*)
	//VARIABLE TO BLOB($FieldNumber_L;Send_Blb;*)
	//VARIABLE TO BLOB($Type_txt;Send_Blb;*)
	//VARIABLE TO BLOB($KeyValue_txt;Send_Blb;*)
	
	//SQLQuery_txt:="SELECT {fn FN_ReturnLockedRecords(<<Send_Blb>>) AS BLOB} from preferences INTO :Receive_Blb"
	//It can also be called without sql
	//  //$Return_blb:=fn_ReturnLockedRecords(Send_Blb)
	Mods_2019_08
End if 
//
C_BLOB:C604($0; $1; $RETURN_BLB)

//$RETURN_BLB:=ut_returnLockedBy($RETURN_BLB)
C_LONGINT:C283($Table_L; $keyField_L; $KeyValue_L)
C_TEXT:C284($Type_txt; $KeyValue_txt)

C_LONGINT:C283($Offset_L)
$Offset_L:=0
BLOB TO VARIABLE:C533($1; $Table_L; $Offset_L)
BLOB TO VARIABLE:C533($1; $keyField_L; $Offset_L)
BLOB TO VARIABLE:C533($1; $Type_txt; $Offset_L)

BLOB TO VARIABLE:C533($1; $KeyValue_txt; $Offset_L)
C_BOOLEAN:C305($UseNumber_B)
$UseNumber_B:=True:C214

$UseNumber_B:=($Type_txt="NUMBER")
If ($UseNumber_B)
	$KeyValue_L:=Num:C11($KeyValue_txt)
End if 
C_POINTER:C301($Table_ptr; $Field_ptr)
$Table_ptr:=Table:C252($Table_L)
$Field_ptr:=Field:C253($Table_L; $keyField_L)


If ($UseNumber_B)
	QUERY:C277($Table_ptr->; $Field_ptr->=$KeyValue_L)
Else 
	QUERY:C277($Table_ptr->; $Field_ptr->=$KeyValue_txt)
End if 
C_LONGINT:C283($Process_L)
C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)

LOCKED BY:C353($Table_ptr->; $Process_L; $User_txt; $Machine_txt; $ProcessName_txt)

C_BLOB:C604($RETURN_BLB)
SET BLOB SIZE:C606($RETURN_BLB; 0)
VARIABLE TO BLOB:C532($User_txt; $RETURN_BLB; *)
VARIABLE TO BLOB:C532($Machine_txt; $RETURN_BLB; *)
VARIABLE TO BLOB:C532($ProcessName_txt; $RETURN_BLB; *)

$0:=$RETURN_BLB

//End FN_ReturnLockedRecords