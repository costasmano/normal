//%attributes = {"invisible":true}
//Method: INSP_CreateApprovedPDFS
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/19/21, 13:14:33
	// ----------------------------------------------------
	//Created : 
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_04  // Changed query to use [Inspections]CreateApprovedPDF_d
	//Modified by: CJ (4/15/21 15:26:58)
	
End if 
//
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)

C_BOOLEAN:C305($Priority_B)
$Priority_B:=False:C215
SET PRINT OPTION:C733(Paper option:K47:1; "US Letter")
SET PRINT OPTION:C733(Orientation option:K47:2; 1)
//SET PRINT OPTION(_o_Hide printing progress option; 1)
SET PRINT OPTION:C733(Scale option:K47:3; 100)
InitProcessVar
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="LASTApprovedPDF")
C_TEXT:C284($MonthYear_txt)
C_DATE:C307($Query_D)
$Query_D:=Date:C102([Parameters:107]Description:2)
$MonthYear_txt:=String:C10(Year of:C25($Query_D); "0000")+"_"+String:C10(Month of:C24($Query_D); "00")+"_"+String:C10(Day of:C23($Query_D); "00")
SET QUERY DESTINATION:C396(Into set:K19:2; "QuerySet")
QUERY:C277([Inspections:27]; [Inspections:27]CreateApprovedPDF_d:218>=$Query_D; *)  // was [Inspections]InspAreaEngApprDate
QUERY:C277([Inspections:27];  & ; [Inspections:27]InspApproved:167=2; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"PON")
//SET QUERY DESTINATION(Into set;"FRZSet")// This quuery is no longer needed
//QUERY([Inspections];[Inspections]InspDBIEApprDate>=$Query_D;*)
//QUERY([Inspections]; & ;[Inspections]InspReviewed=2;*)
//QUERY([Inspections]; & ;[Inspections]Insp Type="FRZ")
//UNION("FRZSet";"QuerySet";"QuerySet")
USE SET:C118("QuerySet")
CLEAR SET:C117("QuerySet")
//CLEAR SET("FRZSet")

//QUERY([Inspections]; & ;[Bridge MHD NBIS]InspResp="DIST1")  //Only for testing using District 1 data
C_LONGINT:C283($ValidateLoop_L)
ARRAY LONGINT:C221($ValidRecords_aL; 0)
ARRAY LONGINT:C221($InvalidRecords_aL; 0)
C_TEXT:C284($FileName_txt)
C_LONGINT:C283($BridgeCount_L; $CombinedCount_L; $BMSinspCount_L)
For ($ValidateLoop_L; 1; Records in selection:C76([Inspections:27]))
	GOTO SELECTED RECORD:C245([Inspections:27]; $ValidateLoop_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BridgeCount_L)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
	
	If ([Combined Inspections:90]BMSInspID:3>0)
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
	Else 
		
	End if 
	
	Case of 
		: (Records in selection:C76([Combined Inspections:90])=0) | ($BridgeCount_L<1)
			APPEND TO ARRAY:C911($InvalidRecords_aL; Record number:C243([Inspections:27]))
		: (([Combined Inspections:90]BMSInspID:3>0) & (Records in selection:C76([BMS Inspections:44])<1))
			APPEND TO ARRAY:C911($InvalidRecords_aL; Record number:C243([Inspections:27]))
		Else 
			APPEND TO ARRAY:C911($ValidRecords_aL; Record number:C243([Inspections:27]))
			
	End case 
	
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_TEXT:C284($Report_txt; $Path_txt)
$Path_txt:=System folder:C487(Documents folder:K41:18)
$Path_txt:=$Path_txt+"Auto Insp PDFs"
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
End if 
$Path_txt:=$Path_txt+Folder separator:K24:12
If (Size of array:C274($InvalidRecords_aL)>0)
	CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $InvalidRecords_aL)
	ARRAY LONGINT:C221($inspIds_al; 0)
	ARRAY TEXT:C222($Bins_atxt; 0)
	ARRAY TEXT:C222($InspType_atxt; 0)
	ARRAY DATE:C224($insp_aD; 0)
	SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $insp_aD; \
		[Inspections:27]BIN:1; $Bins_atxt; \
		[Inspections:27]Insp Type:6; $InspType_atxt; \
		[Inspections:27]InspID:2; $inspIds_al)
	$Priority_B:=True:C214
	$Report_txt:="Inspection ID,Inspection Date,BIN,Inspection Type\n"+ut_ArrayToText_CSV(","; \
		->$inspIds_al; \
		->$insp_aD; \
		->$Bins_atxt; \
		->$InspType_atxt)
	$FileName_txt:="InvalidInsp_"+$MonthYear_txt+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 8)+".csv"
	TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Report_txt; UTF8 text without length:K22:17)
	APPEND TO ARRAY:C911(MAILAttachments_atxt; $Path_txt+$FileName_txt)
End if 
If (Size of array:C274($ValidRecords_aL)>0)
	INSP_PrintToPDF(True:C214; ->$Path_txt; ->$ValidRecords_aL; $MonthYear_txt; Current method name:C684)
Else 
	
End if 
C_TEXT:C284($From_txt; $To_txt; $EmailBody_txt; $EmailSubj_txt)
$From_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM"; "Costas.Manousakis@MHD.state.ma.us")
C_LONGINT:C283($Loop_l; $Start_L)

$To_txt:=ut_GetSysParameter("MAIL_TRANSFCHKLIST"; "costas.manousakis@MHD.state.ma.us,lori.peterson@dot.state.ma.us,cjmiller@informed-solutions.com")
$EmailSubj_txt:="Create Newly Appproved Inspection PDFs"
If ($Priority_B)
	$EmailBody_txt:="The file named "+MAILAttachments_atxt{1}+" is a CSV of inspection records that were missing combined inspection records or bms inspection records"+Char:C90(Carriage return:K15:38)
	$Start_L:=2
Else 
	$Start_L:=1
End if 

If (Size of array:C274(SQL_InternalDescriptions_atxt)>0)
	$Report_txt:="The following errors occurred during processing!"+Char:C90(Carriage return:K15:38)
	$Priority_B:=True:C214
	
	For ($Loop_l; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
		$Report_txt:=$Report_txt+SQL_InternalDescriptions_atxt{$loop_l}+Char:C90(Carriage return:K15:38)
	End for 
	$FileName_txt:="InspToPDFErrors_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
	$EmailBody_txt:="Please review attached error document named "+$FileName_txt+Char:C90(Carriage return:K15:38)+$EmailBody_txt
	TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Report_txt; UTF8 text without length:K22:17)
	APPEND TO ARRAY:C911(MAILAttachments_atxt; $Path_txt+$FileName_txt)
End if 
$EmailBody_txt:=$EmailBody_txt+"The following file is attached"+Char:C90(Carriage return:K15:38)
For ($Loop_l; $Start_L; Size of array:C274(MAILAttachments_atxt))
	$EmailBody_txt:=$EmailBody_txt+"File named "+MAILAttachments_atxt{$Loop_l}+Char:C90(Carriage return:K15:38)
End for 

If (ut_SendEmail($To_txt; $From_txt; ""; ""; $EmailBody_txt; $EmailSubj_txt; $Priority_B))
	
	
	
End if 

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="LASTApprovedPDF")
[Parameters:107]Description:2:=String:C10(Current date:C33)
SAVE RECORD:C53([Parameters:107])
UNLOAD RECORD:C212([Parameters:107])
//End INSP_CreatePDFS