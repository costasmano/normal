//%attributes = {"invisible":true}
//Method: dev_SVG_DrawStructure
//Description :
// draw structure in svg (not working too well). copied from : 
//----------------------------------------------------
// Method svg_drawStructure
// Created 20/04/09 by Vincent de Lachaux
//----------------------------------------------------
// Description
//
//----------------------------------------------------
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/16/19, 15:20:35
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
	C_TEXT:C284(dev_SVG_DrawStructure; $1)
	
End if 
// Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i; $Lon_j; $Lon_parameters; $Lon_type)
C_REAL:C285($Num_destinationHeight; $Num_destinationWidth; $Num_destinationX; $Num_destinationY; $Num_height)
C_REAL:C285($Num_left; $Num_middle; $Num_sourceHeight; $Num_sourceWidth; $Num_sourceX)
C_REAL:C285($Num_sourceY; $Num_top; $Num_width; $Num_X1; $Num_X2)
C_REAL:C285($Num_y1; $Num_y2)
C_TEXT:C284($Dom_arrow; $Dom_circle; $Dom_color; $Dom_coordinates; $Dom_destination)
C_TEXT:C284($Dom_fieldName; $Dom_fieldRect; $Dom_fieldType; $Dom_relation; $Dom_root)
C_TEXT:C284($Dom_source; $Dom_svg; $Dom_tableGroup; $Dom_tableName; $Dom_tableRect)
C_TEXT:C284($Txt_blue; $Txt_color; $Txt_data; $Txt_destinationUUID; $Txt_fieldName)
C_TEXT:C284($Txt_fieldUID; $Txt_green; $Txt_kind; $Txt_red; $Txt_sourceUUID)
C_TEXT:C284($Txt_tableName; $Txt_tableUID; $Txt_path)

ARRAY TEXT:C222($tDom_fields; 0)
ARRAY TEXT:C222($tDom_relatedFields; 0)
ARRAY TEXT:C222($tDom_relations; 0)
ARRAY TEXT:C222($tDom_tables; 0)

If (False:C215)
	C_TEXT:C284(dev_SVG_DrawStructure; $1)
End if 

//----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

ARRAY TEXT:C222($tTxt_types; 18)
$tTxt_types{1}:="B"
$tTxt_types{3}:="E"
$tTxt_types{4}:="L"
$tTxt_types{5}:="LL"
$tTxt_types{6}:="N"
$tTxt_types{7}:="F"
$tTxt_types{8}:="D"
$tTxt_types{9}:="H"
$tTxt_types{10}:="T"
$tTxt_types{12}:="I"
$tTxt_types{18}:="X"

//----------------------------------------------------

If ($Lon_parameters>=1)
	
	If (Test path name:C476($1)=Is a document:K24:1)
		
		$Dom_root:=DOM Parse XML source:C719($1)
		
		If (OK=1)
			
			$Dom_svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
			
			If (OK=1)
				
				DOM SET XML ATTRIBUTE:C866($Dom_svg; "font-family"; "Lucida grande,segoie,sans")
				DOM SET XML ATTRIBUTE:C866($Dom_svg; "font-size"; "12")
				DOM SET XML ATTRIBUTE:C866($Dom_svg; "font-weight"; "bold")
				DOM SET XML ATTRIBUTE:C866($Dom_svg; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
				
				$tDom_tables{0}:=DOM Find XML element:C864($Dom_root; "/base/table"; $tDom_tables)
				
				If (OK=1)
					
					For ($Lon_i; 1; Size of array:C274($tDom_tables); 1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($tDom_tables{$Lon_i}; "uuid"; $Txt_tableUID)
						
						$Dom_tableGroup:=DOM Create XML element:C865($Dom_svg; "g"; "id"; $Txt_tableUID)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($tDom_tables{$Lon_i}; "name"; $Txt_tableName)
						
						$Dom_coordinates:=DOM Find XML element:C864($tDom_tables{$Lon_i}; "/table/table_extra/editor_table_info/coordinates")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates; "left"; $Num_left)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates; "top"; $Num_top)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates; "width"; $Num_width)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates; "height"; $Num_height)
						
						$Dom_tableRect:=DOM Create XML element:C865($Dom_tableGroup; "rect"; "x"; $Num_left; "y"; $Num_top; "width"; $Num_width; "height"; 25; "rx"; 5; "ry"; 5; "stroke"; "black"; "fill"; "gainsboro")
						
						$Dom_tableName:=DOM Create XML element:C865($Dom_tableGroup; "text"; "x"; $Num_left+($Num_width/2); "y"; $Num_top+15; "text-anchor"; "middle")
						DOM SET XML ELEMENT VALUE:C868($Dom_tableName; $Txt_tableName)
						
						$Num_top:=$Num_top+20
						
						$tDom_fields{0}:=DOM Find XML element:C864($tDom_tables{$Lon_i}; "/table/field"; $tDom_fields)
						
						For ($Lon_j; 1; Size of array:C274($tDom_fields); 1)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j}; "uuid"; $Txt_fieldUID)
							
							$Dom_fieldRect:=DOM Create XML element:C865($Dom_tableGroup; "rect"; "x"; $Num_left; "y"; $Num_top; "width"; $Num_width; "height"; 20; "stroke"; "black"; "fill"; "white"; "id"; $Txt_fieldUID)
							
							$Num_top:=$Num_top+15
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j}; "name"; $Txt_fieldName)
							$Dom_fieldName:=DOM Create XML element:C865($Dom_tableGroup; "text"; "x"; $Num_left+5; "y"; $Num_top; "text-anchor"; "start")
							DOM SET XML ELEMENT VALUE:C868($Dom_fieldName; $Txt_fieldName)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j}; "type"; $Lon_type)
							$Dom_fieldType:=DOM Create XML element:C865($Dom_tableGroup; "text"; "x"; $Num_left+$Num_width-5; "y"; $Num_top; "text-anchor"; "end")
							DOM SET XML ELEMENT VALUE:C868($Dom_fieldType; $tTxt_types{$Lon_type})
							
							$Num_top:=$Num_top+5
							
						End for 
						
					End for 
					
					$tDom_relations{0}:=DOM Find XML element:C864($Dom_root; "/base/relation"; $tDom_relations)
					
					For ($Lon_i; 1; Size of array:C274($tDom_relations); 1)
						
						$tDom_relatedFields{0}:=DOM Find XML element:C864($tDom_relations{$Lon_i}; "/relation/related_field"; $tDom_relatedFields)
						
						If (Size of array:C274($tDom_relatedFields)>=2)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_relatedFields{1}; "kind"; $Txt_kind)
							If ($Txt_kind="source")
								$Dom_source:=DOM Find XML element:C864($tDom_relatedFields{1}; "/related_field/field_ref")
							Else 
								$Dom_destination:=DOM Find XML element:C864($tDom_relatedFields{1}; "/related_field/field_ref")
							End if 
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_relatedFields{2}; "kind"; $Txt_kind)
							If ($Txt_kind="source")
								$Dom_source:=DOM Find XML element:C864($tDom_relatedFields{2}; "/related_field/field_ref")
							Else 
								$Dom_destination:=DOM Find XML element:C864($tDom_relatedFields{2}; "/related_field/field_ref")
							End if 
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source; "uuid"; $Txt_sourceUUID)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination; "uuid"; $Txt_destinationUUID)
							
							$Dom_source:=DOM Find XML element by ID:C1010($Dom_svg; $Txt_sourceUUID)
							$Dom_destination:=DOM Find XML element by ID:C1010($Dom_svg; $Txt_destinationUUID)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source; "x"; $Num_sourceX)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source; "y"; $Num_sourceY)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source; "width"; $Num_sourceWidth)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source; "height"; $Num_sourceHeight)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination; "x"; $Num_destinationX)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination; "y"; $Num_destinationY)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination; "width"; $Num_destinationWidth)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination; "height"; $Num_destinationHeight)
							
							$Dom_color:=DOM Find XML element:C864($tDom_relations{$Lon_i}; "/relation/relation_extra/editor_relation_info/color")
							
							If (OK=1)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color; "red"; $Txt_red)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color; "green"; $Txt_green)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color; "blue"; $Txt_blue)
								
								If ($Txt_red="255") & ($Txt_green="255") & ($Txt_blue="255")
									$Txt_color:="black"
								Else 
									$Txt_color:="rgb("+$Txt_red+","+$Txt_green+","+$Txt_blue+")"
								End if 
								
							End if 
							
							If ($Num_sourceX<$Num_destinationX)
								
								$Num_X1:=$Num_sourceX+$Num_sourceWidth
								$Num_X2:=$Num_destinationX
								
							Else 
								
								$Num_X1:=$Num_sourceX
								$Num_X2:=$Num_destinationX+$Num_destinationWidth
								
							End if 
							
							$Num_y1:=$Num_sourceY+($Num_sourceHeight/2)
							$Num_y2:=$Num_destinationY+($Num_destinationHeight/2)
							
							$Num_middle:=($Num_X2-$Num_X1)/2
							
							$Txt_data:=String:C10($Num_X1; "&xml")+","+String:C10($Num_y1; "&xml")+" "
							$Txt_data:=$Txt_data+String:C10($Num_X1+$Num_middle; "&xml")+","+String:C10($Num_y1; "&xml")+" "
							$Txt_data:=$Txt_data+String:C10($Num_X1+$Num_middle; "&xml")+","+String:C10($Num_y2; "&xml")+" "
							$Txt_data:=$Txt_data+String:C10($Num_X2; "&xml")+","+String:C10($Num_y2; "&xml")
							
							$Dom_relation:=DOM Create XML element:C865($Dom_svg; "polyline"; "fill"; "none"; "stroke"; $Txt_color; "stroke-width"; 3; "points"; $Txt_data)
							
							$Dom_circle:=DOM Create XML element:C865($Dom_svg; "circle"; "cx"; $Num_X1; "cy"; $Num_y1; "r"; 4; "stroke"; "black"; "fill"; "white")
							
							If ($Num_X1<$Num_X2)
								
								$Num_X2:=$Num_X2+3
								
								$Txt_data:=String:C10($Num_X2; "&xml")+","+String:C10($Num_y2; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2-6; "&xml")+","+String:C10($Num_y2-6; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2-6; "&xml")+","+String:C10($Num_y2+6; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2; "&xml")+","+String:C10($Num_y2; "&xml")
								
							Else 
								
								$Num_X2:=$Num_X2-3
								
								$Txt_data:=String:C10($Num_X2; "&xml")+","+String:C10($Num_y2; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2+6; "&xml")+","+String:C10($Num_y2+6; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2+6; "&xml")+","+String:C10($Num_y2-6; "&xml")+" "
								$Txt_data:=$Txt_data+String:C10($Num_X2; "&xml")+","+String:C10($Num_y2; "&xml")
								
							End if 
							
							$Dom_arrow:=DOM Create XML element:C865($Dom_svg; "polyline"; "fill"; "white"; "stroke"; "black"; "stroke-width"; 1; "points"; $Txt_data)
							
						End if 
						
					End for 
					
					$Txt_path:=Replace string:C233($1; ".xml"; ".svg")
					
					DOM EXPORT TO FILE:C862($Dom_svg; $Txt_path)
					
					//OPEN WEB URL($Txt_path)
					SHOW ON DISK:C922($Txt_path)
					
					DOM CLOSE XML:C722($Dom_svg)
					
				End if 
				
				DOM CLOSE XML:C722($Dom_root)
				
			Else 
				
				TRACE:C157
				
			End if 
			
		Else 
			
			TRACE:C157
			
		End if 
		
	Else 
		
		TRACE:C157
		
	End if 
	
Else 
	C_TEXT:C284($StructureXMLExport_txt)
	ARRAY TEXT:C222($files_atxt; 0)
	$StructureXMLExport_txt:=Select document:C905(""; ".xml"; "Select the XML Structure export"; 0; $files_atxt)
	If (ok=1)
		dev_SVG_DrawStructure($files_atxt{1})
	End if 
	
End if 
//End dev_SVG_DrawStructure