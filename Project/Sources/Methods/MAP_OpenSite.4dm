//%attributes = {"invisible":true}
//Method: MAP_OpenSite
//Description
// open a mapping site from sites in parameter "MAP_Mappingsites"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 6, 2023, 12:46:13
	Mods_2023_11
	// ----------------------------------------------------
End if 
//
C_TEXT:C284($mapsites_txt; $prevErrCall_txt)
$mapsites_txt:=ut_GetSysParameter("MAP_MappingSites")
If ($mapsites_txt="")
	ALERT:C41("Parameter MAP_MappingSites does not contain any data")
Else 
	C_OBJECT:C1216($mapsites_o)
	$prevErrCall_txt:=Method called on error:C704
	ON ERR CALL:C155("4D_Errors")
	C_BOOLEAN:C305(4DError_b)
	4DError_b:=False:C215
	$mapsites_o:=JSON Parse:C1218($mapsites_txt; Is object:K8:27)
	ON ERR CALL:C155($prevErrCall_txt)
	If (4DError_b)
		ALERT:C41("Parameter MAP_MappingSites is not formatted correctly!")
	Else 
		C_COLLECTION:C1488($mapsites_c)
		$mapsites_c:=$mapsites_o.Sites
		ARRAY TEXT:C222($sites_atxt; 0)
		ARRAY TEXT:C222($siteUrl_atxt; 0)
		COLLECTION TO ARRAY:C1562($mapsites_c; $sites_atxt; "name"; $siteUrl_atxt; "url")
		C_LONGINT:C283($mapchoice_L)
		$mapchoice_L:=G_PickFromList(->$sites_atxt; "Choose a Site to open")
		
		If ($mapchoice_L>0)
			OPEN URL:C673($siteUrl_atxt{$mapchoice_L}; *)
		End if 
		
	End if 
End if 

//End MAP_OpenSite   