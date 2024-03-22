//%attributes = {"invisible":true}
//Method: ut_RunScript
//Description
// Run a scripttext either as a vbs (Windows) or applescript (Mac)
// return the result of the script
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 06/04/12, 12:33:51
	//----------------------------------------------------
	
	C_TEXT:C284(ut_RunScript; $0)
	C_TEXT:C284(ut_RunScript; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-09 14:05:03)
	Mods_2022_12_bug
	//  `convert to use File object
End if 
C_TEXT:C284($1; $0)

C_TEXT:C284($Parameters_t; $stdOut_t; $StdErr_t; $ScriptPath_t; $ScriptPath_HFS_t)
C_BLOB:C604($stdIn_x; $stdOut_x; $StdErr_x; $Script_x)
C_OBJECT:C1216($scriptFile)

If (Count parameters:C259=1)
	$scriptFile:=File:C1566(Temporary folder:C486+"$"+String:C10(Milliseconds:C459)+Choose:C955(Is Windows:C1573; ".vbs"; ".scpt"); fk platform path:K87:2)
	$scriptFile.create()
	CONVERT FROM TEXT:C1011($1; "UTF-8"; $Script_x)
	$scriptFile.setContent($Script_x)
	//$scriptFile.setText($1;"UTF-8";Document with native format) `setText does not seem to work with .vbs -> error line 1 char 1
	
	If (Is Windows:C1573)
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		
		LAUNCH EXTERNAL PROCESS:C811("cscript //Nologo //U \""+$scriptFile.path+"\""; $stdIn_x; $stdOut_x; $StdErr_x)
		$StdErr_t:=Convert to text:C1012($StdErr_x; "UTF-8")
		If ($StdErr_t#"")
			LOG EVENT:C667(Into 4D commands log:K38:7; Current method name:C684+": script error \n"+$StdErr_t)
		End if 
		$0:=Convert to text:C1012($stdOut_x; "UTF-8")
		
	Else 
		
		LAUNCH EXTERNAL PROCESS:C811("osascript \""+$scriptFile.path+"\""; $stdIn_x; $stdOut_x; $StdErr_x)
		
		$StdErr_t:=Convert to text:C1012($StdErr_x; "UTF-8")
		If ($StdErr_t#"")
			LOG EVENT:C667(Into 4D commands log:K38:7; Current method name:C684+": script error \n"+$StdErr_t)
			$0:=$StdErr_t
		End if 
		
	End if 
	
	If ($scriptFile.exists)
		$scriptFile.delete()
	End if 
	
End if 
//End ut_RunScript

