//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/15/13, 12:41:38
//----------------------------------------------------
//Method: utl_ExportElementDictionary
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (1/15/13 12:41:39)
	
End if 
C_BLOB:C604($Document_blb)
SET BLOB SIZE:C606($Document_blb; 0)
ARRAY TEXT:C222($Category_atxt; 0)
ARRAY DATE:C224($Created_ad; 0)
ARRAY TEXT:C222($Description_atxt; 0)
ARRAY INTEGER:C220($ElementNo_ai; 0)
ARRAY TEXT:C222($FullLabel_atxt; 0)
ARRAY TEXT:C222($FullLabelArch_atxt; 0)
ARRAY BOOLEAN:C223($IsParent_ab; 0)
ARRAY INTEGER:C220($Parent_ai; 0)
ARRAY TEXT:C222($Prefix_atxt; 0)
ARRAY LONGINT:C221($TimeCreated_al; 0)
ALL RECORDS:C47([ElementDict:30])
TableNumber_L:=Table:C252(->[ElementDict:30])
CREATE SET:C116([ElementDict:30]; "QuerySet")

ut_OpenNewWindow(800; 700; 0; Plain form window:K39:10; "Select Element Dictionary to Export"; "ut_CloseCancel")
DIALOG:C40("ExportLocalToImport")
CLOSE WINDOW:C154

If (OK=1)
	SELECTION TO ARRAY:C260([ElementDict:30]Category:3; $Category_atxt; [ElementDict:30]Description:2; $Description_atxt; [ElementDict:30]ElementNo:1; $ElementNo_ai; [ElementDict:30]FullLabel:13; $FullLabel_atxt; [ElementDict:30]FullLabelArch:14; $FullLabelArch_atxt; [ElementDict:30]IsParent:5; $IsParent_ab; [ElementDict:30]Parent:4; $Parent_ai; [ElementDict:30]Prefix:11; $Prefix_atxt)
	
	VARIABLE TO BLOB:C532($Category_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($Description_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($ElementNo_ai; $Document_blb; *)
	VARIABLE TO BLOB:C532($FullLabel_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($FullLabelArch_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($IsParent_ab; $Document_blb; *)
	VARIABLE TO BLOB:C532($Parent_ai; $Document_blb; *)
	VARIABLE TO BLOB:C532($Prefix_atxt; $Document_blb; *)
	
	C_TEXT:C284($Path_txt)
	
	$Path_txt:=Select folder:C670("Select folder to store element dictionary"; "")
	If (OK=1)
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266($Path_txt+"ElementDictionary.txt")
		CLOSE DOCUMENT:C267($Doc_tm)
		
		BLOB TO DOCUMENT:C526(Document; $Document_blb)
		ALERT:C41("Exported :"+String:C10(Size of array:C274($Category_atxt))+" Element Dictionary records")
	End if 
End if 
//End utl_ExportElementDictionary