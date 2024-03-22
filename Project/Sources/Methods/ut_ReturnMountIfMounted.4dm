//%attributes = {"invisible":true}
//Method: ut_ReturnMountIfMounted
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/25/19, 13:29:15
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($0)
C_LONGINT:C283($pos_L)

If (Folder separator:K24:12=":")  //Mac
	
	ARRAY TEXT:C222($Volumes_atxt; 0)
	VOLUME LIST:C471($Volumes_atxt)
	
	$pos_L:=Find in array:C230($Volumes_atxt; "@"+$1+"@")
	If ($pos_L>0)
		$0:=$Volumes_atxt{$pos_L}
	Else 
		$0:="Not Mounted!"
	End if 
Else 
	
	
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
	$pos_L:=Find in array:C230($UNCpath_at; "@"+$1+"@")
	If ($pos_L>0)
		$0:=$UNCpath_at{$pos_L}
	Else 
		$0:="Not Mounted!"
		
	End if 
	
	
End if 

//End ut_ReturnMountIfMounted