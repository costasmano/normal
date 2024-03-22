//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/06, 22:02:48
	// ----------------------------------------------------
	// Method: ut_RetrieveUIGVarrDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_BOOLEAN:C305($UseFile_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$Filename:="InitUIGVVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)

If ($UseFile_b=True:C214)
	C_LONGINT:C283($BlobOffSet_l)
	
	ARRAY TEXT:C222(<>aSIAPages; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY INTEGER:C220(<>aSIAPageNo; 0)
	ARRAY TEXT:C222(<>aNBIPages; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY LONGINT:C221(<>aNBIPageNo; 0)
	ARRAY POINTER:C280(<>aNBIField; 0)
	ARRAY TEXT:C222(<>aObjectName; 0)  //Command Replaced was o_ARRAY string length was 15
	ARRAY LONGINT:C221(<>aFieldNum; 0)
	C_LONGINT:C283(<>MaxSIAFlds; $i)
	ARRAY TEXT:C222(<>asFields; 0)  //Command Replaced was o_ARRAY string length was 19
	ARRAY POINTER:C280(<>apFlds; 0)
	ARRAY TEXT:C222(<>asFldTypes; 0)  //Command Replaced was o_ARRAY string length was 8
	ARRAY INTEGER:C220($arrFldNos; 0)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aSIAPages; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aSIAPageNo; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $arrFldNos; $BlobOffSet_l)
	ARRAY POINTER:C280(<>aNBIField; Size of array:C274($arrFldNos))
	For ($i; 1; Size of array:C274($arrFldNos))
		If ($arrFldNos{$i}>0)
			<>aNBIField{$i}:=Field:C253(1; $arrFldNos{$i})
			
		End if 
	End for 
	<>aNBIField{5}:=->v6Descr  //[Bridge MHD NBIS]Item6A
	<>aNBIField{6}:=->v7Descr  //[Bridge MHD NBIS]Item7
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aNBIPages; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aNBIPageNo; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aObjectName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aFieldNum; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>MaxSIAFlds; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>asFields; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $arrFldNos; $BlobOffSet_l)
	ARRAY POINTER:C280(<>apFlds; Size of array:C274($arrFldNos))
	For ($i; 1; Size of array:C274($arrFldNos))
		<>apFlds{$i}:=Field:C253(1; $arrFldNos{$i})
	End for 
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>asFldTypes; $BlobOffSet_l)
	
	ARRAY INTEGER:C220($arrFldNos; 0)
	
Else 
	INIT_UI_GV_LoadArrays
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)