//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 16:29:08
//----------------------------------------------------
//Method: utl_ExportTOLRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 16:29:11)
	
End if 
C_LONGINT:C283(TableNumber_L)
TableNumber_L:=Table:C252(->[TableOfLists:125])
ALL RECORDS:C47([TableOfLists:125])
C_BOOLEAN:C305($Complete_b)

ARRAY TEXT:C222(ListNames_atxt; 0)
C_TEXT:C284($Path_txt)
DISTINCT VALUES:C339([TableOfLists:125]ListName_s:1; ListNames_atxt)
REDUCE SELECTION:C351([TableOfLists:125]; 0)
$Path_txt:=Select folder:C670("Select Export Path For [TableOfLists] exports..")
ut_OpenNewWindow(800; 700; 0; Plain form window:K39:10; "Select Table of Lists to Export"; "ut_CloseCancel")
$Complete_b:=False:C215
C_BLOB:C604($Blob_b)
C_TIME:C306($Doc_tm)
C_LONGINT:C283($Size_L)

Repeat 
	DIALOG:C40("ExportLocalToImport")
	$Size_L:=Records in selection:C76([TableOfLists:125])
	If (OK=1) & ($Size_L>0)
		$Doc_tm:=Create document:C266($Path_txt+TOL_ListName_txt+".txt")
		CLOSE DOCUMENT:C267($Doc_tm)
		SET BLOB SIZE:C606($Blob_b; 0)
		ARRAY LONGINT:C221($ListKeys_al; 0)
		ARRAY LONGINT:C221($ListSequence_al; 0)
		ARRAY TEXT:C222($ListValue_atxt; 0)
		ARRAY LONGINT:C221($ListKeys_al; $Size_L)
		ARRAY LONGINT:C221($ListSequence_al; $Size_L)
		ARRAY TEXT:C222($ListValue_atxt; $Size_L)
		
		SELECTION RANGE TO ARRAY:C368(1; $Size_L; [TableOfLists:125]ListKeyID_L:4; $ListKeys_al; [TableOfLists:125]ListSequence_l:3; $ListSequence_al; [TableOfLists:125]ListValue_s:2; $ListValue_atxt)
		
		VARIABLE TO BLOB:C532($ListKeys_al; $Blob_b; *)
		VARIABLE TO BLOB:C532($ListSequence_al; $Blob_b; *)
		VARIABLE TO BLOB:C532($ListValue_atxt; $Blob_b; *)
		BLOB TO DOCUMENT:C526(Document; $Blob_b)
		
	Else 
		$Complete_b:=True:C214
	End if 
	
Until ($Complete_b)
CLOSE WINDOW:C154

//End utl_ExportTOLRecords