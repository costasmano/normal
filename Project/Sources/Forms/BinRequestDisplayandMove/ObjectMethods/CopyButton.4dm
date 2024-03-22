//Method: "BinRequestDisplayandMove".Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 15:44:18
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
End if 
//

C_TEXT:C284($CopyFrom_txt; $CopyTo_txt)
$CopyFrom_txt:=OBJECT Get title:C1068(*; "CopyFrom")
$CopyTo_txt:=OBJECT Get title:C1068(*; "CopyTo")
C_BOOLEAN:C305($DoCopy_B)
$DoCopy_B:=True:C214
If (Test path name:C476($CopyTo_txt)=Is a document:K24:1)
	CONFIRM:C162("Are you sure you want to replace file "+$CopyTo_txt; "Replace"; "Do Not Replace")
	$DoCopy_B:=(OK=1)
	//unload the file to be replaced from the web area for windows
	If ((Folder separator:K24:12="\\") & $DoCopy_B)
		WA OPEN URL:C1020(*; "ExistingBinRequest"; "about:blank")
		DELAY PROCESS:C323(Current process:C322; 10)  //nned to wait for the system to unlock the file
	End if 
	
End if 


If ($DoCopy_B)
	COPY DOCUMENT:C541($CopyFrom_txt; $CopyTo_txt; *)
	
	If (OK=1)
		SHOW ON DISK:C922($CopyTo_txt)
	Else 
		ALERT:C41("Copy Failed")
	End if 
Else 
	
	ALERT:C41("Copy from "+$CopyFrom_txt+" was cancelled")
End if 
CANCEL:C270
//End RatingReportDisplayandMove.Button