//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/27/15, 11:40:01
//----------------------------------------------------
//Method: utl_ExportTOLFromArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/27/15 11:40:02)
	
End if 
C_POINTER:C301($1; $Array_ptr; $3; $Path_ptr)
$Array_ptr:=$1
C_TEXT:C284($2; $ListName_txt)
$ListName_txt:=$2
$Path_ptr:=$3
C_TEXT:C284($Path_txt)
If ($Path_ptr->="")
	
	$Path_txt:=Select folder:C670("Select Folder to export TOL Array to"; "")
Else 
	$Path_txt:=$Path_ptr->
	//$Path_txt:=Select folder("Select Folder to export TOL Array to";$Path_txt)
End if 
C_TIME:C306($Doc_tm)
C_LONGINT:C283($Size_L; $Loop_L)
$Size_L:=Size of array:C274($Array_ptr->)
ARRAY LONGINT:C221($ListKeys_al; 0)
ARRAY LONGINT:C221($ListSequence_al; 0)
ARRAY TEXT:C222($ListValue_atxt; 0)
ARRAY LONGINT:C221($ListKeys_al; $Size_L)
ARRAY LONGINT:C221($ListSequence_al; $Size_L)
ARRAY TEXT:C222($ListValue_atxt; $Size_L)
C_BLOB:C604($Blob_b)
SET BLOB SIZE:C606($Blob_b; 0)
For ($Loop_L; 1; $Size_L)
	$ListKeys_al{$Loop_L}:=0
	$ListSequence_al{$Loop_L}:=$Loop_L*10
	$ListValue_atxt{$Loop_L}:=$Array_ptr->{$Loop_L}
End for 

$Doc_tm:=Create document:C266($Path_txt+$ListName_txt+".txt")
CLOSE DOCUMENT:C267($Doc_tm)
VARIABLE TO BLOB:C532($ListKeys_al; $Blob_b; *)
VARIABLE TO BLOB:C532($ListSequence_al; $Blob_b; *)
VARIABLE TO BLOB:C532($ListValue_atxt; $Blob_b; *)

BLOB TO DOCUMENT:C526(Document; $Blob_b)
$3->:=$Path_txt

//End utl_ExportTOLFromArrays