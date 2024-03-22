//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: WindowTitle
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Updates the Output window title as needed
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified:  10/5/95 to use process name instead of file name
	<>fK_Wilbur:=False:C215
	
	//Modified:  2/20/97 to use file name or RegionTitle.  Process name
	//would be okay if we created the process procedurally, but processes
	//are currently initiated by the menu system and the names given are
	//not very meaningful.
	<>fT_Nee:=False:C215
	
End if 

If (Table name:C256(pfile)="Bridge MHD NBIS")
	//Call RegionTitle instead
	RegionTitle
Else 
	//Standard title.  
	//  C_STRING(20;$sFilename;$sRecsInSel;$sRecsInFile)
	//  C_LONGINT($LStatus;$LTime)
	//  PROCESS ATTRIBUTES(Current process;$sFilename;$LStatus;$LTime)
	C_TEXT:C284($sRecsInSel; $sRecsInFile)  // Command Replaced was o_C_STRING length was 10
	$sRecsInSel:=String:C10(Records in selection:C76(pFile->))
	$sRecsInFile:=String:C10(Records in table:C83(pFile->))
	//  SET WINDOW TITLE($sFilename+": "+$sRecsInSel+" of "+$sRecsInFile)
	SET WINDOW TITLE:C213(Table name:C256(pfile)+": "+$sRecsInSel+" of "+$sRecsInFile)
End if 
//End of procedure