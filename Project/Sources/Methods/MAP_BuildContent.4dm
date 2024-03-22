//%attributes = {"invisible":true}
//Method: MAP_BuildContent
//Description
// Builds a KML file from the current list of bridges 
//- requires BridgesTemplate.KML in MAP folder in Resources
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/27/16, 08:42:42
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	// Modified by: Costas Manousakis-(Designer)-(2023-11-06 15:17:16)
	Mods_2023_11
	//  `use method RES_Load_to_Blob to load the kml template, call MAP_OpenSite at the end
	//  `don't use the KML_DocName_txt variable - removed from kml template
	
End if 
//

ARRAY POINTER:C280(KML_LabelFields_aptr; 0)
ARRAY POINTER:C280(KML_Fields_aptr; 0)
ARRAY TEXT:C222(KML_FieldLabels_atxt; 0)
ARRAY TEXT:C222(KML_Fields_Value_atxt; 0)
MAP_SetLabelFields
MAP_SetDataFields
ARRAY TEXT:C222(KML_Fields_Value_atxt; Size of array:C274(KML_Fields_aptr))

C_TEXT:C284(KML_DocDescription_txt; KML_DocName_txt; KML_DocTitle_txt; KML_BridgeName_txt)
C_REAL:C285(KML_BridgeLon_r; KML_BridgeLat_r)
C_TEXT:C284($templVers_txt)
C_BLOB:C604($templatexml_blb; $xmlexport_blb)
$templVers_txt:=""
If (Application version:C493="11@")
	$templVers_txt:=" v11"
End if 

//start of Mods_2023_11
$templatexml_blb:=RES_Load_to_Blob("MAP"; "BridgesTemplate"+$templVers_txt+".kml")

If (BLOB size:C605($templatexml_blb)>0)
	//end of Mods_2023_11
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "InvalidPosSet")
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item16A:68<=0; *)
	QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item17A:70<=0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_BOOLEAN:C305($continue_b)
	$continue_b:=True:C214
	
	Case of 
		: (Records in set:C195("InvalidPosSet")=Records in selection:C76([Bridge MHD NBIS:1]))
			ALERT:C41("There are no records with valid Lat/Lon positions to be plotted!")
			$continue_b:=False:C215
		: (Records in set:C195("InvalidPosSet")>0)
			ALERT:C41("There are "+String:C10(Records in set:C195("InvalidPosSet"))+" records with invalid Lat/Lon coordinates! They will not be plotted!")
			
			CREATE SET:C116([Bridge MHD NBIS:1]; "ValidPosSet")
			DIFFERENCE:C122("ValidPosSet"; "InvalidPosSet"; "ValidPosSet")
			USE SET:C118("ValidPosSet")
			CLEAR SET:C117("ValidPosSet")
	End case 
	
	CLEAR SET:C117("InvalidPosSet")
	If ($continue_b)
		
		
		KML_DocDescription_txt:="Map of "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" Bridge Records "+String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))
		//KML_DocName_txt:="Bridge Export to KML layer"//start of Mods_2023_11
		KML_DocTitle_txt:="Bridge Export map"
		KML_DocTitle_txt:=Request:C163("Enter a name for the map"; KML_DocTitle_txt)
		KML_DocDescription_txt:=Request:C163("Enter a description for the map"; KML_DocDescription_txt)
		//KML_DocName_txt:=Request("Enter a short name for the KML layer";KML_DocName_txt) //start of Mods_2023_11
		
		SHORT_MESSAGE("Exporting....")
		C_TIME:C306($start_t; $end_t; $duration_t)
		$start_t:=Current time:C178(*)
		PROCESS 4D TAGS:C816($templatexml_blb; $xmlexport_blb)
		CLOSE WINDOW:C154
		$end_t:=Current time:C178(*)
		//ALERT("Duration : "+String($end_t-$start_t))
		C_TIME:C306($export_t)
		$export_t:=Create document:C266(""; ".kml")
		
		If (OK=1)
			C_TEXT:C284($export_txt)
			$export_txt:=document
			CLOSE DOCUMENT:C267($export_t)
			BLOB TO DOCUMENT:C526($export_txt; $xmlexport_blb)
			//start of Mods_2023_11
			MAP_OpenSite
			//end of Mods_2023_11
			SHOW ON DISK:C922($export_txt; *)
			
		End if 
		
	End if 
Else 
	ALERT:C41("Missing template in Resources or Parameters :["+"BridgesTemplate"+$templVers_txt+".kml]")
End if 
//End MAP_BuildContent