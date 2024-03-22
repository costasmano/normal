//%attributes = {"invisible":true}
// PM_ControlMetricRetrieve
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// User name (OS): charlesmiller
	// Date and time: 05/22/09, 14:21:43
	// ----------------------------------------------------
	Mods_2009_05  //r002  `05/22/09, 14:21:45 `Add code and tables to retrieve pontis simulation data
	Mods_2009_06  //r003 `06/02/09, 14:06:08   `Modify Pontis retrieve
	//Add code to allow for deletion of a run
	//Add code to log what occurred during run
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: manousakisc (12/24/2013)
	Mods_2013_12
	//  `added a SAVE RECORD after each CREATE RECORD([Pontis_Metric_Data]) - without it, it kept using the same record.
	
	// Modified by: manousakisc (1/2/2015)
	Mods_2014_12
	//change of [Pontis_Metrics]PM_Tev_l to a real
	// Modified by: manousakisc (12/26/2017)
	Mods_2017_12
	//  //Use the Desktop folder to create the Pontis_Simulation folder- Open the folder at the end of run
	// Modified by: Costas Manousakis-(Designer)-(2022-11-08 10:43:21)
	Mods_2022_11_bug
	//  `recovered from backup - method was deleted
End if 
READ ONLY:C145(*)
C_LONGINT:C283($Width_l; $Height_l; $Win_l)

FORM GET PROPERTIES:C674([Pontis_Metrics:41]; "PontisImport.dlg"; $Width_l; $Height_l)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 5; "Pontis Metric Import"; "ut_CloseCancel")
DIALOG:C40([Pontis_Metrics:41]; "PontisImport.dlg")

CLOSE WINDOW:C154
If (OK=1)  //we are going to proceed
	READ WRITE:C146([Pontis_Metrics:41])
	READ WRITE:C146([Pontis_Metric_Data:40])
	
	C_LONGINT:C283($TotalDataCount_l; $Loop_l; $InnerLoop_l; $PMRunKey_l; $SizeOfArray_l; $MetricUpdate_l; $MetricAdd_l; $MetricDataUpdate_l; $MetricDataAdd_l)
	C_BOOLEAN:C305($UpdateMetrtics_b; $OkToProceed_b)
	C_DATE:C307($Current_d)
	C_TEXT:C284($FileName_txt; $Path_txt; $DocumentData_txt)
	$Path_txt:=System folder:C487(Desktop:K41:16)
	$Path_txt:=Replace string:C233($Path_txt; "Desktop"; "Pontis_Simulation")
	//$Path_txt:="F:\\Pontis_Simulation\\"
	If (Test path name:C476($Path_txt)=0)
	Else 
		CREATE FOLDER:C475($Path_txt)
	End if 
	$FileName_txt:=$Path_txt+"Pontis-"+Substring:C12(ut_CreateTimeStamp; 1; 12)+".txt"
	PM_ControlLogDocument("C"; ->$FileName_txt)
	
	If (PM_DeleteRun_l=1)
		$OkToProceed_b:=True:C214
		$DocumentData_txt:="Delete Run start "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
		
		QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_ImportDate_d:4=PM_ImportDate_ad{PM_ImportDate_ad})
		If (Records in selection:C76([Pontis_Metrics:41])>0)
			FIRST RECORD:C50([Pontis_Metrics:41])
			$PMRunKey_l:=[Pontis_Metrics:41]PM_RunKey_l:1
		Else 
			$OkToProceed_b:=False:C215
		End if 
		If ($OkToProceed_b)
			
			ARRAY TEXT:C222($UniqueKeys_as; 0)  //Command Replaced was o_ARRAY string length was 15
			QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_RunKey_l:1=$PMRunKey_l)
			
			SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([Pontis_Metrics:41]); [Pontis_Metrics:41]PM_UniqueKey_s:2; $UniqueKeys_as)
			QUERY WITH ARRAY:C644([Pontis_Metric_Data:40]PM_UNiqueKey_s:1; $UniqueKeys_as)
			$DocumentData_txt:="Deleting "+String:C10(Records in selection:C76([Pontis_Metrics:41]))+" Pontis Metric and "+String:C10(Records in selection:C76([Pontis_Metric_Data:40]))+" associated metric data records"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
			Repeat 
				DELETE SELECTION:C66([Pontis_Metrics:41])
				If (Records in set:C195("LockedSet")>0)
					uT_DelayUserProcess
					USE SET:C118("LockedSet")
				End if 
			Until (Records in set:C195("LockedSet")=0)
			Repeat 
				DELETE SELECTION:C66([Pontis_Metric_Data:40])
				If (Records in set:C195("LockedSet")>0)
					uT_DelayUserProcess
					USE SET:C118("LockedSet")
				End if 
			Until (Records in set:C195("LockedSet")=0)
			ALERT:C41("Deleted Run imported on date "+String:C10(PM_ImportDate_ad{PM_ImportDate_ad}))
		Else 
			ALERT:C41("No Records found for selected date")
			$DocumentData_txt:="No records found for date "+String:C10(PM_ImportDate_ad{PM_ImportDate_ad})+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
			
		End if 
		
	Else 
		
		$Current_d:=Current date:C33(*)
		$UpdateMetrtics_b:=False:C215
		$OkToProceed_b:=False:C215
		$MetricUpdate_l:=0
		$MetricAdd_l:=0
		$MetricDataUpdate_l:=0
		$MetricDataAdd_l:=0
		$TotalDataCount_l:=0
		Repeat 
			$OkToProceed_b:=ut_LoadSQLConnectionInfo("Pontis")
			
			If (Not:C34($OkToProceed_b))
				ut_CreateOrUpdateSQLConnectionD("Pontis")
			End if 
			
		Until ($OkToProceed_b)
		If (PM_ReRun_l=1)
			$DocumentData_txt:="Update Run start "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
			
			$UpdateMetrtics_b:=True:C214
			QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_ImportDate_d:4=PM_ImportDate_ad{PM_ImportDate_ad})
			If (Records in selection:C76([Pontis_Metrics:41])>0)
				FIRST RECORD:C50([Pontis_Metrics:41])
				$PMRunKey_l:=[Pontis_Metrics:41]PM_RunKey_l:1
			Else 
				$DocumentData_txt:="Update Run failed - no records found "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				$OkToProceed_b:=False:C215
			End if 
			$Current_d:=PM_ImportDate_ad{PM_ImportDate_ad}
		Else 
			$DocumentData_txt:="Import Run start "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
			Inc_Sequence("PM_RunKey_l"; ->$PMRunKey_l)
			$OkToProceed_b:=True:C214
		End if 
		C_TEXT:C284(PM_Bin_s)  // Command Replaced was o_C_STRING length was 3
		C_TIME:C306($StartTime_tm; $RemainingTime_tm)
		REDUCE SELECTION:C351([Pontis_Metrics:41]; 0)
		ARRAY DATE:C224(PM_ImportDate_ad; 0)
		If ($OkToProceed_b)
			READ WRITE:C146([Pontis_Metrics:41])
			READ WRITE:C146([Pontis_Metric_Data:40])
			If (SQL_Connect_New)
				C_LONGINT:C283($win)
				$win:=ut_OpenNewWindow(500; 200; 5; 4; "Updating Pontis Metrics")
				$StartTime_tm:=Current time:C178(*)
				
				If (SQL_Direct("sp_RTRV_PontisMetric"))
					//If (SQL_Do ("sp_RTRV_PontisMetric";"Built"))
					
					$SizeOfArray_l:=Size of array:C274(PM_BRKey_atxt)
					$DocumentData_txt:="Retrieved "+String:C10($SizeOfArray_l)+"[Pontis_Metrics] records"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
					
					For ($Loop_l; 1; $SizeOfArray_l)
						GOTO XY:C161(5; 2)
						MESSAGE:C88("Updating "+String:C10($Loop_l)+" out of "+String:C10($SizeOfArray_l))
						GOTO XY:C161(5; 5)
						$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time:C178(*)-$StartTime_tm)
						MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
						GOTO XY:C161(5; 7)
						MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178(*)-$StartTime_tm))
						
						PM_Bin_s:=Substring:C12(PM_BRKey_atxt{$Loop_l}; 7; 3)
						
						If ($UpdateMetrtics_b)
							QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_ImportDate_d:4=$Current_d; *)
							QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_Bin_s:3=PM_Bin_s)
							If (Records in selection:C76([Pontis_Metrics:41])=0)
								PM_CreateMetricRecord(->$PMRunKey_l; ->$Current_d; ->PM_SCKey_as{$Loop_l}; ->PM_TEV_ar{$Loop_l})
								$MetricAdd_l:=$MetricAdd_l+1
							End if 
						Else 
							$MetricAdd_l:=$MetricAdd_l+1
							PM_CreateMetricRecord(->$PMRunKey_l; ->$Current_d; ->PM_SCKey_as{$Loop_l}; ->PM_TEV_ar{$Loop_l})
						End if 
						If (ut_LoadRecord(->[Pontis_Metrics:41]))
						End if 
						C_BOOLEAN:C305($UpdateRecord_b)
						$UpdateRecord_b:=True:C214
						Case of 
							: (Not:C34([Pontis_Metrics:41]PM_SCKey_s:5=PM_SCKey_as{$Loop_l}))
							: (Not:C34([Pontis_Metrics:41]PM_Tev_r:6=PM_TEV_ar{$Loop_l}))
								
							Else 
								$UpdateRecord_b:=False:C215
						End case 
						If ($UpdateRecord_b)
							If (Record number:C243([Pontis_Metrics:41])#New record:K29:1)
								$MetricUpdate_l:=$MetricUpdate_l+1
							End if 
							[Pontis_Metrics:41]PM_SCKey_s:5:=PM_SCKey_as{$Loop_l}
							[Pontis_Metrics:41]PM_Tev_r:6:=PM_TEV_ar{$Loop_l}
							SAVE RECORD:C53([Pontis_Metrics:41])
						End if 
						PM_BRKey_txt:=PM_BRKey_atxt{$Loop_l}
						C_LONGINT:C283(PM_NumberofRows_l)
						PM_NumberofRows_l:=15
						If (SQL_Direct("sp_RTRV_Metricdata"))
							//If (SQL_Do ("sp_RTRV_Metricdata";"Built"))
							If (Size of array:C274(PM_ADT_al)>0)
								PM_NumberofRows_l:=Size of array:C274(PM_ADT_al)
								$TotalDataCount_l:=$TotalDataCount_l+PM_NumberofRows_l
								If ($UpdateMetrtics_b)
									SET QUERY DESTINATION:C396(Into set:K19:2; "Metric_Data_Set")
									QUERY:C277([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PM_UNiqueKey_s:1=[Pontis_Metrics:41]PM_UniqueKey_s:2)
								End if 
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								For ($InnerLoop_l; 1; PM_NumberofRows_l)
									If ($UpdateMetrtics_b)
										USE SET:C118("Metric_Data_Set")
										QUERY SELECTION:C341([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PMD_YKey_l:2=PM_YKey_al{$InnerLoop_l})
										
										If (Records in selection:C76([Pontis_Metric_Data:40])=0)
											CREATE RECORD:C68([Pontis_Metric_Data:40])
											[Pontis_Metric_Data:40]PM_UNiqueKey_s:1:=[Pontis_Metrics:41]PM_UniqueKey_s:2
											$MetricDataAdd_l:=$MetricDataAdd_l+1
											SAVE RECORD:C53([Pontis_Metric_Data:40])
										End if 
									Else 
										$MetricDataAdd_l:=$MetricDataAdd_l+1
										CREATE RECORD:C68([Pontis_Metric_Data:40])
										[Pontis_Metric_Data:40]PM_UNiqueKey_s:1:=[Pontis_Metrics:41]PM_UniqueKey_s:2
										SAVE RECORD:C53([Pontis_Metric_Data:40])
									End if 
									If (ut_LoadRecord(->[Pontis_Metric_Data:40]))
									End if 
									
									$UpdateRecord_b:=True:C214
									Case of 
										: (Not:C34([Pontis_Metric_Data:40]PMD_ADT_l:4=PM_ADT_al{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_ADT_l:4=PM_ADT_al{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_ADT_l:4=PM_ADT_al{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_CIX_Bear_r:9=PM_CIX_Bear_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_CIX_Deck_r:10=PM_CIX_Deck_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_CIX_Joint_r:8=PM_CIX_Joint_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_CIX_Sub_r:7=PM_CIX_Sub_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_CIX_Supr_r:6=PM_CIX_Supr_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_Hindex_r:3=PM_Hindex_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_PTIndex_r:5=PM_PTIndex_ar{$InnerLoop_l}))
										: (Not:C34([Pontis_Metric_Data:40]PMD_YKey_l:2=PM_YKey_al{$InnerLoop_l}))
										Else 
											$UpdateRecord_b:=False:C215
									End case 
									If ($UpdateRecord_b)
										If (Record number:C243([Pontis_Metric_Data:40])#New record:K29:1)
											$MetricDataUpdate_l:=$MetricDataUpdate_l+1
										End if 
										[Pontis_Metric_Data:40]PMD_ADT_l:4:=PM_ADT_al{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_CIX_Bear_r:9:=PM_CIX_Bear_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_CIX_Deck_r:10:=PM_CIX_Deck_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_CIX_Joint_r:8:=PM_CIX_Joint_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_CIX_Sub_r:7:=PM_CIX_Sub_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_CIX_Supr_r:6:=PM_CIX_Supr_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_Hindex_r:3:=PM_Hindex_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_PTIndex_r:5:=PM_PTIndex_ar{$InnerLoop_l}
										[Pontis_Metric_Data:40]PMD_YKey_l:2:=PM_YKey_al{$InnerLoop_l}
										SAVE RECORD:C53([Pontis_Metric_Data:40])
									End if 
									UNLOAD RECORD:C212([Pontis_Metric_Data:40])
								End for 
							End if 
						End if 
						
						SAVE RECORD:C53([Pontis_Metrics:41])
						UNLOAD RECORD:C212([Pontis_Metrics:41])
					End for 
				End if 
				SQL_ClearArrays("sp_RTRV_PontisMetric")
				SQL_ClearArrays("sp_RTRV_Metricdata")
				
				SQL LOGOUT:C872
				//SQL_Disconnect 
				
				$DocumentData_txt:="There were "+String:C10($MetricUpdate_l)+"[Pontis_Metrics] records updated"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				$DocumentData_txt:="There were "+String:C10($MetricAdd_l)+"[Pontis_Metrics] records added"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				
				$DocumentData_txt:="There were "+String:C10($MetricDataUpdate_l)+"[Pontis_Metric_Data] records updated"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				$DocumentData_txt:="There were "+String:C10($MetricDataAdd_l)+"[Pontis_Metric_Data] records added"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				
				
				$DocumentData_txt:="There were "+String:C10($SizeOfArray_l)+" records retrieved from sp_RTRV_PontisMetric"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				$DocumentData_txt:="There were "+String:C10($TotalDataCount_l)+" records retrieved from sp_RTRV_Metricdata"+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
				
			End if 
			
		End if 
	End if 
	$DocumentData_txt:="Run end "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	PM_ControlLogDocument("A"; ->$FileName_txt; ->$DocumentData_txt)
	
	SHOW ON DISK:C922($FileName_txt)
	
End if 
//End PM_ControlMetricRetrieve