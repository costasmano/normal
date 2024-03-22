//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 06/04/12, 12:36:36
//----------------------------------------------------
//Method: ut_Posix
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_POINTER:C301($1)
If (Count parameters:C259=1)
	
	If (Not:C34(Is nil pointer:C315($1)))
		
		If (Type:C295($1->)=Is text:K8:3)
			
			C_TEXT:C284($AppleScriptPath_t; $TargetVolume_t; $Delimiter_t; $SystemFolder_t; $BootVolume_t)
			$AppleScriptPath_t:=Replace string:C233($1->; ":"; "/")
			$TargetVolume_t:=Substring:C12($AppleScriptPath_t; 1; Position:C15("/"; $AppleScriptPath_t)-1)
			
			$SystemFolder_t:=System folder:C487(System:K41:1)
			$BootVolume_t:=Substring:C12($SystemFolder_t; 1; Position:C15(Folder separator:K24:12; $SystemFolder_t)-1)
			
			If ($BootVolume_t=$TargetVolume_t)  //Is Macintosh HD
				
				$AppleScriptPath_t:=Substring:C12($AppleScriptPath_t; Position:C15("/"; $AppleScriptPath_t))
				
			Else 
				
				$AppleScriptPath_t:="/Volumes/"+$AppleScriptPath_t
				
			End if 
			
			$1->:=Replace string:C233($AppleScriptPath_t; " "; "\\ ")
			
		End if 
		
	End if 
	
End if 
//End ut_Posix

