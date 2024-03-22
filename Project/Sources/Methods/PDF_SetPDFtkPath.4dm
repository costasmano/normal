//%attributes = {"invisible":true}
//Method: PDF_SetPDFtkPath
//Description
// Set/update the PDFtk path used in combining pdfs on Windows
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-06 09:19:15
	// ----------------------------------------------------
	//Created : 
	Mods_2022_04
End if 
//
C_TEXT:C284(<>PDFTKLocation_txt; $res)
ARRAY TEXT:C222($pdftkFiles_atxt; 0)
ut_ControlUserPrefs("init")

If (Is Windows:C1573)
	C_TEXT:C284($msg)
	
	Case of 
		: (<>PDFTKLocation_txt="")
			$msg:="The path for PDFtk.exe is blank! Do you wish to set it?"
		: (Test path name:C476(<>PDFTKLocation_txt)#Is a document:K24:1)
			$msg:="The current path for PDFtk.exe \""+<>PDFTKLocation_txt+"\" cannot be found! Do you wish to update it?"
		Else 
			$msg:="The current path for PDFtk.exe is \""+<>PDFTKLocation_txt+"\" . Do you wish to update it?"
	End case 
	
	CONFIRM:C162($msg)
	
	If (OK=1)
		
		$res:=Select document:C905(""; ".exe"; "Select PDFtk executable"; 0; $pdftkFiles_atxt)
		
		If (OK=1)
			<>PDFTKLocation_txt:=$pdftkFiles_atxt{1}
			ut_ControlUserPrefs("SAVE")
		Else 
			ALERT:C41("PDFtk path not updated!")
		End if 
		
	End if 
	
Else 
	ALERT:C41("PDFtk is only usable on Windows!")
End if 

//End PDF_SetPDFtkPath