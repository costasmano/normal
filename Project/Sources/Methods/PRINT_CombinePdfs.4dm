//%attributes = {"invisible":true}
//Method: PRINT_CombinePdfs
//Description
//  `Use PHP to combine pfs files from inspection reports
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 8/5/16, 18:22:51
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	// Modified by: Costas Manousakis-(Designer)-(8/29/16 14:26:59)
	Mods_2016_08
	//  `added message when combining pdfs
End if 
//
//ALERT("We did "+String(PRINT_destCount_L)+" spools")
ARRAY TEXT:C222($aForms; 0)
DOCUMENT LIST:C474(PRINT_TempDestFolder_txt; $aForms)
SORT ARRAY:C229($aForms)
C_LONGINT:C283($loop_L)
For ($loop_L; Size of array:C274($aForms); 1; -1)
	If ($aForms{$loop_L}#(PRINT_DestFileName_txt+"_@"))
		DELETE FROM ARRAY:C228($aForms; $loop_L; 1)
	End if 
End for 
C_TEXT:C284($resultPDF; $text)
$resultPDF:=ut_HFS_to_POSIX(PRINT_DestFolder_txt+PRINT_DestFileName_txt+".pdf")

If (Size of array:C274($aForms)=1)
	
	//MOVE DOCUMENT((PRINT_TempDestFolder_txt+$aForms{1});(PRINT_DestFolder_txt+PRINT_DestFileName_txt+".pdf"))
	COPY DOCUMENT:C541((PRINT_TempDestFolder_txt+$aForms{1}); (PRINT_DestFolder_txt+PRINT_DestFileName_txt+".pdf"); *)
	
Else 
	$text:="python \"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py\" -o \""+$resultPDF+"\""
	
	For ($loop_L; 1; Size of array:C274($aForms))
		If ($aForms{$loop_L}=(PRINT_DestFileName_txt+"_@"))
			$text:=$text+" \""+ut_HFS_to_POSIX(PRINT_TempDestFolder_txt+$aForms{$loop_L})+"\""
		End if 
		
	End for 
	SHORT_MESSAGE("Combining Multiple PDF output")
	LAUNCH EXTERNAL PROCESS:C811($text)
	
	//SHOW ON DISK(PRINT_TempDestFolder_txt+$aForms{1})
	CLOSE WINDOW:C154
End if 
SHOW ON DISK:C922(PRINT_DestFolder_txt+PRINT_DestFileName_txt+".pdf")
PRINT_PdfDest_b:=False:C215
//End PRINT_CombinePdfs