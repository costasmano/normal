//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 17:10:56
//----------------------------------------------------
//Method: utl_ExportElementCat
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 17:10:59)
	
End if 
C_LONGINT:C283(TableNumber_L)
ALL RECORDS:C47([Element Cat:32])
TableNumber_L:=Table:C252(->[Element Cat:32])
CREATE SET:C116([Element Cat:32]; "QuerySet")

ut_OpenNewWindow(800; 700; 0; Plain form window:K39:10; "Select Element Categories to Export"; "ut_CloseCancel")

DIALOG:C40("ExportLocalToImport")
CLOSE WINDOW:C154
C_LONGINT:C283($Size_L)
$Size_L:=Records in selection:C76([Element Cat:32])

If (OK=1) & ($Size_L>0)
	ARRAY TEXT:C222($ElementCode_atxt; 0)
	ARRAY BOOLEAN:C223($ElementCulvert_ab; 0)
	ARRAY TEXT:C222($ElementDescription_atxt; 0)
	ARRAY BOOLEAN:C223($ElementRegular_ab; 0)
	ARRAY TEXT:C222($ElementCode_atxt; $Size_L)
	ARRAY BOOLEAN:C223($ElementCulvert_ab; $Size_L)
	ARRAY TEXT:C222($ElementDescription_atxt; $Size_L)
	ARRAY BOOLEAN:C223($ElementRegular_ab; $Size_L)
	C_BLOB:C604($Document_blb)
	SET BLOB SIZE:C606($Document_blb; 0)
	
	SELECTION RANGE TO ARRAY:C368(1; $Size_L; [Element Cat:32]Code:1; $ElementCode_atxt; [Element Cat:32]CulvertElement:3; $ElementCulvert_ab; [Element Cat:32]Description:2; $ElementDescription_atxt; [Element Cat:32]RegularElement:4; $ElementRegular_ab)
	VARIABLE TO BLOB:C532($ElementCode_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($ElementCulvert_ab; $Document_blb; *)
	VARIABLE TO BLOB:C532($ElementDescription_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($ElementRegular_ab; $Document_blb; *)
	
	C_TEXT:C284($Path_txt)
	
	$Path_txt:=Select folder:C670("Select folder to store [Element Cat]"; "")
	If (OK=1)
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266($Path_txt+"ElementDictionary.txt")
		CLOSE DOCUMENT:C267($Doc_tm)
		
		BLOB TO DOCUMENT:C526(Document; $Document_blb)
		ALERT:C41("Exported :"+String:C10($Size_L)+" Element Categories")
	End if 
End if 

//End utl_ExportElementCat