//%attributes = {"invisible":true}
//Method: INSP_ConvertInspections
//Description
// convert inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/26/21, 13:40:57
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_BLOB:C604(INSP_ConvertInspections; $1)
	
End if 

//  //
//C_BLOB($1)

//ARRAY LONGINT($recNums_aL;0)
//ARRAY LONGINT($RecIds_aL;0)
//ARRAY LONGINT($RecIdsDone_aL;0)

//BLOB TO VARIABLE($1;$recNums_aL)

//SET AUTOMATIC RELATIONS(False;False)
//ON ERR CALL("")

//CREATE SELECTION FROM ARRAY([Inspections];$recNums_aL)
//SELECTION TO ARRAY([Inspections]InspID;$RecIds_aL)
//ARRAY LONGINT($RecIdsDone_aL;Size of array($RecIds_aL))
//  //QUERY([Inspections])
//C_BLOB($LogBlob_x)
//C_TEXT($LofFile_txt;$logFolder_txt;$resultsFile_txt)
//$logFolder_txt:=System folder(Documents folder)+"WPConversion"
//$LofFile_txt:=$logFolder_txt+Folder separator+Current process name+"-log.txt"
//$resultsFile_txt:=$logFolder_txt+Folder separator+Current process name+"-results.txt"

//If (Records in selection([Inspections])>0)

//ORDER BY([Inspections];[Inspections]InspID;>)
//  //Progress QUIT (0)  // quit all p
//  //start the bar
//C_OBJECT($progress_o)
//$progress_o:=ProgressNew (Current process name;Records in selection([Inspections]);True;" inspections";3)

//ARRAY TEXT($ConversionResults_atxt;Records in selection([Inspections]))
//C_LONGINT($Insp;$WKarea)
//C_TEXT($InspConversion_txt)

//$WKarea:=‘12000;47‘ 
//Set Doc Margins ($WKarea)
//C_OBJECT($ParamObj)
//C_BOOLEAN($logchanges_b)
//  //CONFIRM("Log conversion changes to activity log?";"Log";"Do Not Log")
//$logchanges_b:=False
//$ParamObj:=New object("logchanges";$logchanges_b;"useWritearea";$WKarea)
//For ($Insp;1;Records in selection([Inspections]))
//  //update progress
//UpdateProgressNew ($progress_o;$Insp)
//GOTO SELECTED RECORD([Inspections];$Insp)
//$InspConversion_txt:=String([Inspections]InspID)+Char(Tab)+"Not Loaded"+Char(Carriage return)
//If (ut_LoadRecordInteractive (->[Inspections]))
//$InspConversion_txt:=INSP_ConvertWRtoWP ($ParamObj)
//FLUSH CACHE
//End if 
//$ConversionResults_atxt{$Insp}:=$InspConversion_txt
//$RecIdsDone_aL{$Insp}:=$RecIds_aL{$Insp}

//SET BLOB SIZE($LogBlob_x;0)
//VARIABLE TO BLOB($recNums_aL;$LogBlob_x)
//VARIABLE TO BLOB($RecIds_aL;$LogBlob_x;*)
//VARIABLE TO BLOB($RecIdsDone_aL;$LogBlob_x;*)
//BLOB TO DOCUMENT($LofFile_txt;$LogBlob_x)
//  //check if progress stopped
//If (Progress Stopped (OB Get($progress_o;"progress";Is longint)))
//  //abort loop
//$Insp:=Records in selection([Inspections])+1
//End if 

//End for 

//  //clear 4D Write area
//‘12000;38‘ ($WKarea)
//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//C_TIME($doc_t)
//$doc_t:=Create document($resultsFile_txt)
//  //write header
//SEND PACKET($doc_t;"DateTime"+Char(Tab)+"BIN"+Char(Tab)+"InspID"+Char(Tab)+"InspType"+Char(Tab)+\
"Part or ElemID"+Char(Tab)+"old size"+Char(Tab)+"WP size"+Char(Carriage return))
//For ($Insp;1;Size of array($ConversionResults_atxt))
//SEND PACKET($doc_t;$ConversionResults_atxt{$Insp})
//End for 
//CLOSE DOCUMENT($doc_t)

//Else 
//ALERT("No inspections found!")
//End if 

//End INSP_ConvertInspections