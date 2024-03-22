//%attributes = {"invisible":true}
//Method: MAP_BuildTunnelGeoJSON
//Description
// build a GeoJson file from the current list of tunnel structures
// uses parameter MAP_TunnelStructFlds
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 13, 2023, 09:29:06
	Mods_2023_11
	// ----------------------------------------------------
	
End if 
//

C_BOOLEAN:C305($continue_b)
$continue_b:=True:C214

C_OBJECT:C1216($currsel_o; $zeroloc_o)
$currsel_o:=Create entity selection:C1512([NTI_TunnelInfo:181])
$zeroloc_o:=$currsel_o.query(Field name:C257(->[NTI_TunnelInfo:181]NTI_i13_r:18)+" = 0 or "+\
Field name:C257(->[NTI_TunnelInfo:181]NTI_i14_r:19)+" = 0")

Case of 
	: ($currsel_o.length=0)
		ALERT:C41("There are no records listed!")
		$continue_b:=False:C215
	: ($zeroloc_o.length=$currsel_o.length)
		ALERT:C41("There are no records with valid Lat/Lon positions to be plotted!")
		$continue_b:=False:C215
	: ($zeroLoc_o.length>0)
		ALERT:C41("There are "+String:C10($zeroLoc_o.length)+" records with invalid Lat/Lon coordinates! They will not be included!")
		$currSel_o:=$currSel_o.minus($zeroLoc_o)
End case 

If ($continue_b & ($currSel_o.length>200))
	CONFIRM:C162("GeoJSON file for "+String:C10($currSel_o.length; "###,###,####")+" records will be generated! This will take some time! Continue?")
	$continue_b:=(OK=1)
End if 

If ($continue_b)
	
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Generating GeoJSON file for "+String:C10($currSel_o.length)+" structures"; $currSel_o.length; True:C214; " Records"; 3)
	
	C_COLLECTION:C1488($properties_c; $columns_c; $features_c; $dataLabels_c)
	
	C_TEXT:C284($mapFieldsinfo_txt)
	C_OBJECT:C1216($mapFieldsinfo_o)
	$mapFieldsinfo_txt:=ut_GetSysParameter("MAP_TunnelStructFlds")
	$mapFieldsinfo_o:=JSON Parse:C1218($mapFieldsinfo_txt; Is object:K8:27)
	$columns_c:=$mapFieldsinfo_o.fields.extract("column")
	
	Progress SET PROGRESS($progress_o.progress; -1)
	Progress SET MESSAGE($progress_o.progress; "Collecting data...")
	
	$properties_c:=$currSel_o.toCollection($columns_c)
	
	If ($properties_c=Null:C1517)
		//collection will be null if user cancels out of .toCollection
		Progress QUIT($progress_o.progress)
		
	Else 
		C_LONGINT:C283($dateoption_L)
		$dateoption_L:=MAP_SetDateFormat
		
		//build the features collection
		$features_c:=New collection:C1472
		C_OBJECT:C1216($prop_o; $geom_o; $modProps_o)
		C_COLLECTION:C1488($coords_c)
		C_LONGINT:C283($count_L)
		$count_L:=0
		For each ($prop_o; $properties_c)
			//update progress
			$count_L:=$count_L+1
			UpdateProgressNew($progress_o; $count_L)
			
			$coords_c:=New collection:C1472($prop_o.NTI_i14_r; $prop_o.NTI_i13_r)
			$geom_o:=New object:C1471("coordinates"; $coords_c; "type"; "Point")
			
			//build the properties object
			$modprops_o:=MAP_BuildGeoJSONProperties(New object:C1471("prop"; $prop_o; "mapfields"; $mapFieldsinfo_o; "dateformat"; $dateoption_L))
			
			$features_c.push(New object:C1471(\
				"type"; "Feature"; \
				"properties"; $modProps_o; \
				"geometry"; $geom_o))
			
		End for each 
		
		C_OBJECT:C1216($geoJson_o)
		$geoJson_o:=New object:C1471("type"; "FeatureCollection"; "features"; $features_c)
		
		Progress SET PROGRESS($progress_o.progress; -1)
		Progress SET MESSAGE($progress_o.progress; "Converting to GeoJSON...")
		
		C_TEXT:C284($geoJson_txt)
		$geoJson_txt:=JSON Stringify:C1217($geoJson_o; *)
		
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		DELAY PROCESS:C323(Current process:C322; 5)  // so progress bar can close
		
		
		C_TEXT:C284($geojsonFile_txt)
		$geojsonFile_txt:=Select document:C905(""; "geojson"; "Select GeoJSON file"; File name entry:K24:17)
		
		If (OK=1)
			C_OBJECT:C1216($geojsonFile_o)
			$geojsonFile_o:=File:C1566(Document; fk platform path:K87:2)
			$geojsonFile_o.setText($geoJson_txt)
			
			MAP_OpenSite
			
			SHOW ON DISK:C922(Document)
			
		End if 
		
		
	End if 
	
End if 

//End MAP_BuildTunnelGeoJSON   