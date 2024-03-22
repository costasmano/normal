//%attributes = {"invisible":true}
// Method: INSP_ConvertWRtoWP
// Description
// convert an [inspections] inspection from 4D Write to Write Pro
// $0 : $Results_txt
// $1 : $Param_object
//  // .logchanges : boolean
//  // .useWritearea : longint: 4D Write area to use for conversion
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 01/19/21, 20:00:04
	// ----------------------------------------------------
	// First Release
	Mods_2021_WP
	
	C_TEXT:C284(INSP_ConvertWRtoWP; $0)
	C_OBJECT:C1216(INSP_ConvertWRtoWP; $1)
End if 

//C_TEXT($0;$Results)

//C_BOOLEAN($LogChanges_b;$UseLocalWKArea_b)
//$LogChanges_b:=False
//C_LONGINT($WKarea)
//$UseLocalWKArea_b:=True
//If (Count parameters>0)
//C_OBJECT($1)

//Case of 
//: ($1.logchanges=Null)  //not passed
//: (Value type($1.logchanges)#Is boolean)  //not a boolean
//Else 
//$LogChanges_b:=$1.logchanges
//End case 
//Case of 
//: ($1.useWritearea=Null)  //not passed
//: (Value type($1.useWritearea)#Is longint) & (Value type($1.useWritearea)#Is real)  //not a longint or real
//: ($1.useWritearea=0)  //not defined
//Else 
//$UseLocalWKArea_b:=False
//$WKarea:=$1.useWritearea
//End case 

//End if 

//$Results:=""
//C_LONGINT($charcount;$blobOffset)
//If ($WKarea=0)
//$WKarea:=‘12000;47‘ 
//Set Doc Margins ($WKarea)
//End if 

//C_BLOB($WPBlob;$FieldBlob)
//C_TEXT($tag;$Results)
//$tag:="WPAREA"
//QUERY([ElementsSafety];[ElementsSafety]InspID=[Inspections]InspID)
//QUERY SELECTION([ElementsSafety];[ElementsSafety]Comment Flag=True)

//QUERY([NTI_ELEM_BIN_INSP];[NTI_ELEM_BIN_INSP]INSPID=[Inspections]InspID)

//  //start the bar
//C_OBJECT($progress_o)
//$progress_o:=ProgressNew ("Converting Insp "+[Inspections]BIN+"-"+String([Inspections]InspID);(Records in selection([NTI_ELEM_BIN_INSP])+Records in selection([ElementsSafety])+2);False;" parts";3)

//C_TEXT($InspInfo_txt)
//$InspInfo_txt:=Char(Tab)+[Inspections]BIN+Char(Tab)+String([Inspections]InspID)+Char(Tab)+[Inspections]Insp Type+Char(Tab)

//  //InitChangeStack (1)
//C_BOOLEAN($changed_b)
//$changed_b:=False
//$Results:=String(Current date;ISO date;Current time)+$InspInfo_txt+\
"Orientation"+Char(Tab)+String(BLOB size([Inspections]OrientationText))+Char(Tab)

//  //update progress
//UpdateProgressNew ($progress_o;1)
//If (BLOB size([Inspections]OrientationText)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([Inspections]OrientationText;$WKarea)
//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[Inspections]OrientationText:=$FieldBlob
//$changed_b:=True

//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//Else 
//$Results:=$Results+"No Update needed"+Char(Carriage return)

//End if 
//Else 
//$Results:=$Results+"0"+Char(Carriage return)

//End if 

//$Results:=$Results+String(Current date;ISO date;Current time)+$InspInfo_txt+"Comments"+Char(Tab)+String(BLOB size([Inspections]InspComments))+Char(Tab)
//  //update progress
//UpdateProgressNew ($progress_o;2)

//If (BLOB size([Inspections]InspComments)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([Inspections]InspComments;$WKarea)
//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[Inspections]InspComments:=$FieldBlob
//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//$changed_b:=True
//Else 
//$Results:=$Results+"No Update needed"+Char(Carriage return)
//End if 

//Else 
//$Results:=$Results+"0"+Char(Carriage return)
//End if 

//If ($changed_b)

//If ($LogChanges_b)
//FlushGrpChgs (1;->[Bridge MHD NBIS]BIN;->[Inspections]BIN;->[Inspections]InspID;1)
//End if 

//SAVE RECORD([Inspections])
//End if 

//C_LONGINT($elm;$progresscount)
//$progresscount:=2
//For ($elm;1;Records in selection([ElementsSafety]))
//  //update progress
//$progresscount:=$progresscount+1
//UpdateProgressNew ($progress_o;$progresscount)

//GOTO SELECTED RECORD([ElementsSafety];$elm)

//$Results:=$Results+String(Current date;ISO date;Current time)+$InspInfo_txt+String([ElementsSafety]ElmSafetyID)+Char(Tab)+String(BLOB size([ElementsSafety]ElmComments))+Char(Tab)
//If (ut_LoadRecordInteractive (->[ElementsSafety]))
//If (BLOB size([ElementsSafety]ElmComments)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([ElementsSafety]ElmComments;$WKarea)

//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[ElementsSafety]ElmComments:=$FieldBlob
//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//If ($LogChanges_b)
//LogChanges (->[ElementsSafety]ElmComments;->[Inspections]InspID;->[ElementsSafety]InspID;->[ElementsSafety]ElmSafetyID;2)
//End if 
//SAVE RECORD([ElementsSafety])

//Else 
//$Results:=$Results+"No Update needed"+Char(Carriage return)
//End if 

//Else 
//$Results:=$Results+"0"+Char(Carriage return)

//End if 

//Else 
//$Results:=$Results+"NotLoaded"+Char(Carriage return)

//End if 

//End for 

//For ($elm;1;Records in selection([NTI_ELEM_BIN_INSP]))
//$progresscount:=$progresscount+1
//UpdateProgressNew ($progress_o;$progresscount)
//GOTO SELECTED RECORD([NTI_ELEM_BIN_INSP];$elm)
//$Results:=$Results+String(Current date;ISO date;Current time)+$InspInfo_txt+\
String([NTI_ELEM_BIN_INSP]ELEMID)+Char(Tab)+\
String(BLOB size([NTI_ELEM_BIN_INSP]ELEM_NOTES))+Char(Tab)

//If (ut_LoadRecordInteractive (->[NTI_ELEM_BIN_INSP]))
//If (BLOB size([NTI_ELEM_BIN_INSP]ELEM_NOTES)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([NTI_ELEM_BIN_INSP]ELEM_NOTES;$WKarea)

//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[NTI_ELEM_BIN_INSP]ELEM_NOTES:=$FieldBlob
//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//If ($LogChanges_b)
//LogChanges (->[NTI_ELEM_BIN_INSP]ELEM_NOTES;->[Inspections]InspID;->[NTI_ELEM_BIN_INSP]INSPID;->[NTI_ELEM_BIN_INSP]ELEMID;2)
//End if 
//SAVE RECORD([NTI_ELEM_BIN_INSP])

//Else 
//$Results:=$Results+"No Update needed"+Char(Carriage return)
//End if 

//SET BLOB SIZE($WPBlob;0)
//Else 
//$Results:=$Results+"0"+Char(Carriage return)

//End if 

//Else 
//$Results:=$Results+"NotLoaded"+Char(Carriage return)

//End if 

//End for 

//If ($UseLocalWKArea_b)  //clear a write area we created here
//‘12000;38‘ ($WKarea)
//End if 

//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//$0:=$Results