//%attributes = {"invisible":true}
//Method: DCM_ConvertWrToWP
//Description
//convert all 4D Write blobs in DCM_Workorders to WritePro
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/24/21, 18:27:02
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
End if 
//

//ALL RECORDS([DCM_WorkOrders])

//C_LONGINT($WO_L)
//$WO_L:=Records in selection([DCM_WorkOrders])
//ARRAY TEXT($ConversionResults_atxt;Records in selection([DCM_WorkOrders]))
//  //start the bar
//C_OBJECT($progress_o)
//$progress_o:=ProgressNew ("Converting Work orders to WP";$WO_L;True;" work orders";3)

//C_TEXT($LofFile_txt;$logFolder_txt)
//$logFolder_txt:=System folder(Documents folder)+"WPConversion"
//If (Test path name($logFolder_txt)#Is a folder)
//CREATE FOLDER($logFolder_txt)
//End if 
//$LofFile_txt:=$logFolder_txt+Folder separator+"DCM_ConvertWrToWP-log.txt"

//C_LONGINT($charcount;$blobOffset)
//C_LONGINT($WKarea)
//$WKarea:=‘12000;47‘ 
//Set Doc Margins ($WKarea)
//C_BOOLEAN($SaveWO_b)
//For ($WO_L;1;Records in selection([DCM_WorkOrders]))
//  //update progress
//UpdateProgressNew ($progress_o;$WO_L)
//GOTO SELECTED RECORD([DCM_WorkOrders];$WO_L)
//If (ut_LoadRecordInteractive (->[DCM_WorkOrders]))
//$ConversionResults_atxt{$WO_L}:=String(Current date;ISO date;Current time)+Char(Tab)+\
String([DCM_WorkOrders]AssignID)+Char(Tab)+\
String(BLOB size([DCM_WorkOrders]WriteBlobs_x))+Char(Tab)

//If (BLOB size([DCM_WorkOrders]WriteBlobs_x)>0)
//DCM_ContrBidItems ("LOAD")
//DCM_ControlWOBlobs ("INIT")
//$SaveWO_b:=False
//If (BLOB size(DCM_WO_SpecInst_x)>0)
//DCM_WO_SpecInst_x:=Convert_WKStyleTxtToWP (DCM_WO_SpecInst_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Traffic_x)>0)
//DCM_WO_Traffic_x:=Convert_WKStyleTxtToWP (DCM_WO_Traffic_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Sched_x)>0)
//DCM_WO_Sched_x:=Convert_WKStyleTxtToWP (DCM_WO_Sched_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Scope_x)>0)
//DCM_WO_Scope_x:=Convert_WKStyleTxtToWP (DCM_WO_Scope_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Deficiency_x)>0)
//DCM_WO_Deficiency_x:=Convert_WKStyleTxtToWP (DCM_WO_Deficiency_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Equipment_x)>0)
//DCM_WO_Equipment_x:=Convert_WKStyleTxtToWP (DCM_WO_Equipment_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Engrng_x)>0)
//DCM_WO_Engrng_x:=Convert_WKStyleTxtToWP (DCM_WO_Engrng_x;$WKarea)
//$SaveWO_b:=True
//End if 
//If (BLOB size(DCM_WO_Material_x)>0)
//DCM_WO_Material_x:=Convert_WKStyleTxtToWP (DCM_WO_Material_x;$WKarea)
//$SaveWO_b:=True
//End if 

//If ($SaveWO_b)
//DCM_ControlWOBlobs ("SAVE")
//SAVE RECORD([DCM_WorkOrders])
//End if 
//End if 
//$ConversionResults_atxt{$WO_L}:=$ConversionResults_atxt{$WO_L}+\
Choose($SaveWO_b;"Saved";"NoChange")+Char(Tab)+String(BLOB size([DCM_WorkOrders]WriteBlobs_x))+Char(Carriage return)
//Else 
//$ConversionResults_atxt{$WO_L}:=String(Current date;ISO date;Current time)+Char(Tab)+\
String([DCM_WorkOrders]AssignID)+Char(Tab)+"Could not be loaded"+Char(Carriage return)
//End if 
//  //check if progress stopped
//If (Progress Stopped (OB Get($progress_o;"progress";Is longint)))
//$WO_L:=Records in selection([DCM_WorkOrders])+1  //abort loop
//End if 

//End for 

//‘12000;38‘ ($WKarea)

//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//C_TIME($doc_t)
//$doc_t:=Create document($LofFile_txt)
//  //write header
//SEND PACKET($doc_t;"DateTime"+Char(Tab)+"AssignID"+Char(Tab)+\
"old size"+Char(Tab)+"Action"+Char(Tab)+"WP size"+Char(Carriage return))
//For ($WO_L;1;Size of array($ConversionResults_atxt))
//SEND PACKET($doc_t;$ConversionResults_atxt{$WO_L})
//End for 
//CLOSE DOCUMENT($doc_t)


//  //End DCM_ConvertWrToWP