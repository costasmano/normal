//%attributes = {"invisible":true}
//Method: INSPCreatePDFForTypes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/21/21, 13:46:05
	// ----------------------------------------------------
	//Created : 
	Mods_2021_01
End if 

INSP_SetPrintOptionsForPDF

InitProcessVar
C_TEXT:C284($message_txt; $Path_txt; $FileName_txt)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_BOOLEAN:C305($Complete_B; $Proceed_B; $ProcessAnotherMonth_B)
C_TEXT:C284($MonthYear_txt)
C_DATE:C307($start_d; $end_d)


Repeat 
	ARRAY TEXT:C222($Processed_atxt; 0)
	ut_NewTextToArray([Parameters:107]Description:2; ->$Processed_atxt; ",")
	SORT ARRAY:C229($Processed_atxt; <)
	
	
	$Complete_B:=False:C215
	
	Repeat 
		
		
		$Proceed_B:=True:C214
		
		
		ALL RECORDS:C47([Inspection Type:31])
		ARRAY TEXT:C222($inspTypes_atxt; 0)
		SELECTION TO ARRAY:C260([Inspection Type:31]Code:1; $inspTypes_atxt)
		ARRAY LONGINT:C221($inspIDs_aL; 0)
		C_TEXT:C284($inspType_txt; $District_txt; $Message_txt)
		$District_txt:="DIST1"
		CREATE EMPTY SET:C140([Inspections:27]; "FinalSet")
		
		C_LONGINT:C283($Loop_l)
		For ($Loop_l; 1; Size of array:C274($inspTypes_atxt))
			If ($inspTypes_atxt{$Loop_l}#"PON")
				
				QUERY:C277([Inspections:27];  & ; [Inspections:27]InspApproved:167=2; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6=$inspTypes_atxt{$Loop_l}; *)
				QUERY:C277([Inspections:27];  & ; [Bridge MHD NBIS:1]InspResp:173="DIST1")
				
				ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
				REDUCE SELECTION:C351([Inspections:27]; 5)
				
				CREATE SET:C116([Inspections:27]; "QuerySet")
				If (Records in set:C195("QuerySet")=0)
					$Message_txt:=$Message_txt+$inspTypes_atxt{$Loop_l}+","
				Else 
					$inspType_txt:=$inspType_txt+$inspTypes_atxt{$Loop_l}+","
					UNION:C120("QuerySet"; "FinalSet"; "FinalSet")
					
					
				End if 
			End if 
			
			
			
		End for 
		If ($Message_txt#"")
			$Path_txt:=System folder:C487(Documents folder:K41:18)
			$Path_txt:=$Path_txt+"Missing Inspections"
			If (Test path name:C476($Path_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($Path_txt)
				
			End if 
			$Path_txt:=$Path_txt+Folder separator:K24:12+"MissInspTypes"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
			TEXT TO DOCUMENT:C1237($Path_txt; $Message_txt; UTF8 text without length:K22:17)
			
		End if 
		USE SET:C118("FinalSet")
		CLEAR SET:C117("FinalSet")
		CLEAR SET:C117("QuerySet")
		
		
		If (Records in selection:C76([Inspections:27])>0)
			$message_txt:="Do you want to create PDFs for inspections types "+$inspType_txt+\
				" for "+String:C10(Records in selection:C76([Inspections:27]))+" inspection records"
			
			
			CONFIRM:C162($message_txt; "YES"; "NO")
			$Proceed_B:=OK=1
			$Complete_B:=$Proceed_B
			
		Else 
			$Complete_B:=True:C214
		End if 
		
	Until ($Complete_B)
	
	If ($Proceed_B)
		//Validate that all inspections have all records
		C_LONGINT:C283($ValidateLoop_L)
		ARRAY LONGINT:C221($ValidRecords_aL; 0)
		ARRAY LONGINT:C221($InvalidRecords_aL; 0)
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
			
			$Report_txt:="Inspection ID,Inspection Date,BIN,Inspection Type\n"+ut_ArrayToText_CSV(","; \
				->$inspIds_al; \
				->$insp_aD; \
				->$Bins_atxt; \
				->$InspType_atxt)
			$FileName_txt:="InvalidInsp_"+$MonthYear_txt+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 8)+".csv"
			TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Report_txt; UTF8 text without length:K22:17)
			
		End if 
		If (Size of array:C274($ValidRecords_aL)>0)
			
		Else 
			REDUCE SELECTION:C351([Inspections:27]; 0)
		End if 
		If (Records in selection:C76([Inspections:27])=0)
			
			
		Else 
			If ($Proceed_B)
				INSP_PrintToPDF(True:C214; ->$Path_txt; ->$ValidRecords_aL; $MonthYear_txt; Current method name:C684)
				
			End if 
		End if 
		
		$ProcessAnotherMonth_B:=False:C215
	End if   //
	
Until (Not:C34($ProcessAnotherMonth_B))


//
//End INSP_CreatePDFByMonth
//End INSPCreatePDFForTypes