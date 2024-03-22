//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/13/05, 12:14:07
	// ----------------------------------------------------
	// Method: G_GetDirList_Server
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	
End if 
C_TEXT:C284($1; $FolderName)
C_BLOB:C604(vBlob_Document)
$FolderName:=$1
//TRACE
ARRAY TEXT:C222($arr_FileList_txt; 0)
If (Test path name:C476($FolderName)=Is a folder:K24:2)
	ON ERR CALL:C155("GetServerDocErr")
	DOCUMENT LIST:C474($FolderName; $arr_FileList_txt)
	If (OK=1)
		VARIABLE TO BLOB:C532($arr_FileList_txt; vBlob_Document)
		COMPRESS BLOB:C534(vBlob_Document)
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
ARRAY TEXT:C222($arr_FileList_txt; 0)