//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/05, 16:19:25
	// ----------------------------------------------------
	// Method: G_GetServerDoc_Server
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 11:23:41      ` Type all local variables for v11
End if 
//TRACE
C_TEXT:C284($1; $Filename; $2; $PATH; $strPath)
C_BOOLEAN:C305($3; $resFork)
C_BLOB:C604(vBlob_Document)
$Filename:=$1
$PATH:=$2
$resFork:=$3
If (Length:C16($PATH)>0)
	//Add str path
	$strPath:=GetPath(Structure file:C489)
	Startup_PL
	C_TEXT:C284($PathSeparator)  // Command Replaced was o_C_STRING length was 1
	$PathSeparator:=<>PL_DirectorySep_s
	
	$Filename:=$strPath+$PATH+$PathSeparator+$Filename
End if 
If (Test path name:C476($Filename)=Is a document:K24:1)
	ON ERR CALL:C155("GetServerDocErr")
	If ($resFork)
		DOCUMENT TO BLOB:C525($Filename; vBlob_Document; *)
	Else 
		DOCUMENT TO BLOB:C525($Filename; vBlob_Document)
	End if 
	
	If (OK=1)
		C_LONGINT:C283(vl_DocSize)
		vl_DocSize:=BLOB size:C605(vBlob_Document)
		C_LONGINT:C283(spErrCode)
		spErrCode:=0
	Else 
		C_LONGINT:C283(spErrCode)
		spErrCode:=-2
	End if 
	ON ERR CALL:C155("")
Else 
	C_LONGINT:C283(spErrCode)
	spErrCode:=-1
End if 
Repeat 
	DELAY PROCESS:C323(Current process:C322; 10)
Until (spErrCode>0)

SET BLOB SIZE:C606(vBlob_Document; 0)