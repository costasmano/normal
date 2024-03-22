//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: UpdatWindArray(string;longint;boolean)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - String = Process or window name to display in popup
	//$2 - Longint = (Optional) Process ID  
	//$3 - Boolean = (Optional) Background process  
	
	//Purpose: Adds and deletes window from the files palette
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_TEXT:C284($1; $sProcName)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($2; $LLoc; $LSize; $LCurrProc; $LState; $LTime)
C_BOOLEAN:C305($3)
If (Not:C34(<>fQuit))
	If (Count parameters:C259>1)
		$LCurrProc:=$2
		PROCESS PROPERTIES:C336($LCurrProc; $sProcName; $LState; $LTime)
		If (Count parameters:C259=3)  //Background process store negative process number
			$LCurrProc:=$2*-1
		End if 
	Else 
		$sProcName:=$1
		$LCurrProc:=Current process:C322
	End if 
	
	$LLoc:=Find in array:C230(<>asWindows; $sProcName)
	
	While (Semaphore:C143("$ModWindArrays"))
		DELAY PROCESS:C323($LCurrProc; 1)
	End while 
	
	If ($LLoc=-1)
		$LSize:=Size of array:C274(<>asWindows)
		ARRAY TEXT:C222(<>asWindows; $LSize+1)  //Command Replaced was o_ARRAY string length was 80
		ARRAY INTEGER:C220(<>aiWindows; $LSize+1)
		<>asWindows{$LSize+1}:=$sProcName
		<>aiWindows{$LSize+1}:=$LCurrProc
	Else 
		DELETE FROM ARRAY:C228(<>asWindows; $LLoc)
		DELETE FROM ARRAY:C228(<>aiWindows; $LLoc)
		<>asWindows:=1
		<>aiWindows{0}:=1
		POST OUTSIDE CALL:C329(-1)
	End if 
	
	CLEAR SEMAPHORE:C144("$ModWindArrays")
	UpdatFilesPalet
End if 
//End of procedure 