//%attributes = {"invisible":true}
//Method: NTI_ConvertInspections
//Description
// Convert NTI inspection data [tin_inspectons] from 4D Write to Write Pro
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/21, 17:24:21
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
End if 
//

//SET AUTOMATIC RELATIONS(False;False)
//ON ERR CALL("")
//QUERY([TIN_Inspections])

//If (OK=1)

//If (Records in selection([TIN_Inspections])>0)
//Progress QUIT (0)  // quit all p
//  //start the bar
//C_OBJECT($progress_o)
//$progress_o:=ProgressNew ("Conversion";Records in selection([TIN_Inspections]);True;" inspections";3)

//ARRAY TEXT($ConversionResults_atxt;Records in selection([TIN_Inspections]))
//C_LONGINT($Insp;$WKarea)
//C_TEXT($InspConversion_txt)

//$WKarea:=‘12000;47‘ 
//Set Doc Margins ($WKarea)
//C_OBJECT($ParamObj)
//C_BOOLEAN($logchanges_b)
//CONFIRM("Log conversion changes to activity log?";"Log";"Do Not Log")
//$logchanges_b:=(OK=1)
//$ParamObj:=New object("logchanges";$logchanges_b;"useWritearea";$WKarea)
//For ($Insp;1;Records in selection([TIN_Inspections]))
//  //update progress
//UpdateProgressNew ($progress_o;$Insp)
//GOTO SELECTED RECORD([TIN_Inspections];$Insp)
//$InspConversion_txt:=String([TIN_Inspections]InspectionID)+Char(Tab)+"Not Loaded"+Char(Carriage return)
//If (ut_LoadRecordInteractive (->[TIN_Inspections]))
//$InspConversion_txt:=NTI_ConvertWRToWP ($ParamObj)
//End if 
//$ConversionResults_atxt{$Insp}:=$InspConversion_txt

//  //check if progress stopped
//If (Progress Stopped (OB Get($progress_o;"progress";Is longint)))
//  //abort loop
//$Insp:=Records in selection([TIN_Inspections])+1
//End if 

//End for 

//  //clear 4D Write area
//‘12000;38‘ ($WKarea)
//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//C_TEXT($doc)
//ARRAY TEXT($docs;0)
//$doc:=Select document("";".txt";"Select text file for tab-delimited results";File name entry;$docs)

//If (Ok=1)
//C_TIME($doc_t)
//$doc_t:=Create document($docs{1})
//  //write header
//SEND PACKET($doc_t;"DateTime"+Char(Tab)+"BIN"+Char(Tab)+"InspID"+Char(Tab)+\
"Part or ElemID"+Char(Tab)+"old size"+Char(Tab)+"WP size"+Char(Carriage return))
//For ($Insp;1;Size of array($ConversionResults_atxt))
//SEND PACKET($doc_t;$ConversionResults_atxt{$Insp})
//End for 

//CLOSE DOCUMENT($doc_t)
//SHOW ON DISK($docs{1})
//End if 

//Else 
//ALERT("No inspections found!")
//End if 

//End if 
//End NTI_ConvertInspections