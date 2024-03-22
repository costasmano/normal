//%attributes = {"invisible":true}
//Method: PDF_CombinePdfs
//Description
// Combine pdfs using either pdftk on windows or python script join.py on mac
// Parameters
// $1 : $InputPdfs_ptr : pointer to array of filespecs to be combined
// $2 : $ResultFile_txt : filespec of output file
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-05 18:49:37
	// ----------------------------------------------------
	//Created : 
	Mods_2022_04
	
	C_POINTER:C301(PDF_CombinePdfs; $1)
	C_TEXT:C284(PDF_CombinePdfs; $2)
End if 
//
C_POINTER:C301($1; $InputPdfs_ptr)
C_TEXT:C284($2; $ResultFile_txt)
$InputPdfs_ptr:=$1
$ResultFile_txt:=$2
If (Is Windows:C1573)
	//windows
	C_TEXT:C284($pdfexe_; $inputPath; $Launch_txt; <>PDFTKLocation_txt)
	If ((<>PDFTKLocation_txt="") | (Test path name:C476(<>PDFTKLocation_txt)#Is a document:K24:1))
		C_TEXT:C284($res)
		ARRAY TEXT:C222($pdftkFiles_atxt; 0)
		$res:=Select document:C905(""; ".exe"; "Select PDFtk executable"; 0; $pdftkFiles_atxt)
		<>PDFTKLocation_txt:=$pdftkFiles_atxt{1}
		ut_ControlUserPrefs("SAVE")
	End if 
	$pdfexe_:=<>PDFTKLocation_txt
	If (Test path name:C476($pdfexe_)=Is a document:K24:1)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($InputPdfs_ptr->))
			$inputPath:=$inputPath+" \""+$InputPdfs_ptr->{$loop_L}+"\""
		End for 
		$Launch_txt:=$pdfexe_+" "+$inputPath+" cat output \""+$ResultFile_txt+"\""
		//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE";"false")
		C_TEXT:C284($stdin; $stdout; $stderr)
		LAUNCH EXTERNAL PROCESS:C811($Launch_txt; $stdin; $stdout; $stderr)
		
	Else 
		ALERT:C41("PDFTK executable \""+$pdfexe_+"\" not found!")
	End if 
	
Else 
	C_TEXT:C284($PathToPDFtk_txt)
	
	$PathToPDFtk_txt:=Convert path POSIX to system:C1107("/opt/pdflabs/pdftk/bin/pdftk")
	If (Test path name:C476($PathToPDFtk_txt)=Is a document:K24:1)
		C_TEXT:C284($inputPath)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($InputPdfs_ptr->))
			$inputPath:=$inputPath+" \""+Convert path system to POSIX:C1106($InputPdfs_ptr->{$loop_L})+"\""
		End for 
		$Launch_txt:="/opt/pdflabs/pdftk/bin/pdftk "+$inputPath+" cat output \""+Convert path system to POSIX:C1106($ResultFile_txt)+"\""
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		C_TEXT:C284($stdin; $stdout; $stderr)
		LAUNCH EXTERNAL PROCESS:C811($Launch_txt; $stdin; $stdout; $stderr)
	Else 
		ALERT:C41("PDFTK must be instaled on the machine. Please notify Administrator.")
	End if 
	
End if 

//End PDF_CombinePdfs