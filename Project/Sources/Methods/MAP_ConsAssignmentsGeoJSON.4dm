//%attributes = {"invisible":true}
//Method: MAP_ConsAssignmentsGeoJSON
//Description
// create a GeoJSON file for the current list of consultant assignments
// Can be run either from Cons inspections or Cons Ratings
// retrieve list of data items from parameters MAP_ConsInspFields or MAP_ConsRtgFields
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 7, 2023, 11:05:20
	Mods_2023_11
	// ----------------------------------------------------
	
End if 
//

//get current table
C_POINTER:C301($currTable_ptr)
$currTable_ptr:=Current form table:C627
C_TEXT:C284($datafieldsparam_txt; $BinRelation_txt)
C_COLLECTION:C1488($properties_c; $columns_c; $features_c; $datalabels_c; $dateformats_c)
$columns_c:=New collection:C1472
$datalabels_c:=New collection:C1472
C_TEXT:C284($mapFieldsinfo_txt)
C_OBJECT:C1216($mapFieldsinfo_o)
Case of 
	: ($currTable_ptr=(->[Cons Inspection:64]))
		$BinRelation_txt:="ConsInspToBIN"
		$mapFieldsinfo_txt:=ut_GetSysParameter("MAP_ConsInspFields")
		
	: ($currTable_ptr=(->[Conslt Rating:63]))
		$BinRelation_txt:="ConsRtgToBIN"
		$mapFieldsinfo_txt:=ut_GetSysParameter("MAP_ConsRtgFields")
		
End case 

$mapFieldsinfo_o:=JSON Parse:C1218($mapFieldsinfo_txt; Is object:K8:27)
$columns_c:=$mapFieldsinfo_o.fields.extract("column")
$datalabels_c:=$mapFieldsinfo_o.fields.extract("label")
$dateformats_c:=$mapFieldsinfo_o.fields.extract("dateformat")

//needed for the coordinates
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16A:68))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16A:68))
End if 
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16B:69))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16B:69))
End if 
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16C:109))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item16C:109))
End if 
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17A:70))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17A:70))
End if 
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17B:71))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17B:71))
End if 
If ($columns_c.indexOf($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17C:136))<0)
	$columns_c.push($BinRelation_txt+"."+Field name:C257(->[Bridge MHD NBIS:1]Item17C:136))
End if 

C_BOOLEAN:C305($continue_b)
$continue_b:=True:C214
C_OBJECT:C1216($currsel_o; $zeroloc_o)
$currsel_o:=Create entity selection:C1512($currTable_ptr->)
$zeroloc_o:=$currsel_o.query($BinRelation_txt+".Item16A = 0 OR "+$BinRelation_txt+".Item17A = 0")

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
	
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Generating GeoJSON file for "+String:C10($currSel_o.length)+" structures"; $currSel_o.length; True:C214; " Records"; 3)
	
	//build the columns to show
	
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
		C_OBJECT:C1216($prop_o; $geom_o; $modprops_o; $bin_o)
		C_COLLECTION:C1488($coords_c)
		Progress SET MESSAGE($progress_o.progress; "Building GeoJSON ...")
		
		For each ($prop_o; $properties_c)
			$bin_o:=$prop_o[$BinRelation_txt]
			$coords_c:=New collection:C1472(\
				(-1)*ut_DegMinSecToDeg($bin_o.Item17A; $bin_o.Item17B; $bin_o.Item17C); \
				ut_DegMinSecToDeg($bin_o.Item16A; $bin_o.Item16B; $bin_o.Item16C)\
				)
			$geom_o:=New object:C1471("coordinates"; $coords_c; "type"; "Point")
			
			//build the properties object
			$modprops_o:=MAP_BuildGeoJSONProperties(New object:C1471("prop"; $prop_o; "mapfields"; $mapFieldsinfo_o; "dateformat"; $dateoption_L))
			
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

//End MAP_ConsAssignmentsGeoJSON   