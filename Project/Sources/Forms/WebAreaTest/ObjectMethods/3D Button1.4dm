//Method: Object Method: WebAreaTest.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/06/13, 13:45:07
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
//WA EXECUTE JAVASCRIPT FUNCTION(web area;"From4DzoomBounds")
//
//ALERT("done 1")

C_TEXT:C284($file_txt)
$file_txt:=Select document:C905(""; "pdf"; "Select file to open"; Use sheet window:K24:11)
If (ok=1)
	C_TEXT:C284($webcontent_txt)
	C_BLOB:C604($doc_blob)
	//DOCUMENT TO BLOB(Document;$doc_blob)
	//
	//$webcontent_txt:=BLOB to text($doc_blob;UTF8 text without length )
	//$file_txt:=Document
	//ARRAY TEXT($parts_atxt;0)
	//ut_TextToArray (Document;->$parts_atxt;◊PL_DirectorySep_s)
	//C_LONGINT($loop_L)
	//For ($loop_L;1;Size of array($parts_atxt))
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"%";"%25")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"(";"%28")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};")";"%29")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"[";"%5B")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"]";"%5D")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"{";"%7B")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"}";"%7D")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"/";":")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};"\\";"%5C")
	//$parts_atxt{$loop_L}:=Replace string($parts_atxt{$loop_L};" ";"%20")
	//If ($loop_L=1)
	//$file_txt:=$parts_atxt{$loop_L}
	//Else 
	//$file_txt:=$file_txt+"/"+$parts_atxt{$loop_L}
	//End if 
	//End for 
	$file_txt:=ut_FilepathToRFC(Document)
	web area_url:=$file_txt
	WA OPEN URL:C1020(Web Area; "file://"+$file_txt)
	//WA SET PAGE CONTENT(Web Area;$webcontent_txt;"File:///"+ut_HFS_to_POSIX (Document))
	WA REFRESH CURRENT URL:C1023(Web Area)
	
End if 

WA REFRESH CURRENT URL:C1023(Web Area)
$webcontent_txt:=WA Get page content:C1038(Web area)
SET TEXT TO PASTEBOARD:C523($webcontent_txt)
//End Object Method: WebAreaTest.Button