//%attributes = {"invisible":true}
//Method: SysDoc_GetMountedShares
//Description
// Get the currently mounted shares with share name and corresponding Volume name
// uses output from mount command on MacOS or Net Use on Windows
// Parameters
// $0 : $MountedShares_c : collection of objects 
//    .Username - applicable only on macOS
//    .ShareName - share name
//    .VolumeName - volume name or drive letter on windows
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 5, 2022, 11:10:12
	Mods_2022_10
	// ----------------------------------------------------
	C_COLLECTION:C1488(SysDoc_GetMountedShares; $0)
End if 
//
C_COLLECTION:C1488($0; $mounted_c)

If (Is macOS:C1572)
	// Mac 
	C_TEXT:C284($BasePattern_txt)
	$BasePattern_txt:="\\/\\/(.*)@(.*)"
	$BasePattern_txt:=$BasePattern_txt+" on \\/Volumes\\/(.*) \\("
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	C_TEXT:C284($stdin_x; $stdout_x; $stderr_x)
	LAUNCH EXTERNAL PROCESS:C811("mount"; $stdin_x; $stdout_x; $stderr_x)
	
	C_BOOLEAN:C305($match_b)
	C_TEXT:C284($user_txt; $DNS_txt; $shareddatapath_txt; $VolumeName_txt)
	ARRAY LONGINT:C221($StartPos_aL; 0)
	ARRAY LONGINT:C221($Lengths_aL; 0)
	C_LONGINT:C283($startSearch)
	$startSearch:=1
	C_OBJECT:C1216($mountedShare_o)
	$mounted_c:=New collection:C1472
	Repeat 
		$match_b:=Match regex:C1019($BasePattern_txt; $stdout_x; $startSearch; $StartPos_aL; $Lengths_aL)
		If ($match_b)
			$mountedShare_o:=New object:C1471
			$mountedShare_o.UserName:=Substring:C12($stdout_x; $StartPos_aL{1}; $Lengths_aL{1})
			$mountedShare_o.ShareName:=Substring:C12($stdout_x; $StartPos_aL{2}; $Lengths_aL{2})
			$mountedShare_o.VolumeName:=Substring:C12($stdout_x; $StartPos_aL{3}; $Lengths_aL{3})
			$mounted_c.push($mountedShare_o)
			$startSearch:=$StartPos_aL{Size of array:C274($StartPos_aL)}+$Lengths_aL{Size of array:C274($StartPos_aL)}
		End if 
		
	Until (Not:C34($match_b))
	
Else 
	
	// Windows
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
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("NET USE"; inputStream_txt; OutputStream_txt; ErrorStream_txt)
	$noMore_t:=""
	$lastPos_l:=1
	$numFound_l:=0
	
	$mounted_c:=New collection:C1472
	
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
	
	// add the objects to the collection
	For ($counter_l; 1; Size of array:C274($foundUNCs_at))
		$mountedShare_o:=New object:C1471
		$mountedShare_o.ShareName:=f_TrimStr(Substring:C12($foundUNCs_at{$counter_l}; 11); True:C214; True:C214)  // remove any leading and trailing spaces
		$mountedShare_o.VolumeName:=Substring:C12($foundUNCs_at{$counter_l}; 1; 2)
		$mounted_c.push($mountedShare_o)
		
	End for 
	
End if 

$0:=$mounted_c
//End SysDoc_GetMountedShares   