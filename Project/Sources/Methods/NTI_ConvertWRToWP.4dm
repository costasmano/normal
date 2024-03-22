//%attributes = {"invisible":true}
//Method: NTI_ConvertWRToWP
//Description
// convert the 4D Write blobs for the current NTI inspection record to 4D Write PRO
// Parameters
// $0 : $Results_txt
// $1 : $Param_object
//  // .logchanges : boolean
//  // .useWritearea : longint: 4D Write area to use for conversion
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/08/21, 16:46:19
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_TEXT:C284(NTI_ConvertWRToWP; $0)
	C_OBJECT:C1216(NTI_ConvertWRToWP; $1)
	
End if 
//

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

//SET AUTOMATIC RELATIONS(False;False)
//QUERY([NTI_ELEM_TIN_INSP];[NTI_ELEM_TIN_INSP]InspectionID=[TIN_Inspections]InspectionID)
//QUERY([TIN_Insp_Comments];[TIN_Insp_Comments]InspectionID=[TIN_Inspections]InspectionID)

//  //start the bar
//C_OBJECT($progress_o)
//$progress_o:=ProgressNew ("Converting Insp "+[TIN_Inspections]NTI_i1_S+"-"+String([TIN_Inspections]InspectionID);\
(Records in selection([TIN_Insp_Comments])+Records in selection([NTI_ELEM_TIN_INSP])+1);False;" parts";3)
//InitChangeStack (1)

//$Results:=String(Current date;ISO date;Current time)+Char(Tab)+[TIN_Inspections]NTI_i1_S+Char(Tab)+\
String([TIN_Inspections]InspectionID)+Char(Tab)+\
"Comments"+Char(Tab)+String(BLOB size([TIN_Inspections]Comments))+Char(Tab)

//  //update progress
//UpdateProgressNew ($progress_o;1)
//If (BLOB size([TIN_Inspections]Comments)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([TIN_Inspections]Comments;$WKarea)
//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[TIN_Inspections]Comments:=$FieldBlob
//PushChange (1;->[TIN_Inspections]Comments)

//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//Else 
//$Results:=$Results+"No Update needed"+Char(Carriage return)

//End if 
//Else 
//$Results:=$Results+"0"+Char(Carriage return)

//End if 


//If (Size of array(PTR_CHANGES{1})>0)

//SAVE RECORD([TIN_Inspections])
//End if 

//C_LONGINT($elm;$progresscount)
//$progresscount:=1
//For ($elm;1;Records in selection([TIN_Insp_Comments]))
//  //update progress
//$progresscount:=$progresscount+1
//UpdateProgressNew ($progress_o;$progresscount)

//GOTO SELECTED RECORD([TIN_Insp_Comments];$elm)

//$Results:=$Results+String(Current date;ISO date;Current time)+Char(Tab)+[TIN_Inspections]NTI_i1_S+Char(Tab)+\
String([TIN_Inspections]InspectionID)+Char(Tab)+String([TIN_Insp_Comments]TIN_InspCommentID_L)+Char(Tab)+\
String(BLOB size([TIN_Insp_Comments]Comment_blb))+Char(Tab)
//If (ut_LoadRecordInteractive (->[TIN_Insp_Comments]))
//If (BLOB size([TIN_Insp_Comments]Comment_blb)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([TIN_Insp_Comments]Comment_blb;$WKarea)

//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[TIN_Insp_Comments]Comment_blb:=$FieldBlob
//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//SAVE RECORD([TIN_Insp_Comments])

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

//For ($elm;1;Records in selection([NTI_ELEM_TIN_INSP]))
//  //update progress
//$progresscount:=$progresscount+1
//UpdateProgressNew ($progress_o;$progresscount)

//GOTO SELECTED RECORD([NTI_ELEM_TIN_INSP];$elm)

//$Results:=$Results+String(Current date;ISO date;Current time)+Char(Tab)+[TIN_Inspections]NTI_i1_S+Char(Tab)+\
String([TIN_Inspections]InspectionID)+Char(Tab)+String([NTI_ELEM_TIN_INSP]ELEMID)+Char(Tab)+\
String(BLOB size([NTI_ELEM_TIN_INSP]ELEM_NOTES))+Char(Tab)
//If (ut_LoadRecordInteractive (->[TIN_Insp_Comments]))
//If (BLOB size([NTI_ELEM_TIN_INSP]ELEM_NOTES)>0)
//$WPBlob:=Convert_WKStyleTxtToWP ([NTI_ELEM_TIN_INSP]ELEM_NOTES;$WKarea)

//If (BLOB size($WPBlob)>0)
//SET BLOB SIZE($FieldBlob;0)
//VARIABLE TO BLOB($tag;$FieldBlob)
//VARIABLE TO BLOB($WPBlob;$FieldBlob;*)

//COMPRESS BLOB($FieldBlob)
//[NTI_ELEM_TIN_INSP]ELEM_NOTES:=$FieldBlob
//$Results:=$Results+String(BLOB size($FieldBlob))+Char(Carriage return)
//SAVE RECORD([NTI_ELEM_TIN_INSP])

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

//If ($UseLocalWKArea_b)  //clear a write area we created here
//‘12000;38‘ ($WKarea)
//End if 

//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//$0:=$Results

//  //End NTI_ConvertWRToWP