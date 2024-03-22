//%attributes = {"invisible":true}
//Method: MAP_BuildGeoJSON
//Description
// Build a GeoJSON file from the current list of bridges.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 1, 2023, 16:35:10
	Mods_2023_11
	// ----------------------------------------------------
	
End if 
//
ARRAY POINTER:C280(KML_LabelFields_aptr; 0)
ARRAY TEXT:C222(KML_FieldLabels_atxt; 0)
ARRAY POINTER:C280(KML_Fields_aptr; 0)
ARRAY TEXT:C222(KML_Fields_Value_atxt; 0)

C_BOOLEAN:C305($continue_b)
$continue_b:=True:C214
C_OBJECT:C1216($currSel_o; $zeroLoc_o)
$currSel_o:=Create entity selection:C1512([Bridge MHD NBIS:1])
$zeroLoc_o:=$currSel_o.query("Item16A = 0 OR Item17A = 0")

Case of 
	: ($currsel_o.length=0)
		ALERT:C41("There are no records listed!")
		$continue_b:=False:C215
		
	: ($zeroLoc_o.length=$currSel_o.length)
		ALERT:C41("There are no records with valid Lat/Lon positions to be plotted!")
		$continue_b:=False:C215
	: ($zeroLoc_o.length>0)
		ALERT:C41("There are "+String:C10($zeroLoc_o.length)+" records with invalid Lat/Lon coordinates! They will not be plotted!")
		
		$currSel_o:=$currSel_o.minus($zeroLoc_o)
End case 

If ($continue_b & ($currSel_o.length>200))
	CONFIRM:C162("There are "+String:C10($currSel_o.length)+" records to be included! Continue?")
	$continue_b:=(OK=1)
End if 


If ($continue_b)
	//get the fields to add to properties
	MAP_SetDataFields
	ARRAY TEXT:C222(KML_Fields_Value_atxt; Size of array:C274(KML_Fields_aptr))
	
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Generating GeoJSON file for "+String:C10($currSel_o.length)+" structures"; $currSel_o.length; True:C214; " Records"; 3)
	
	C_COLLECTION:C1488($properties_c; $columns_c; $features_c; $datalabels_c)
	$columns_c:=New collection:C1472
	$datalabels_c:=New collection:C1472
	ARRAY TEXT:C222($fieldTitles_atxt; 0)
	ARRAY LONGINT:C221($fieldNum_aL; 0)
	GET FIELD TITLES:C804([Bridge MHD NBIS:1]; $fieldTitles_atxt; $fieldNum_aL)
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(KML_Fields_aptr))
		$columns_c.push(Field name:C257(KML_Fields_aptr{$loop_L}))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(KML_Fields_aptr{$loop_L}))})
	End for 
	//make sure these columns are in the properties
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]BDEPT:1))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]BDEPT:1))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]BDEPT:1))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]BIN:3))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]BIN:3))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]BIN:3))})
	End if 
	//needed for the coordinates
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item16A:68))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item16A:68))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item16A:68))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item16B:69))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item16B:69))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item16B:69))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item16C:109))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item16C:109))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item16C:109))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item17A:70))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item17A:70))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item17A:70))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item17B:71))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item17B:71))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item17B:71))})
	End if 
	If ($columns_c.indexOf(Field name:C257(->[Bridge MHD NBIS:1]Item17C:136))<0)
		$columns_c.push(Field name:C257(->[Bridge MHD NBIS:1]Item17C:136))
		$dataLabels_c.push($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[Bridge MHD NBIS:1]Item17C:136))})
	End if 
	
	Progress SET PROGRESS($progress_o.progress; -1)
	Progress SET MESSAGE($progress_o.progress; "Collecting data...")
	
	$properties_c:=$currSel_o.toCollection($columns_c)
	
	If ($properties_c=Null:C1517)
		//user aborted .toCollection 
		Progress QUIT($progress_o.progress)
		
	Else 
		
		C_LONGINT:C283($dateoption_L)
		$dateoption_L:=MAP_SetDateFormat
		
		//build the features collection
		$features_c:=New collection:C1472
		C_OBJECT:C1216($prop_o; $geom_o; $modprops_o)
		C_COLLECTION:C1488($coords_c)
		Progress SET MESSAGE($progress_o.progress; "Building GeoJSON ...")
		
		For each ($prop_o; $properties_c)
			$coords_c:=New collection:C1472(\
				(-1)*ut_DegMinSecToDeg($prop_o.Item17A; $prop_o.Item17B; $prop_o.Item17C); \
				ut_DegMinSecToDeg($prop_o.Item16A; $prop_o.Item16B; $prop_o.Item16C)\
				)
			$geom_o:=New object:C1471("coordinates"; $coords_c; "type"; "Point")
			
			$modprops_o:=New object:C1471
			C_LONGINT:C283($prop_L)
			For ($prop_L; 0; ($columns_c.length-1))
				
				Case of 
					: (OB Get type:C1230($prop_o; $columns_c[$prop_L])=Is date:K8:7)
						$modProps_o[String:C10($prop_L; "00")+"-"+$dataLabels_c[$prop_L]]:=MAP_FormatDate($prop_o[$columns_c[$prop_L]]; $dateoption_L)
					Else 
						$modProps_o[String:C10($prop_L; "00")+"-"+$dataLabels_c[$prop_L]]:=$prop_o[$columns_c[$prop_L]]
						
				End case 
				
			End for 
			
			$features_c.push(New object:C1471(\
				"type"; "Feature"; \
				"properties"; $modprops_o; \
				"geometry"; $geom_o))
			
		End for each 
		
		C_OBJECT:C1216($geoJson_o)
		$geoJson_o:=New object:C1471("type"; "FeatureCollection"; "features"; $features_c)
		
		C_TEXT:C284($geoJson_txt)
		$geoJson_txt:=JSON Stringify:C1217($geoJson_o; *)
		
		Progress QUIT($progress_o.progress)
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

//End MAP_BuildGeoJSON   