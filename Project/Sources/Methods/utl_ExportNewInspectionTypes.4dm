//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/15/13, 10:47:55
//----------------------------------------------------
//Method: utl_ExportNewInspectionTypes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (1/15/13 10:47:56)
	
End if 
C_BLOB:C604($Document_blb)
SET BLOB SIZE:C606($Document_blb; 0)
ARRAY TEXT:C222($inspectionCodes_atxt; 0)
ARRAY TEXT:C222($Descriptions_atxt; 0)
ARRAY TEXT:C222($ElementNumbers_atxt; 0)
QUERY:C277([Inspection Type:31])

SELECTION TO ARRAY:C260([Inspection Type:31]Code:1; $inspectionCodes_atxt; [Inspection Type:31]Description:2; $Descriptions_atxt; [Inspection Type:31]ElementNumbers_txt:4; $ElementNumbers_atxt)
VARIABLE TO BLOB:C532($inspectionCodes_atxt; $Document_blb; *)
VARIABLE TO BLOB:C532($Descriptions_atxt; $Document_blb; *)
VARIABLE TO BLOB:C532($ElementNumbers_atxt; $Document_blb; *)
C_TEXT:C284($Path_txt)
$Path_txt:=Select folder:C670("Select folder to store new or modified inspection types"; "")

C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Path_txt+"ExportedinspectionTypes.txt")
CLOSE DOCUMENT:C267($Doc_tm)

BLOB TO DOCUMENT:C526(Document; $Document_blb)



//End utl_ExportNewInspectionTypes

