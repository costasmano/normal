//%attributes = {}
//Method: PERS_GetName
//Description
// Return the name of a person from personnel table.
// Can specify a format.  Method can be used in a quick report
// Parameters
// $0 : $Pname
// $1 : $PersID_L
// $2 : $Format (optional)
//  // format can be a combination of codes FN, LN, MI, FI, LI , PRE, SUF
//  // (first name, last name, middle initial, First initial, last initial, Prefix, Suffix)
//  // ex "LN, FI"  or "PREFN MI. LN"  - default is "FN LN"
//  // For the PREfix ,if there is one, a space will be addded after the prefix.
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 21, 2022, 15:14:30
	Mods_2022_11
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2023-04-06 19:00:11)
	Mods_2023_04
	//  `use ds.Personell.query instead of SQL
	
	C_TEXT:C284(PERS_GetName; $0)
	C_LONGINT:C283(PERS_GetName; $1)
	C_TEXT:C284(PERS_GetName; $2)
End if 
//

C_LONGINT:C283($1; $PersID_L)
$PersID_L:=$1
C_TEXT:C284($0; $PName)

C_TEXT:C284($format_)
$format_:="FN LN"
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	If ($2#"")
		$format_:=$2
	End if 
End if 

//check if format contains at least one of the codes
C_TEXT:C284($Codes_)
$Codes_:="FN,LN,MI,FI,LI,PRE,SUF"
ARRAY TEXT:C222($codes_atxt; 0)
ut_TextToArray($Codes_; ->$codes_atxt; ",")
C_LONGINT:C283($loop_L; $found_)
C_BOOLEAN:C305($OkToGo)
$OkToGo:=False:C215
For ($loop_L; 1; Size of array:C274($codes_atxt))
	$found_:=Position:C15($codes_atxt{$loop_L}; $format_)
	If ($found_>0)
		$OkToGo:=True:C214
	End if 
End for 

If ($OkToGo)
	C_TEXT:C284($firstname; $lastName; $middleI; $FI; $LI; $Prefix; $suffix)
	C_OBJECT:C1216($pers_o)
	$pers_o:=ds:C1482.Personnel.query("\"Person ID\" = :1"; $PersID_L)
	
	If ($pers_o.length=1)
		$firstname:=$pers_o[0]["First Name"]
		$lastName:=$pers_o[0]["Last Name"]
		$middleI:=$pers_o[0]["Middle Name"]
		$Prefix:=$pers_o[0].Prefix
		$suffix:=$pers_o[0].Suffix
	End if 
	
	$FI:=Substring:C12($firstname; 1; 1)
	$LI:=Substring:C12($lastName; 1; 1)
	$middleI:=Substring:C12($middleI; 1; 1)
	
	//handle Prefix cases
	C_LONGINT:C283($codePos_L)
	$codePos_L:=Position:C15("PRE"; $format_)
	If ($codePos_L>0)
		
		If ($Prefix#"")
			// find location of prefix in format
			If ($codePos_L+3>Length:C16($format_))
				//at end of format - no need to do anything
			Else 
				If (Substring:C12($format_; ($codePos_L+3); 1)#" ")
					//there is no space after the PRE code - add one.
					$Prefix:=$Prefix+" "  // add a space
				End if 
			End if 
		Else 
			//no prefix, remove any space in the format that is after
			$format_:=Replace string:C233($format_; "PRE "; "")
			
		End if 
		
	End if   //if PRE is in the format
	
	//handle middle initial cases
	C_LONGINT:C283($codePos_L)
	$codePos_L:=Position:C15("MI"; $format_)
	If ($codePos_L>0)
		
		If ($middleI#"")
		Else 
			//no prefix, remove any space or period in the format that is after
			If ($codePos_L+3>Length:C16($format_))
				//at end of format - no need to do anything
			Else 
				//replace
				$format_:=Replace string:C233($format_; "MI. "; "")
				$format_:=Replace string:C233($format_; "MI."; "")
				$format_:=Replace string:C233($format_; "MI "; "")
				
			End if 
			
		End if 
		
	End if   // if MI is in the format
	
	$PName:=Replace string:C233($format_; "FN"; $firstname)
	$PName:=Replace string:C233($PName; "LN"; $lastName)
	$PName:=Replace string:C233($PName; "MI"; $middleI)
	$PName:=Replace string:C233($PName; "FI"; $FI)
	$PName:=Replace string:C233($PName; "LI"; $LI)
	$PName:=Replace string:C233($PName; "PRE"; $Prefix)
	$PName:=Replace string:C233($PName; "SUF"; $suffix)
	
Else 
	$PName:="Bad Format string <"+$format_+">! Must contain a combination of <"+$Codes_+">"
End if 

//
$0:=$PName
//End PERS_GetName   