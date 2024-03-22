//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_IsALongint
// User name (OS): cjmiller
// Date and time: 05/11/06, 15:44:12
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($mystring; $1)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($0; $test)
C_LONGINT:C283($numchars; $i)

$mystring:=$1

//assume true for starters

$test:=True:C214

$numchars:=Length:C16($mystring)

If ($numchars=0) | ($numchars>32)
	$test:=False:C215
Else 
	If ($numchars>13)
		If ($mystring[[1]]="+") | ($mystring[[$numchars]]="+")
			$mystring:=Replace string:C233($mystring; "+"; "")
		End if 
		If ($mystring[[1]]="-")
			$mystring:=Replace string:C233($mystring; "-"; "")
		End if 
		$mystring:=Replace string:C233($mystring; "0"; "")
		$mystring:=Replace string:C233($mystring; "1"; "")
		$mystring:=Replace string:C233($mystring; "2"; "")
		$mystring:=Replace string:C233($mystring; "3"; "")
		$mystring:=Replace string:C233($mystring; "4"; "")
		$mystring:=Replace string:C233($mystring; "5"; "")
		$mystring:=Replace string:C233($mystring; "6"; "")
		$mystring:=Replace string:C233($mystring; "7"; "")
		$mystring:=Replace string:C233($mystring; "8"; "")
		$mystring:=Replace string:C233($mystring; "9"; "")
		
		If (Length:C16($mystring)#0)
			$test:=False:C215
		End if 
	Else 
		For ($i; 1; $numchars)
			
			If ((Character code:C91($mystring[[$i]])<Character code:C91("0")) | (Character code:C91($mystring[[$i]])>Character code:C91("9")))
				Case of 
					: ($mystring[[$i]]="+") & (($i>1) & ($i<$numchars))
						$test:=False:C215
						$i:=$numchars+1
					: ($mystring[[$i]]="-") & ($i>1)
						$test:=False:C215
						$i:=$numchars+1
					Else 
						
						If (($mystring[[$i]]#"+") & ($mystring[[$i]]#"-"))
							$test:=False:C215
							$i:=$numchars+1
						End if 
						
				End case 
			End if 
		End for 
	End if 
End if 

$0:=$test

//End ut_IsALongint