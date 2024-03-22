//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: InputProc
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: This procedure handles changing the menu bar
	//and window title for input layouts.
	
	//CB: All input procedures
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified:  10/5/95 to use process name instead of file name
	<>fK_Wilbur:=False:C215
	
End if 

C_TEXT:C284($sFilename; $sSelRec; $sRecsInSel)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($LStatus; $LTime)
PROCESS PROPERTIES:C336(Current process:C322; $sFilename; $LStatus; $LTime)

If (Is new record:C668(pFile->))  //This is a new record
	$sFilename:=$sFilename+" New Record"
Else   //Its an existing record
	$sSelRec:=String:C10(Selected record number:C246(pFile->))
	$sRecsInSel:=String:C10(Records in selection:C76(pFile->))
	$sFilename:=$sFilename+": "+$sSelRec+" of "+$sRecsInSel
End if 
SET WINDOW TITLE:C213($sFilename)
SET MENU BAR:C67(3)
//End of procedure
