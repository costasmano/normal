//%attributes = {"invisible":true}
//Method: MAP_BuildGeoJSONProperties
//Description
// build the properties object for GeoJSON
// Parameters
// $0: $properties_o
// $1 : $info_o : info object 
//     .prop : dataobject
//     .mapfields : object with a fields collection with the columns, labels and any formating
//     .dateformat : default date format
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 13, 2023, 14:11:07
	Mods_2023_11
	// ----------------------------------------------------
	
	C_OBJECT:C1216(MAP_BuildGeoJSONProperties; $0; $1)
	
End if 
//
C_OBJECT:C1216($0; $1)

C_OBJECT:C1216($prop_o; $mapFieldsinfo_o)
$prop_o:=$1.prop
$mapFieldsinfo_o:=$1.mapfields
C_LONGINT:C283($dateoption_L)
$dateoption_L:=$1.dateformat

C_LONGINT:C283($prop_L)
C_OBJECT:C1216($field_o; $modprops_o)
$modprops_o:=New object:C1471

$prop_L:=0
For each ($field_o; $mapFieldsinfo_o.fields)
	
	Case of 
		: ($field_o.label=Null:C1517)
			//nothing
		: (Position:C15("."; $field_o.column)>0)
			$prop_L:=$prop_L+1
			C_COLLECTION:C1488($parts_c)
			C_OBJECT:C1216($trace_o)
			C_TEXT:C284($part_txt; $lastProp_txt)
			$parts_c:=Split string:C1554($field_o.column; ".")
			$lastProp_txt:=$parts_c[$parts_c.length-1]
			$parts_c:=$parts_c.slice(0; ($parts_c.length-1))
			$trace_o:=OB Copy:C1225($prop_o)
			For each ($part_txt; $parts_c)
				$trace_o:=$trace_o[$part_txt]
			End for each 
			
			Case of 
				: (OB Get type:C1230($trace_o; $lastProp_txt)=Is date:K8:7)
					If ($field_o.dateformat#Null:C1517)
						$dateoption_L:=$field_o.dateformat
					End if 
					$modProps_o[String:C10($prop_L; "00")+"-"+$field_o.label]:=MAP_FormatDate($trace_o[$lastProp_txt]; $dateoption_L)
				Else 
					
					$modProps_o[String:C10($prop_L; "00")+"-"+$field_o.label]:=$trace_o[$lastProp_txt]
					
			End case 
			
		Else 
			
			$prop_L:=$prop_L+1
			
			Case of 
				: (OB Get type:C1230($prop_o; $field_o.column)=Is date:K8:7)
					If ($field_o.dateformat#Null:C1517)
						$dateoption_L:=$field_o.dateformat
					End if 
					
					$modProps_o[String:C10($prop_L; "00")+"-"+$field_o.label]:=MAP_FormatDate($prop_o[$field_o.column]; $dateoption_L)
				Else 
					$modProps_o[String:C10($prop_L; "00")+"-"+$field_o.label]:=$prop_o[$field_o.column]
					
			End case 
			
	End case 
	
End for each 

$0:=$modProps_o

//End MAP_BuildGeoJSONProperties   