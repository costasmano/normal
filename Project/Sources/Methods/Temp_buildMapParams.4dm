//%attributes = {"invisible":true}
//Method: Temp_buildMapParams
//Description
// build and save some map parameters used in creating GeoJSON files
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 7, 2023, 17:09:53
	Mods_2023_11
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(2023-11-13 11:09:58)
	Mods_2023_11
	//  `update for tunnels
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	C_COLLECTION:C1488($columns_c; $datalabels_c)
	$datalabels_c:=New collection:C1472
	$columns_c:=New collection:C1472
	C_OBJECT:C1216($param_o)
	$columns_c.push(New object:C1471("column"; "ConContractNo"; "label"; "Contract"))
	$columns_c.push(New object:C1471("column"; "AssignConNumber"; "label"; "Assignment"))
	$columns_c.push(New object:C1471("column"; "ConsInspToBIN.Town Name"; "label"; "Town name"))
	$columns_c.push(New object:C1471("column"; "ConsInspToBIN.Item8"; "label"; "Item8"))
	$columns_c.push(New object:C1471("column"; "ConsInspToBIN.Item7"; "label"; "Item7"))
	$columns_c.push(New object:C1471("column"; "ConsInspToBIN.Item6A"; "label"; "Item6A"))
	$columns_c.push(New object:C1471("column"; "InspMonth"; "label"; "InspMonth"))
	$columns_c.push(New object:C1471("column"; "InspType"; "label"; "Insp Type"))
	$columns_c.push(New object:C1471("column"; "AssignConName"; "label"; "Consultant"))
	$columns_c.push(New object:C1471("column"; "AssignStatus"; "label"; "Status"))
	
	$param_o:=New object:C1471("fields"; $columns_c)
	C_TEXT:C284($param_txt)
	$param_txt:=JSON Stringify:C1217($param_o; *)
	ut_SaveSysParam("MAP_ConsInspFields"; $param_txt)
	
	$datalabels_c:=New collection:C1472
	$columns_c:=New collection:C1472
	$columns_c.push(New object:C1471("column"; "ContractNoRat"; "label"; "Contract"))
	$columns_c.push(New object:C1471("column"; "AssignNoRat"; "label"; "Assignment"))
	$columns_c.push(New object:C1471("column"; "ContractType"; "label"; "Contract Type"))
	$columns_c.push(New object:C1471("column"; "ConsRtgToBIN.Town Name"; "label"; "Town name"))
	$columns_c.push(New object:C1471("column"; "ConsRtgToBIN.Item8"; "label"; "Item8"))
	$columns_c.push(New object:C1471("column"; "ConsRtgToBIN.Item7"; "label"; "Item7"))
	$columns_c.push(New object:C1471("column"; "ConsRtgToBIN.Item6A"; "label"; "Item6A"))
	$columns_c.push(New object:C1471("column"; "ProceedRat"; "label"; "NTP Date"))
	$columns_c.push(New object:C1471("column"; "CRtgSource"; "label"; "Source"))
	$columns_c.push(New object:C1471("column"; "AssignRatCons"; "label"; "Consultant"))
	$columns_c.push(New object:C1471("column"; "AssignStatus"; "label"; "Status"))
	
	$param_o:=New object:C1471("fields"; $columns_c)
	C_TEXT:C284($param_txt)
	$param_txt:=JSON Stringify:C1217($param_o; *)
	ut_SaveSysParam("MAP_ConsRtgFields"; $param_txt)
	
	ARRAY TEXT:C222($fieldtitles_atxt; 0)
	ARRAY LONGINT:C221($fieldNum_aL; 0)
	GET FIELD TITLES:C804([LSS_Inventory:165]; $fieldtitles_atxt; $fieldNum_aL)
	
	$columns_c:=New collection:C1472  // collection of data to use as properties 
	$dataLabels_c:=New collection:C1472  // collection of labels to use for the properties
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_StructureNumber_s:6); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_StructureNumber_s:6))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Category_s:2); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Category_s:2))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_StructureLocation_txt:10); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_StructureLocation_txt:10))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Status_s:35); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Status_s:35))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Town_s:4); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Town_s:4))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Route_s:9); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Route_s:9))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_RouteDirection_s:14); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_RouteDirection_s:14))}))
	$columns_c.push(New object:C1471("column"; "Link_116.LSS_Description_txt"; "label"; "Structure Type"))  // structure type
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Latitude_r:19); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Latitude_r:19))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[LSS_Inventory:165]LSS_Longitude_r:18); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[LSS_Inventory:165]LSS_Longitude_r:18))}))
	
	$param_o:=New object:C1471("fields"; $columns_c)
	C_TEXT:C284($param_txt)
	$param_txt:=JSON Stringify:C1217($param_o; *)
	ut_SaveSysParam("MAP_AncStructureFlds"; $param_txt)
	
	
	ARRAY TEXT:C222($fieldtitles_atxt; 0)
	ARRAY LONGINT:C221($fieldNum_aL; 0)
	GET FIELD TITLES:C804([NTI_TunnelInfo:181]; $fieldtitles_atxt; $fieldNum_aL)
	
	$columns_c:=New collection:C1472  // collection of data to use as properties 
	$dataLabels_c:=New collection:C1472  // collection of labels to use for the properties
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i1_s:6); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i1_s:6))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i2_s:7); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i2_s:7))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_TownName_s:71); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_TownName_s:71))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i6_s:11); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i6_s:11))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i10_s:15); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i10_s:15))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i11_s:16); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i11_s:16))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_InspResp:73); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_InspResp:73))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_Segment_s:74); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_Segment_s:74))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_Contracts_s:75); "label"; $fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_Contracts_s:75))}))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i13_r:18); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i13_r:18))})))
	$columns_c.push(New object:C1471("column"; Field name:C257(->[NTI_TunnelInfo:181]NTI_i14_r:19); "label"; Uppercase:C13($fieldtitles_atxt{Find in array:C230($fieldNum_aL; Field:C253(->[NTI_TunnelInfo:181]NTI_i14_r:19))})))
	
	$param_o:=New object:C1471("fields"; $columns_c)
	C_TEXT:C284($param_txt)
	$param_txt:=JSON Stringify:C1217($param_o; *)
	ut_SaveSysParam("MAP_TunnelStructFlds"; $param_txt)
	
End if 


//End Temp_buildMapParams   