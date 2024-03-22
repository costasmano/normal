//%attributes = {"invisible":true}
//Method: ut_FilepathToRFC
//Description
//  ` Convert a file path to RFC format for use as a  url
//  ` will need to add the "file://" in front if passed to a web area
//  ` Parameters
//  ` $0 : $FileRFC_txt
//  ` $1 : $filePath_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/19/13, 08:44:31
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
C_TEXT:C284($0; $FileRFC_txt)
C_TEXT:C284($1; $filePath_txt)
$FileRFC_txt:=""
$filePath_txt:=$1
If (<>MacPL_b)
	ARRAY TEXT:C222($parts_atxt; 0)
	//split the file path to the different parts by the directory separator
	ut_TextToArray($filePath_txt; ->$parts_atxt; <>PL_DirectorySep_s)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($parts_atxt))
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "%"; "%25")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "("; "%28")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; ")"; "%29")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "["; "%5B")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "]"; "%5D")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "{"; "%7B")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "}"; "%7D")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "/"; ":")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; "\\"; "%5C")
		$parts_atxt{$loop_L}:=Replace string:C233($parts_atxt{$loop_L}; " "; "%20")
		If ($loop_L=1)
			$FileRFC_txt:=$parts_atxt{$loop_L}
		Else 
			$FileRFC_txt:=$FileRFC_txt+"/"+$parts_atxt{$loop_L}
		End if 
	End for 
Else 
	//for windows we can just use the file path as is. tested in v11 / windows 7
	$FileRFC_txt:=$filePath_txt
End if 

$0:=$FileRFC_txt
//End ut_FilepathToRFC