//%attributes = {"invisible":true}
//Open window(100;100;300;200;0;"Chronometer")
//$vhTimeStart:=Current time
//$vlTicksStart:=Tickcount
//$vrMillisecondsStart:=Milliseconds
//Repeat 
//GOTO XY(2;1)
//MESSAGE("Time...........:"+String(Current time-$vhTimeStart))
//GOTO XY(2;3)
//MESSAGE("Ticks..........:"+String(Tickcount-$vlTicksStart))
//GOTO XY(2;4)
//MESSAGE("Milliseconds...:"+String(Milliseconds-$vrMillisecondsStart))
//GOTO XY(2;5)
//MESSAGE("Seconds.........:"+String((Milliseconds-$vrMillisecondsStart)/1000))
//Until ((Current time-$vhTimeStart)>=†00:01:00†)
//CLOSE WINDOW
//graphmlExport
//exporte la structure au format .graphml pour yEd

//#TODO : $1 tables à exporter pour export limité à certaines tables 
//pour cela les id internes node et edge (d{N}, e{N}) doivent être valides
//autrement dit n'exporter un lien si on exporte les tables qu'il met en relation

// Arnaud * 27/03/2021 14:10:06

//structure definition xml pour les couleurs
C_TEXT:C284($struc_t; $dom_t; $colorHex_t; $path_t; $template_t)
C_OBJECT:C1216($struc_o)
EXPORT STRUCTURE:C1311($struc_t)
$dom_t:=DOM Parse XML variable:C720($struc_t)
$struc_o:=Xml_ToObject($dom_t)
DOM CLOSE XML:C722($dom_t)
//structure definition pour le template
C_OBJECT:C1216($out_o)
C_OBJECT:C1216($tableDef_o)
C_OBJECT:C1216($node_o)
C_OBJECT:C1216($edge_o)
C_LONGINT:C283($stopTable; $table_l; $r; $g; $b; $color; $field_l; $tableTo_l; $fieldTo_l)
$out_o:=New object:C1471()
$out_o.node:=New collection:C1472()
$out_o.edge:=New collection:C1472()
$stopTable:=Get last table number:C254  //in waiting
C_LONGINT:C283($r; $g; $b)
For ($table_l; 1; $stopTable)
	If (Is table number valid:C999($table_l))
		//node = table
		$tableDef_o:=$struc_o.base.table.query("id = :1"; String:C10($table_l))[0]
		$r:=Num:C11($tableDef_o.table_extra.editor_table_info.color.red)
		$g:=Num:C11($tableDef_o.table_extra.editor_table_info.color.green)
		$b:=Num:C11($tableDef_o.table_extra.editor_table_info.color.blue)
		$color:=($r << 16)+($g << 8)+$b
		$colorHex_t:=Replace string:C233(String:C10($color; "&x"); "0x00"; "#")
		$node_o:=New object:C1471
		$node_o.id:="n"+String:C10($table_l)
		$node_o.tableName:=Table name:C256($table_l)
		$node_o.backgroundColor:=$colorHex_t  //couleur en-tête
		$node_o.color:=$colorHex_t  //color + color2 = dégradé
		$node_o.color2:=$colorHex_t
		$out_o.node.push($node_o)
		For ($field_l; 1; Get last field number:C255($table_l))
			If (Is field number valid:C1000($table_l; $field_l))
				GET RELATION PROPERTIES:C686($table_l; $field_l; $tableTo_l; $fieldTo_l)
				If (Is field number valid:C1000($tableTo_l; $fieldTo_l))
					//edge = relation
					$edge_o:=New object:C1471
					$edge_o.id:="n"+String:C10(($table_l*100000)+$field_l)
					$edge_o.source:="n"+String:C10($table_l)
					$edge_o.target:="n"+String:C10($tableTo_l)
					$edge_o.sourceName:=Field name:C257($table_l; $field_l)
					$edge_o.targetName:=Field name:C257($tableTo_l; $fieldTo_l)
					$out_o.edge.push($edge_o)
				End if 
			End if 
		End for 
	End if 
End for 
//fusion avé le template

$path_t:="/Users/demontard_a/Desktop/template.graphml"  //#TODO Resources folder
ARRAY TEXT:C222($templates; 0)
$path_t:=Select document:C905(""; ".graphml"; "Select the graphml template"; 0; $templates)

$path_t:=$templates{1}
ASSERT:C1129(Test path name:C476($path_t)=Is a document:K24:1)
$template_t:=Document to text:C1236($path_t)
C_OBJECT:C1216(processTags_o)
processTags_o:=$out_o
C_TEXT:C284($out_t)
PROCESS 4D TAGS:C816($template_t; $out_t)
CLEAR VARIABLE:C89(processTags_o)
//SET TEXT TO PASTEBOARD($out_t)
$path_t:=System folder:C487(Desktop:K41:16)+Replace string:C233(Timestamp:C1445; ":"; "")+Structure file:C489+".graphml"
TEXT TO DOCUMENT:C1237($path_t; $out_t)
SHOW ON DISK:C922($path_t)