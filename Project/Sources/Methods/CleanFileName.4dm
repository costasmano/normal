//%attributes = {"invisible":true}
//Method: CleanFileName
// Replaces illegal characters in a filename with an underscore "_"
// MUST NOT Include the extension
// Parameters
// $0 : $Result_txt
// $1 : $FileName_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 01/23/20, 11:07:03
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
	
	C_TEXT:C284(CleanFileName; $0)
	C_TEXT:C284(CleanFileName; $1)
	
End if 
//

C_TEXT:C284($0; $1)
C_TEXT:C284($Result_txt; $FileName_txt)
$FileName_txt:=$1
$Result_txt:=""

If (Length:C16($FileName_txt)>0)
	
	$Result_txt:=Replace string:C233($FileName_txt; Char:C90(Tab:K15:37); "_")
	$Result_txt:=Replace string:C233($Result_txt; Char:C90(Line feed:K15:40); "_")
	$Result_txt:=Replace string:C233($Result_txt; Char:C90(Carriage return:K15:38); "_")
	$Result_txt:=Replace string:C233($Result_txt; Char:C90(0); "_")
	If (Substring:C12($Result_txt; Length:C16($Result_txt); 1)=" ")
		$Result_txt:=Substring:C12($Result_txt; 1; Length:C16($Result_txt)-1)+"_"
	End if 
	If (Folder separator:K24:12=":")
		//Mac
		$Result_txt:=Replace string:C233($Result_txt; ":"; "_")
		If (Substring:C12($Result_txt; 1; 1)=".")
			$Result_txt:="_"+Substring:C12($Result_txt; 2)
		End if 
	Else 
		//Windows
		$Result_txt:=Replace string:C233($Result_txt; "<"; "_")
		$Result_txt:=Replace string:C233($Result_txt; ">"; "_")
		$Result_txt:=Replace string:C233($Result_txt; ":"; "_")
		$Result_txt:=Replace string:C233($Result_txt; Char:C90(Double quote:K15:41); "_")
		$Result_txt:=Replace string:C233($Result_txt; "/"; "_")
		$Result_txt:=Replace string:C233($Result_txt; "\\"; "_")
		$Result_txt:=Replace string:C233($Result_txt; "|"; "_")
		$Result_txt:=Replace string:C233($Result_txt; "?"; "_")
		$Result_txt:=Replace string:C233($Result_txt; "*"; "_")
		$Result_txt:=Replace string:C233($Result_txt; "."; "_")
	End if 
End if 

$0:=$Result_txt
//End CleanFileName