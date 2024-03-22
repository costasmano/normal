//%attributes = {"invisible":true}
//Method: TextToSpeach
//Description
// speak a text from  kb.4d  http://kb.4d.com/assetid=78019
// Parameters
// $1 : Text to speak
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/15/18, 12:43:42
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	
	C_TEXT:C284(TextToSpeach; $1)
	
End if 
//

C_TEXT:C284($1; $cmd; $in; $out; $err; $textToSpeech)
If (Count parameters:C259=1)
	$textToSpeech:=$1
	If (Folder separator:K24:12=":")
		// mac
		$cmd:="say "+$textToSpeech
	Else 
		//windows
		$cmd:="PowerShell -Command \"Add-Type –AssemblyName System.Speech;(New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('"+$textToSpeech+"');\""
	End if 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
End if 
//End TextToSpeach