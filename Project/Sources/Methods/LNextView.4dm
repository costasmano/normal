//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: LNextView(string) -> longint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - string - Name of Process to create
	
	//Returns -> longint - Next View number to create
	
	//Purpose:  Gets the next view number available and returns it
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 13:39:11)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(11/19/15 12:55:10)
	Mods_2015_11_bug
	//  `changed $1 to 31 length
End if 

C_LONGINT:C283($0; $LLoc)
C_TEXT:C284($1; $sProcName)  // Command Replaced was o_C_STRING length was 31

$sProcName:=$1
$LLoc:=Find in array:C230(<>asViewName; $sProcName)

If ($LLoc=-1)
	While (Semaphore:C143("$ModViewArrays"))
		DELAY PROCESS:C323(Current process:C322; 1)
	End while 
	
	$LLoc:=Size of array:C274(<>asViewName)+1
	ARRAY TEXT:C222(<>asViewName; $LLoc)  //Command Replaced was o_ARRAY string length was 80
	ARRAY LONGINT:C221(<>aLViewNum; $LLoc)
	<>asViewName{$LLoc}:=$sProcName
	CLEAR SEMAPHORE:C144("$ModViewArrays")
End if 

<>aLViewNum{$LLoc}:=<>aLViewNum{$LLoc}+1
$0:=<>aLViewNum{$LLoc}
//End of procedure