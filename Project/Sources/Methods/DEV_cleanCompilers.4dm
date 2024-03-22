//%attributes = {"invisible":true}
//Method: DEV_cleanCompilers
//Description
// Test to find double entries in Compiler_xx methods
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/30/16, 14:53:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
	// Modified by: Costas Manousakis-(Designer)-(8/30/17 16:35:34)
	Mods_2017_08
	//  `fixed $varName_ttx when it contains {} or () in case of compiler declarations for methods
	// save the cleaned compiler method under name "Oldname"+"_0"
	//save the removed lines to another method called "oldname"+"_1"
End if 
//
// the default ones are 
ARRAY TEXT:C222($DefaultCompilers_atxt; 0)
APPEND TO ARRAY:C911($DefaultCompilers_atxt; "Compiler_Arrays")
APPEND TO ARRAY:C911($DefaultCompilers_atxt; "Compiler_Arrays_Inter")
APPEND TO ARRAY:C911($DefaultCompilers_atxt; "Compiler_Variables")
APPEND TO ARRAY:C911($DefaultCompilers_atxt; "Compiler_Variables_Inter")
APPEND TO ARRAY:C911($DefaultCompilers_atxt; "Compiler_Methods")

ARRAY TEXT:C222($Compiler_methods_atxt; 0)
ARRAY TEXT:C222($Compiler_paths_atxt; 0)
METHOD GET NAMES:C1166($Compiler_methods_atxt; "Compiler@")

C_LONGINT:C283($loop_L)
For ($loop_L; Size of array:C274($Compiler_methods_atxt); 1; -1)
	If (Find in array:C230($DefaultCompilers_atxt; $Compiler_methods_atxt{$loop_L})>0)
		DELETE FROM ARRAY:C228($Compiler_methods_atxt; $loop_L; 1)
	End if 
	
End for 

ARRAY TEXT:C222($method_Code_atxt; 0)

METHOD GET CODE:C1190($Compiler_methods_atxt; $method_Code_atxt)

C_LONGINT:C283($loop_L)
C_TEXT:C284($method_txt)
ARRAY TEXT:C222($DuplDeclarations_atxt; 0)
C_LONGINT:C283($defaultProgress_L; $LineProgress_L)
$defaultProgress_L:=Progress New
Progress SET TITLE($defaultProgress_L; "Default compiler methods")
For ($loop_L; 1; Size of array:C274($DefaultCompilers_atxt))
	Progress SET PROGRESS($defaultProgress_L; ($loop_L/Size of array:C274($DefaultCompilers_atxt)))
	Progress SET MESSAGE($defaultProgress_L; $DefaultCompilers_atxt{$loop_L})
	ARRAY TEXT:C222($Lines_atxt; 0)
	METHOD GET CODE:C1190($DefaultCompilers_atxt{$loop_L}; $method_txt)
	ut_TextToArray($method_txt; ->$Lines_atxt; "\r")
	C_TEXT:C284($varName_txt; $varNamePattern_txt)
	C_BOOLEAN:C305($matchPattern_b)
	C_LONGINT:C283($loop2_L)
	$LineProgress_L:=Progress New
	Progress SET TITLE($LineProgress_L; String:C10(Size of array:C274($Lines_atxt))+" Lines")
	Progress SET PROGRESS($LineProgress_L; 0)
	
	ARRAY LONGINT:C221($removeLines_aL; 0)
	C_BOOLEAN:C305($removeLine_b)
	For ($loop2_L; 1; Size of array:C274($Lines_atxt))
		$varName_txt:=""
		Case of 
			: ($Lines_atxt{$loop2_L}="ARRAY @") | ($Lines_atxt{$loop2_L}="_o_ARRAY @")  //array 
				
				If ($Lines_atxt{$loop2_L}="@Array string(@")
					$varName_txt:=Substring:C12($Lines_atxt{$loop2_L}; (Position:C15(";"; $Lines_atxt{$loop2_L})+1))
				Else 
					$varName_txt:=Substring:C12($Lines_atxt{$loop2_L}; (Position:C15("("; $Lines_atxt{$loop2_L})+1))
					
				End if 
				$varName_txt:=Substring:C12($varName_txt; 1; (Position:C15(";"; $varName_txt)-1))
				
			: ($Lines_atxt{$loop2_L}="C_@") | ($Lines_atxt{$loop2_L}="_o_C_@")  //variable 
				
				If ($Lines_atxt{$loop2_L}="@C_String(@")
					$varName_txt:=Substring:C12($Lines_atxt{$loop2_L}; (Position:C15(";"; $Lines_atxt{$loop2_L})+1))
					
				Else 
					$varName_txt:=Substring:C12($Lines_atxt{$loop2_L}; (Position:C15("("; $Lines_atxt{$loop2_L})+1))
					
				End if 
				
				$varName_txt:=Substring:C12($varName_txt; 1; (Position:C15(")"; $varName_txt)-1))
			Else 
				
		End case 
		
		$removeLine_b:=False:C215
		
		If ($varName_txt#"")
			//now we search the other compiler methods
			$varName_txt:=Replace string:C233($varName_txt; "("; "\\(")
			$varName_txt:=Replace string:C233($varName_txt; ")"; "\\)")
			$varName_txt:=Replace string:C233($varName_txt; "{"; "\\{")
			$varName_txt:=Replace string:C233($varName_txt; "}"; "\\}")
			$varNamePattern_txt:=Uppercase:C13("[;,\\(]("+$varName_txt+")[;,\\)]")
			C_LONGINT:C283($loop3_L; $PosFound_L; $LenFound_L)
			For ($loop3_L; 1; Size of array:C274($method_Code_atxt))
				$matchPattern_b:=Match regex:C1019($varNamePattern_txt; Uppercase:C13($method_Code_atxt{$loop3_L}); 1; $PosFound_L; $LenFound_L)
				If ($matchPattern_b)
					APPEND TO ARRAY:C911($DuplDeclarations_atxt; ($varName_txt+" "+$DefaultCompilers_atxt{$loop_L}+" "+$Compiler_methods_atxt{$loop3_L}))
					$removeLine_b:=True:C214
				End if 
			End for 
			
		End if 
		
		If ($removeLine_b)
			APPEND TO ARRAY:C911($removeLines_aL; $loop2_L)
		End if 
		If (($loop2_L%20)=0)
			Progress SET PROGRESS($LineProgress_L; ($loop2_L/Size of array:C274($Lines_atxt)))
		End if 
	End for 
	
	If (Size of array:C274($removeLines_aL)>0)
		//fix the method code
		C_TEXT:C284($newMethod_txt; $removeLines_txt)
		$newMethod_txt:=""
		$removeLines_txt:=""
		For ($loop2_L; 1; Size of array:C274($Lines_atxt))
			If (Find in array:C230($removeLines_aL; $loop2_L)>0)
				$removeLines_txt:=$removeLines_txt+$Lines_atxt{$loop2_L}+"\r"
			Else 
				$newMethod_txt:=$newMethod_txt+$Lines_atxt{$loop2_L}+"\r"
			End if 
			
		End for 
		C_TEXT:C284($NewName_txt)
		ALERT:C41("Creating new Methods: Cleaned ["+$DefaultCompilers_atxt{$loop_L}+"_0"+"]  and remove lines ["+$DefaultCompilers_atxt{$loop_L}+"_1]")
		$NewName_txt:=$DefaultCompilers_atxt{$loop_L}+"_0"
		METHOD SET CODE:C1194($NewName_txt; $newMethod_txt)
		$NewName_txt:=$DefaultCompilers_atxt{$loop_L}+"_1"
		METHOD SET CODE:C1194($NewName_txt; $removeLines_txt)
	End if 
	Progress QUIT($LineProgress_L)
End for 
Progress QUIT($defaultProgress_L)

ut_DisplayArray(->$DuplDeclarations_atxt; "Duplicate Declarations"; "Variable/Method name")
//End Test_DEV_cleanCompilers