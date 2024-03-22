//%attributes = {"invisible":true}
//Method: INSP_CreatePDFByMonth
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/07/21, 17:01:25
	// ----------------------------------------------------
	//Created : 
	MODS_2021_01
End if 
INSP_SetPrintOptionsForPDF
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)

InitProcessVar
C_TEXT:C284($message_txt; $Path_txt; $FileName_txt; $NumberOfMonths_txt)
C_LONGINT:C283($NumberOfMonths_L; $Pos_L)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_BOOLEAN:C305($Complete_B; $Proceed_B; $ProcessAnotherMonth_B; $Priority_B)
C_TEXT:C284($MonthYear_txt)
C_DATE:C307($start_d; $end_d)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INITPDFINSP")
SET TEXT TO PASTEBOARD:C523("INITPDFINSP")
vsForward:=<>Forward
$ProcessAnotherMonth_B:=True:C214
If (Records in selection:C76([Parameters:107])=0)
	FORM SET INPUT:C55([Parameters:107]; "Input")
	ADD RECORD:C56([Parameters:107])
	
End if 
C_BOOLEAN:C305($ProcessAnotherMonth_B)
$ProcessAnotherMonth_B:=True:C214
Repeat 
	$Priority_B:=False:C215
	ARRAY TEXT:C222($Processed_atxt; 0)
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INITPDFINSP")
	
	ut_NewTextToArray([Parameters:107]Description:2; ->$Processed_atxt; ",")
	SORT ARRAY:C229($Processed_atxt; <)
	
	Case of 
		: (Size of array:C274($Processed_atxt)=0)
			$MonthYear_txt:="2000-01"
		: (Size of array:C274($Processed_atxt)=1) & ($Processed_atxt{1}="")
			$MonthYear_txt:="2000-01"
		Else 
			ARRAY TEXT:C222($YM_atxt; 0)
			ut_NewTextToArray($Processed_atxt{1}; ->$YM_atxt; "-")
			If ($YM_atxt{2}="12")
				$YM_atxt{2}:="01"
				$YM_atxt{1}:=String:C10(Num:C11($YM_atxt{1})+1; "0000")
				
			Else 
				$YM_atxt{2}:=String:C10(Num:C11($YM_atxt{2})+1; "00")
			End if 
			$MonthYear_txt:=$YM_atxt{2}+"-"+$YM_atxt{1}
			
	End case 
	$Complete_B:=False:C215
	
	Repeat 
		$NumberOfMonths_txt:="6"
		$MonthYear_txt:=Request:C163("Please enter next Year-Month to query with"; $MonthYear_txt)
		$NumberOfMonths_txt:=Request:C163("Please enter Number of Months to run"; $NumberOfMonths_txt)
		$NumberOfMonths_L:=Num:C11($NumberOfMonths_txt)
		C_TEXT:C284($nextMonth_txt; $Nextyear_txt)
		C_LONGINT:C283($nextMonth_L; $Nextyear_L)
		
		ARRAY TEXT:C222($MonthYear_atxt; 0)
		ARRAY TEXT:C222($MonthYear_atxt; 0)
		ARRAY DATE:C224($start_ad; 0)
		ARRAY DATE:C224($End_ad; 0)
		
		ARRAY TEXT:C222($MonthYear_atxt; $NumberOfMonths_L)
		ARRAY DATE:C224($start_ad; $NumberOfMonths_L)
		ARRAY DATE:C224($End_ad; $NumberOfMonths_L)
		
		If (OK=1)
			
			$Proceed_B:=True:C214
			ARRAY TEXT:C222($MY_atxt; 0)
			ut_NewTextToArray($MonthYear_txt; ->$MY_atxt; "-")
			ARRAY TEXT:C222(MAILAttachments_atxt; 0)
			
			For ($Pos_L; 1; Size of array:C274($MonthYear_atxt))
				$start_d:=Date:C102($MY_atxt{1}+"/01/"+$MY_atxt{2})
				$nextMonth_L:=Num:C11($MY_atxt{1})
				$Nextyear_L:=Num:C11($MY_atxt{2})
				$end_d:=Add to date:C393($start_d; 0; 1; -1)
				
				$MonthYear_atxt{$Pos_L}:=$MonthYear_txt
				$start_ad{$Pos_L}:=$start_d
				$End_ad{$Pos_L}:=$end_d
				$nextMonth_L:=$nextMonth_L+1
				If ($nextMonth_L>12)
					$nextMonth_L:=1
					$Nextyear_L:=$Nextyear_L+1
				End if 
				$MonthYear_txt:=String:C10($nextMonth_L; "00")+"-"+String:C10($Nextyear_L; "0000")
				ARRAY TEXT:C222($MY_atxt; 0)
				ut_NewTextToArray($MonthYear_txt; ->$MY_atxt; "-")
			End for 
			For ($Pos_L; 1; Size of array:C274($start_ad))
				SET QUERY DESTINATION:C396(Into set:K19:2; "QuerySet_"+String:C10($Pos_L; "000"))
				QUERY:C277([Inspections:27]; [Inspections:27]Insp Date:78>=$start_ad{$pos_l}; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Date:78<=$end_ad{$pos_l}; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]InspApproved:167=2; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"PON")
				SET QUERY DESTINATION:C396(Into set:K19:2; "FRZSet")
				QUERY:C277([Inspections:27]; [Inspections:27]Insp Date:78>=$start_ad{$pos_l}; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Date:78<=$end_ad{$pos_l}; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]InspReviewed:12=2; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6="FRZ")
				UNION:C120("FRZSet"; "QuerySet_"+String:C10($Pos_L; "000"); "QuerySet_"+String:C10($Pos_L; "000"))
				CLEAR SET:C117("FRZSet")
				//QUERY([Inspections]; & ;[Bridge MHD NBIS]bin="ATU")
				//QUERY([Inspections]; & ;[Bridge MHD NBIS]InspResp="DIST1")  //Only for testing using District 1 data
			End for 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			
			$Complete_B:=True:C214
			If (False:C215)
				If (Records in selection:C76([Inspections:27])>0)
					$message_txt:="Do you want to create PDFs for inspections between "+String:C10($start_d)+" and "+String:C10($end_d)+\
						" for "+String:C10(Records in selection:C76([Inspections:27]))+" inspection records"
					
					If ($Pos_L>0)
						$message_txt:=$message_txt+", which may have already been processed"
					End if 
					
					CONFIRM:C162($message_txt; "YES"; "NO")
					$Proceed_B:=OK=1
					$Complete_B:=$Proceed_B
					If (Not:C34($Proceed_B))
						
						CONFIRM:C162("Try again"; "Yes"; "No")
						$Complete_B:=OK=0
					End if 
				Else 
					$Complete_B:=True:C214
				End if 
			End if 
		Else 
			$Complete_B:=True:C214
			$ProcessAnotherMonth_B:=False:C215
		End if 
	Until ($Complete_B)
	If ($ProcessAnotherMonth_B)
		//Validate that all inspections have all records
		C_LONGINT:C283($ValidateLoop_L)
		ARRAY LONGINT:C221($ValidRecords_aL; 0)
		ARRAY LONGINT:C221($InvalidRecords_aL; 0)
		C_LONGINT:C283($BridgeCount_L; $CombinedCount_L; $BMSinspCount_L)
		C_OBJECT:C1216($Progress_obj)
		$Progress_obj:=ProgressNew("Processing "+String:C10(Size of array:C274($start_ad))+" Months"; Size of array:C274($start_ad); True:C214; ""; 3)
		
		For ($pos_l; 1; Size of array:C274($start_ad))
			UpdateProgressNew($Progress_obj; $pos_l)
			$MonthYear_txt:=$MonthYear_atxt{$Pos_L}
			USE SET:C118("QuerySet_"+String:C10($Pos_L; "000"))
			CLEAR SET:C117("QuerySet_"+String:C10($Pos_L; "000"))
			ARRAY LONGINT:C221($InvalidRecords_aL; 0)
			ARRAY LONGINT:C221($ValidRecords_aL; 0)
			
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
						$Priority_B:=True:C214
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
				
			Else 
				REDUCE SELECTION:C351([Inspections:27]; 0)
			End if 
			If (Records in selection:C76([Inspections:27])=0)
				
				ARRAY TEXT:C222($YM_atxt; 0)
				ut_NewTextToArray($MonthYear_txt; ->$YM_atxt; "-")
				If ([Parameters:107]Description:2="")
					[Parameters:107]Description:2:=$YM_atxt{2}+"-"+$YM_atxt{1}
				Else 
					[Parameters:107]Description:2:=[Parameters:107]Description:2+","+$YM_atxt{2}+"-"+$YM_atxt{1}
				End if 
				SAVE RECORD:C53([Parameters:107])
				
			Else 
				If ($Proceed_B)
					INSP_PrintToPDF(True:C214; ->$Path_txt; ->$ValidRecords_aL; $MonthYear_txt; Current method name:C684)
					If (Size of array:C274(SQL_InternalDescriptions_atxt)>0)
						APPEND TO ARRAY:C911(SQL_InternalDescriptions_atxt; "End processing for "+$MonthYear_txt)
					End if 
					ARRAY TEXT:C222($YM_atxt; 0)
					ut_NewTextToArray($MonthYear_txt; ->$YM_atxt; "-")
					QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INITPDFINSP")
					ut_LoadRecord(->[Parameters:107])
					[Parameters:107]Description:2:=[Parameters:107]Description:2+","+$YM_atxt{2}+"-"+$YM_atxt{1}
					SAVE RECORD:C53([Parameters:107])
				End if 
			End if 
		End for 
		Progress QUIT(OB Get:C1224($Progress_obj; "progress"; Is longint:K8:6))
		
		C_TEXT:C284($From_txt; $To_txt; $EmailBody_txt; $EmailSubj_txt)
		$EmailBody_txt:=""
		$From_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM"; "Costas.Manousakis@MHD.state.ma.us")
		C_LONGINT:C283($Loop_l; $Start_L)
		
		$To_txt:=ut_GetSysParameter("MAIL_TRANSFCHKLIST"; "costas.manousakis@MHD.state.ma.us,lori.peterson@dot.state.ma.us,cjmiller@informed-solutions.com")
		If ($Priority_B)
			$EmailSubj_txt:="Create Appproved Inspection by Month"
			$EmailBody_txt:="The file named "+MAILAttachments_atxt{1}+" is a CSV of inspection records that were missing combined inspection records or bms inspection records"+Char:C90(Carriage return:K15:38)
			$Start_L:=2
		Else 
			$Start_L:=1
			$EmailSubj_txt:="Create Appproved Inspection by Month:"+Char:C90(Carriage return:K15:38)
		End if 
		$EmailBody_txt:=$EmailBody_txt+"The following files for month - year are attached"+Char:C90(Carriage return:K15:38)
		For ($Loop_l; $Start_L; Size of array:C274(MAILAttachments_atxt))
			$EmailBody_txt:=$EmailBody_txt+"File named "+MAILAttachments_atxt{$Loop_l}+Char:C90(Carriage return:K15:38)
		End for 
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
		If (ut_SendEmail($To_txt; $From_txt; ""; ""; $EmailBody_txt; $EmailSubj_txt; $Priority_B))
			DELAY PROCESS:C323(Current process:C322; 10)
		End if 
		
		//ut_SendEmail
		CONFIRM:C162("Process another month"; "Yes"; "No")
		$ProcessAnotherMonth_B:=OK=1
	End if   //
	
Until (Not:C34($ProcessAnotherMonth_B))
UNLOAD RECORD:C212([Parameters:107])

//
//End INSP_CreatePDFByMonth