//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 17:30:42
//----------------------------------------------------
//Method: utl_ExportInpectionTypes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 17:30:44)
	
End if 
C_LONGINT:C283(TableNumber_L)
ALL RECORDS:C47([Inspection Type:31])
TableNumber_L:=Table:C252(->[Inspection Type:31])
CREATE SET:C116([Inspection Type:31]; "QuerySet")

ut_OpenNewWindow(800; 700; 0; Plain form window:K39:10; "Select Inspection Types to Export"; "ut_CloseCancel")

DIALOG:C40("ExportLocalToImport")
CLOSE WINDOW:C154
C_LONGINT:C283($Size_L)
$Size_L:=Records in selection:C76([Inspection Type:31])

If (OK=1) & ($Size_L>0)
	
	ARRAY TEXT:C222($Code_atxt; 0)
	ARRAY TEXT:C222($Description_atxt; 0)
	ARRAY TEXT:C222($ElementNumbers_atxt; 0)
	
	ARRAY TEXT:C222($Code_atxt; $Size_L)
	ARRAY TEXT:C222($Description_atxt; $Size_L)
	ARRAY TEXT:C222($ElementNumbers_atxt; $Size_L)
	
	C_BLOB:C604($Document_blb)
	SET BLOB SIZE:C606($Document_blb; 0)
	
	SELECTION RANGE TO ARRAY:C368(1; $Size_L; [Inspection Type:31]Code:1; $Code_atxt; [Inspection Type:31]Description:2; $Description_atxt; [Inspection Type:31]ElementNumbers_txt:4; $ElementNumbers_atxt)
	
	
	VARIABLE TO BLOB:C532($Code_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($Description_atxt; $Document_blb; *)
	VARIABLE TO BLOB:C532($ElementNumbers_atxt; $Document_blb; *)
	
	C_TEXT:C284($Path_txt)
	
	$Path_txt:=Select folder:C670("Select folder to store [Inspection Type]"; "")
	If (OK=1)
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266($Path_txt+"Inspection_Type.txt")
		CLOSE DOCUMENT:C267($Doc_tm)
		
		BLOB TO DOCUMENT:C526(Document; $Document_blb)
		ALERT:C41("Exported :"+String:C10($Size_L)+" Inspection Types")
		
	End if 
End if 
//End utl_ExportInpectionTypes