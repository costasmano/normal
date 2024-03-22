//%attributes = {"invisible":true}
// Method: ut_ReturnWindowsMountInfo
// Description
// 
// Parameters
// $0 :
// $1 :
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(7/30/20 16:23:44)
	Mods_2020_07_bug
	//  `check if the server name in $1 has "." in it. in that case and if not found from the 
	//  `NET USE output, check using the first part ex mhd-shared.massdot.trans.internal -> mhd-shared
End if 

C_TEXT:C284($1; $0)

C_TEXT:C284(OutputStream_txt; inputStream_txt; ErrorStream_txt; $sep_t; $CRLF; $noMore_t; $continue_t; $tmpTestThisChar_t)
C_LONGINT:C283($firstOK_l; $firstNL_l; $lastPos_l; $tmpPosFound_l; $tmpLength_l; $tmpLengthFound_l)
C_LONGINT:C283($tmpLengthOfUNC_l; $lastCharFound_l; $counter_l; $numFound_l)
ARRAY TEXT:C222($foundUNCs_at; 0)
ARRAY TEXT:C222($UNCdrive_at; 0)
ARRAY TEXT:C222($UNCpath_at; 0)
$sep_t:="-------------------------------------------------------------------------------"
OutputStream_txt:=""
InputStream_txt:=""
ErrorStream_txt:=""
$CRLF:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
LAUNCH EXTERNAL PROCESS:C811("NET USE"; inputStream_txt; OutputStream_txt; ErrorStream_txt)
$noMore_t:=""
$lastPos_l:=1
$numFound_l:=0

// put each line starting with OK into an array element
Repeat 
	$firstOK_l:=Position:C15("OK"; OutputStream_txt; $lastPos_l)
	$firstNL_l:=Position:C15($CRLF; OutputStream_txt; $firstOK_l)
	If ($firstOK_l>$lastPos_l)
		$lastPos_l:=$firstNL_l
		APPEND TO ARRAY:C911($foundUNCs_at; Substring:C12(OutputStream_txt; $firstOK_l; ($firstNL_l-$firstOK_l)))
		$numFound_l:=$numFound_l+1
	Else 
		$noMore_t:="yup"
	End if 
Until ($noMore_t="yup")

// stip everything before the drive letter (13 chars in)
For ($counter_l; 1; Size of array:C274($foundUNCs_at))
	$tmpLength_l:=Length:C16($foundUNCs_at{$counter_l})-13
	$foundUNCs_at{$counter_l}:=Substring:C12($foundUNCs_at{$counter_l}; 14; $tmpLength_l)
End for 

// Strip out "Microsoft Windows Network" from the array elements
For ($counter_l; 1; Size of array:C274($foundUNCs_at))
	$tmpPosFound_l:=Position:C15("Microsoft Windows Network"; $foundUNCs_at{$counter_l}; 1; $tmpLengthFound_l)
	If ($tmpPosFound_l#0)
		$foundUNCs_at{$counter_l}:=Substring:C12($foundUNCs_at{$counter_l}; 1; $tmpPosFound_l-1)
	End if 
End for 

// Split in to 2 arrays of drive letters and UNC mappings
For ($counter_l; 1; Size of array:C274($foundUNCs_at))
	APPEND TO ARRAY:C911($UNCdrive_at; Substring:C12($foundUNCs_at{$counter_l}; 1; 2))
	APPEND TO ARRAY:C911($UNCpath_at; Substring:C12($foundUNCs_at{$counter_l}; 11))
	Repeat 
		$tmpLengthOfUNC_l:=Length:C16($UNCpath_at{$counter_l})
		$lastCharFound_l:=Position:C15(" "; $UNCpath_at{$counter_l}; $tmpLengthOfUNC_l)
		$tmpTestThisChar_t:=Substring:C12($UNCpath_at{$counter_l}; $lastCharFound_l)
		If ($tmpTestThisChar_t=" ")
			$UNCpath_at{$counter_l}:=Substring:C12($UNCpath_at{$counter_l}; 1; $lastCharFound_l-1)
		Else 
			$continue_t:="no"
		End if 
	Until ($continue_t="no")
End for 
$counter_l:=Find in array:C230($UNCpath_at; "@"+$1+"@")
If ($counter_l>0)
	$0:=$UNCdrive_at{$Counter_L}+$UNCpath_at{$counter_l}
Else 
	//test if the server name has "."
	C_TEXT:C284($serverName_txt; $sharedfolderPath_txt)
	ARRAY TEXT:C222($basepaths_atxt; 0)
	ut_TextToArray($1; ->$basepaths_atxt; "\\")
	$serverName_txt:=$basepaths_atxt{1}
	If (Position:C15("."; $serverName_txt)>0)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274($basepaths_atxt))
			$sharedfolderPath_txt:=$sharedfolderPath_txt+Folder separator:K24:12+$basepaths_atxt{$loop_L}
		End for 
		
		ARRAY TEXT:C222($basepaths_atxt; 0)
		ut_TextToArray($serverName_txt; ->$basepaths_atxt; ".")
		$serverName_txt:=$basepaths_atxt{1}
		//check with the simplified server name
		$counter_l:=Find in array:C230($UNCpath_at; "@"+($serverName_txt+$sharedfolderPath_txt)+"@")
		
		If ($counter_l>0)
			$0:=$UNCdrive_at{$Counter_L}+$UNCpath_at{$counter_l}
			
		Else 
			$0:="Not Mounted"
			
		End if 
	Else 
		$0:="Not Mounted"
		
	End if 
	
End if 
