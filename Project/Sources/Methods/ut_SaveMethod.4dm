//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/21/11, 14:44:10
//----------------------------------------------------
//Method: ut_SaveMethod
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2/19/14 16:52:11)
	Mods_2014_02_bug
	//  `added check if vars are defined
End if 

C_TEXT:C284($methodName; $1; $DirectorySymbol_txt)
C_TEXT:C284($text; $structurePath_txt)
C_TIME:C306($vDocRef)

If (Type:C295(<>SavedMethodFolder_txt)#Is text:K8:3)
	ALERT:C41("Must Complete Startup!!  Method "+$1+" has not been saved to disk!")
Else 
	
	If (<>SavedMethodFolder_txt="")
		$structurePath_txt:=Structure file:C489
	Else 
		$structurePath_txt:=<>SavedMethodFolder_txt
	End if 
	
	C_LONGINT:C283($Loop_l)
	If (<>PL_DirectorySep_s="")
		//_O_PLATFORM PROPERTIES($Platform_l)// MassDOT_PS - conversion v19R7
		C_TEXT:C284($DirectorySymbol_txt)
		Case of 
			: (Is Windows:C1573)
				$DirectorySymbol_txt:="\\"
			Else 
				$DirectorySymbol_txt:=":"
		End case 
	Else 
		$DirectorySymbol_txt:=<>PL_DirectorySep_s
	End if 
	$Loop_l:=Length:C16($structurePath_txt)
	If (Position:C15($DirectorySymbol_txt; $structurePath_txt)>0)
		Repeat 
			$Loop_l:=$Loop_l-1
		Until ($structurePath_txt[[$Loop_l]]=$DirectorySymbol_txt)
		$structurePath_txt:=Substring:C12($structurePath_txt; $Loop_l+1)
	End if 
	$structurePath_txt:=Replace string:C233($structurePath_txt; ".4db"; "")
	$structurePath_txt:=Replace string:C233($structurePath_txt; " "; "_")
	$structurePath_txt:=ut_ReturnUserDocFolder($structurePath_txt)
	
	If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($structurePath_txt)
	End if 
	$structurePath_txt:=$structurePath_txt+"Changed_Methods"
	
	If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($structurePath_txt)
	End if 
	C_TEXT:C284($TimeStamp_txt)
	
	$TimeStamp_txt:=Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33); 1; 8)
	$TimeStamp_txt:=Substring:C12($TimeStamp_txt; 1; 4)+"-"+Substring:C12($TimeStamp_txt; 5; 2)+"-"+Substring:C12($TimeStamp_txt; 7; 2)
	
	$structurePath_txt:=$structurePath_txt+<>PL_DirectorySep_s+$TimeStamp_txt
	//String(Year of(Current date);"0000")+String(Month of(Current date);"00")+String(Day of(Current date);"00")
	If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($structurePath_txt)
	End if 
	
	$methodName:=$1
	GET MACRO PARAMETER:C997(Full method text:K5:17; $text)
	$methodName:=Replace string:C233($methodName; "Object Method: "; "")
	$methodName:=Replace string:C233($methodName; ":"; "-")
	$methodName:=Replace string:C233($methodName; " "; "-")
	$methodName:=Replace string:C233($methodName; "."; "_")
	
	$structurePath_txt:=$structurePath_txt+<>PL_DirectorySep_s+$methodName+".txt"
	$vDocRef:=Create document:C266($structurePath_txt)
	If (OK=1)
		SEND PACKET:C103($vDocRef; $text)
		CLOSE DOCUMENT:C267($vDocRef)
	End if 
	
End if 

//End ut_SaveMethod