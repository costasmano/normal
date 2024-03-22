//%attributes = {"invisible":true}
//Method: RatRep_LoadSU_EV_data
//Description
// get data from copy buffer to load into SU EV vehicle records
// will update the latest rating report record with that info and create act log entries.
// also update the notes in the rating report to indicate the update.
// example data (first set of values is inventory, second set is operating
//B_Dept | BIN | Date | SU4 | SU5 | SU6 | SU7 | EV2 | EV3 | SU4 | SU5 | SU6 | SU7 | EV2 | EV3
//A02001 | 28R | 3/13/20 | 11.3 | 11.7 | 11.8 | 12.1 | - | - | 32.4 | 33.5 | 33.7 | 34.7 | 32.3 | 32.6
//A13027 | 0FP | 3/16/20 | 16.1 | 17.7 | 19.8 | 22.1 | - | - | 27.2 | 29.9 | 33.5 | 37.4 | 26.9 | 27.7

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/25/20, 10:52:23
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03_bug
	// Modified by: Costas Manousakis-(Designer)-(4/1/20 11:54:32)
	Mods_2020_04
	//  `added confirm before processing the clipboard
End if 
//

C_TEXT:C284($Buffer_txt)
$Buffer_txt:=Get text from pasteboard:C524
C_BOOLEAN:C305($Abort_b)

G_MyConfirm("Before you run this method, please make sure you have copied the proper range from an Excel spreadsheet."+\
" This is the first 200 chars of what is currently in the clipboard:\n<<<Start>>>\n"+\
Substring:C12($Buffer_txt; 1; 200)+"\n"+\
"<<<End>>>\nDo you wish to continue?"; \
"Continue"; "Abort")
$Abort_b:=(OK#1)

C_TEXT:C284(vsForward)  // needed for interpreted execution

ARRAY TEXT:C222($Lines_atxt; 0)
C_TEXT:C284($delim_txt)
$delim_txt:=""
Case of 
	: ($Abort_b)
		
	: (Position:C15(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40); $Buffer_txt)>0)
		$delim_txt:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	: (Position:C15(Char:C90(Carriage return:K15:38); $Buffer_txt)>0)
		$delim_txt:=Char:C90(Carriage return:K15:38)
	: (Position:C15(Char:C90(Line feed:K15:40); $Buffer_txt)>0)
		$delim_txt:=Char:C90(Line feed:K15:40)
	Else 
		//error - has to be one of the above 
End case 


Case of 
	: ($Abort_b)
		
	: ($delim_txt="")
		ALERT:C41("Did not find a correct line delimiter in the copy buffer!")
	Else 
		ut_NewTextToArray($Buffer_txt; ->$Lines_atxt; $delim_txt)
		
		Case of 
			: (Size of array:C274($Lines_atxt)<2)
				ALERT:C41("Only one line found!! must be at least two lines - a header and one row of data!")
			: (Position:C15(Char:C90(Tab:K15:37); $Lines_atxt{1})<=0)
				ALERT:C41("Not tab delimited data in copy buffer! or only one column copied!")
				
			Else 
				C_BOOLEAN:C305($autoOne; $autoMany)
				GET AUTOMATIC RELATIONS:C899($autoOne; $autoMany)
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				
				//get data from [RatingVehicleTypes]
				ARRAY TEXT:C222($RtgVehType_atxt; 0)
				ARRAY LONGINT:C221($RtgVehId_aL; 0)
				ARRAY BOOLEAN:C223($RtgVehInvRtg_ab; 0)
				ARRAY BOOLEAN:C223($RtgVehOperRtg_ab; 0)
				Begin SQL
					select 
					[RatingVehicleTypes].[VehicleID],
					[RatingVehicleTypes].[VehicleName_s],
					[RatingVehicleTypes].[InvRating],
					[RatingVehicleTypes].[OperRating]
					from 
					[RatingVehicleTypes]
					where cast([RatingVehicleTypes].[Legacy] as INT) = 0
					order by [RatingVehicleTypes].[Sequence] ASC
					into
					:$RtgVehId_aL ,
					:$RtgVehType_atxt ,
					:$RtgVehInvRtg_ab ,
					:$RtgVehOperRtg_ab  ;
				End SQL
				
				ARRAY TEXT:C222($Headers_atxt; 0)
				//1st line must be headers 
				ut_NewTextToArray($Lines_atxt{1}; ->$Headers_atxt; Char:C90(Tab:K15:37))
				
				//run checks of data in clipboard
				Case of 
					: (Size of array:C274($Headers_atxt)<15)
						ALERT:C41("Expecting 15 columns! found only "+String:C10(Size of array:C274($Headers_atxt)))
					: ($Headers_atxt{2}#"BIN")
						ALERT:C41("Second column must be the BIN. Second column is labeled "+Char:C90(Double quote:K15:41)+$Headers_atxt{2}+Char:C90(Double quote:K15:41))
					: ($Headers_atxt{3}#"Date")
						ALERT:C41("Third column must be the Date. Second column is labeled "+Char:C90(Double quote:K15:41)+$Headers_atxt{3}+Char:C90(Double quote:K15:41))
						
					Else 
						//check if data columns are in order
						C_LONGINT:C283($hdr_L; $InvStart; $OperStart)
						C_TEXT:C284($Errors_txt)
						$Errors_txt:=""
						$InvStart:=3  //column before inv ratings
						$OperStart:=9  // column before opr ratings
						For ($hdr_L; 1; Size of array:C274($RtgVehType_atxt))
							If ($Headers_atxt{$InvStart+$hdr_L}#$RtgVehType_atxt{$hdr_L})
								$Errors_txt:=$Errors_txt+"For inventory ratings at column # "+String:C10($InvStart+$hdr_L)+\
									" expected header "+$RtgVehType_atxt{$hdr_L}+" , found header "+$Headers_atxt{$InvStart+$hdr_L}+Char:C90(Carriage return:K15:38)
							End if 
							If ($Headers_atxt{$OperStart+$hdr_L}#$RtgVehType_atxt{$hdr_L})
								$Errors_txt:=$Errors_txt+"For operating ratings at column # "+String:C10($OperStart+$hdr_L)+\
									" expected header "+$RtgVehType_atxt{$hdr_L}+" , found header "+$Headers_atxt{$OperStart+$hdr_L}+Char:C90(Carriage return:K15:38)
							End if 
							
						End for 
						
						//end of check of data in clipboard
						
						If ($Errors_txt#"")
							ALERT:C41("Errors found in the headers :"+Char:C90(Carriage return:K15:38)+$Errors_txt)
							
						Else 
							// now we process
							// need to keep a running log by line processed and show progress
							//choose/create log file
							ARRAY TEXT:C222($LogFiles_atxt; 0)
							C_TEXT:C284($LogFile_txt)
							C_TIME:C306($logfile_t)
							$LogFile_txt:=Select document:C905(""; ".txt"; "Select Log file"; File name entry:K24:17; $LogFiles_atxt)
							
							If (ok=1)
								$logfile_t:=Create document:C266($LogFiles_atxt{1})
								
								//save the current selection info of Bridges - record numbers and BINs
								
								ARRAY LONGINT:C221($RecNumbers_aL; 0)
								ARRAY TEXT:C222($StartBINS_atxt; 0)
								SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $RecNumbers_aL; [Bridge MHD NBIS:1]BIN:3; $StartBINS_atxt)
								
								READ ONLY:C145([Bridge MHD NBIS:1])  // make sure bridge table is RO
								
								//start the bar
								C_OBJECT:C1216($progress_o)
								$progress_o:=ProgressNew("Loading SU-EV data"; Size of array:C274($Lines_atxt); True:C214; " Data lines"; 3)
								
								ARRAY TEXT:C222($BINs_atxt; Size of array:C274($Lines_atxt))  // to keep track of BINs processed
								C_TEXT:C284($BDEPT; $BIN; $BdeptCheck)
								C_DATE:C307($dataDate_d)
								C_LONGINT:C283($loop_L; $ErrCount; $New_L; $Updated_L; $ReportUpd_L)
								$ErrCount:=0
								$New_L:=0
								$Updated_L:=0
								$ReportUpd_L:=0
								For ($loop_L; 2; Size of array:C274($Lines_atxt))
									ARRAY TEXT:C222($Data_atxt; 0)
									
									//update progress
									UpdateProgressNew($progress_o; $loop_L)
									
									//check if progress stopped
									If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
										//abort loop
										$loop_L:=Size of array:C274($Lines_atxt)+1
									Else 
										SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
											"Processing:"+Char:C90(Tab:K15:37)+$Lines_atxt{$loop_L}+Char:C90(Carriage return:K15:38))
										
										//parse line into data
										ut_NewTextToArray($Lines_atxt{$loop_L}; ->$Data_atxt; Char:C90(Tab:K15:37))
										$BDEPT:=$Data_atxt{1}
										$BIN:=$Data_atxt{2}
										$BINs_atxt{$loop_L}:=$BIN
										$dataDate_d:=Date:C102($Data_atxt{3})
										$BdeptCheck:=""
										
										Begin SQL
											select [Bridge MHD NBIS].[BDEPT]
											from [Bridge MHD NBIS]
											where [Bridge MHD NBIS].[BIN] = :$BIN
											into :$BdeptCheck ;
										End SQL
										ARRAY LONGINT:C221($ratinIDs_aL; 0)
										ARRAY DATE:C224($RatingDates_ad; 0)
										Begin SQL
											select [RatingReports].[RatingID],
											[RatingReports].[ReportDate]
											from [RatingReports]
											where 
											[RatingReports].[BIN] = :$BIN
											order by [RatingReports].[ReportDate] DESC,
											[RatingReports].[NBIS_Letter_d] desc
											into 
											:$ratinIDs_aL, 
											:$RatingDates_ad ;
											
										End SQL
										C_TEXT:C284($lineErrors_txt)
										$lineErrors_txt:=""
										
										Case of 
											: ($BIN="")
												$lineErrors_txt:=$lineErrors_txt+"Blank BIN"
											: ($BdeptCheck="")
												//bad  BIN - not found!
												$lineErrors_txt:=$lineErrors_txt+"Invalid BIN "+$BIN
											: ($BdeptCheck#$BDEPT)
												//bad bdept - BIN combination!
												$lineErrors_txt:=$lineErrors_txt+"BDEPT "+$BDEPT+" does not match the BIN "+$BIN
											: ($dataDate_d=!00-00-00!)
												//Bad data date
												$lineErrors_txt:=$lineErrors_txt+"Invalid date :"+$Data_atxt{3}
												
											: ($dataDate_d>Current date:C33(*))
												//date in future
												$lineErrors_txt:=$lineErrors_txt+"Date is in the future:"+$Data_atxt{3}
											: (Size of array:C274($ratinIDs_aL)=0)
												//no rating reports found
												$lineErrors_txt:=$lineErrors_txt+"No existing rating reports found for BIN "+$BIN
											: ($RatingDates_ad{1}>$dataDate_d)
												//data date is before the rating report!
												$lineErrors_txt:=$lineErrors_txt+"Date in data "+String:C10($dataDate_d)+\
													" is before the date of the latest rating report "+String:C10($RatingDates_ad{1})
												
										End case 
										
										If ($lineErrors_txt#"")
											SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
												"Error :"+Char:C90(Tab:K15:37)+$lineErrors_txt+Char:C90(Carriage return:K15:38))
											$ErrCount:=$ErrCount+1
										Else 
											ARRAY REAL:C219($InvRatings_ar; 0)
											ARRAY REAL:C219($OperRatings_ar; 0)
											
											ARRAY REAL:C219($InvRatings_ar; Size of array:C274($RtgVehType_atxt))
											ARRAY REAL:C219($OperRatings_ar; Size of array:C274($RtgVehType_atxt))
											
											//check rating values - 
											C_TEXT:C284($valueError_txt)
											$valueError_txt:=""
											$InvRatings_ar{1}:=Num:C11($Data_atxt{4})
											If ($InvRatings_ar{1}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory SU4 value "+Char:C90(Double quote:K15:41)+$Data_atxt{4}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$InvRatings_ar{2}:=Num:C11($Data_atxt{5})
											If ($InvRatings_ar{2}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory SU5 value "+Char:C90(Double quote:K15:41)+$Data_atxt{5}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$InvRatings_ar{3}:=Num:C11($Data_atxt{6})
											If ($InvRatings_ar{3}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory SU6 value "+Char:C90(Double quote:K15:41)+$Data_atxt{6}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$InvRatings_ar{4}:=Num:C11($Data_atxt{7})
											If ($InvRatings_ar{4}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory SU7 value "+Char:C90(Double quote:K15:41)+$Data_atxt{7}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											
											If ($Data_atxt{8}#"-")
												//error
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory EV2 value "+Char:C90(Double quote:K15:41)+$Data_atxt{8}+Char:C90(Double quote:K15:41)+\
													" not equal to "+Char:C90(Double quote:K15:41)+"-"+Char:C90(Double quote:K15:41)
											Else 
												$InvRatings_ar{5}:=-1
											End if 
											If ($Data_atxt{9}#"-")
												//error
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Inventory EV3 value "+Char:C90(Double quote:K15:41)+$Data_atxt{8}+Char:C90(Double quote:K15:41)+\
													" not equal to "+Char:C90(Double quote:K15:41)+"-"+Char:C90(Double quote:K15:41)
												
											Else 
												$InvRatings_ar{6}:=-1
											End if 
											
											$OperRatings_ar{1}:=Num:C11($Data_atxt{10})
											If ($OperRatings_ar{1}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating SU4 value "+Char:C90(Double quote:K15:41)+$Data_atxt{10}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$OperRatings_ar{2}:=Num:C11($Data_atxt{11})
											If ($OperRatings_ar{2}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating SU5 value "+Char:C90(Double quote:K15:41)+$Data_atxt{11}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$OperRatings_ar{3}:=Num:C11($Data_atxt{12})
											If ($OperRatings_ar{3}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating SU6 value "+Char:C90(Double quote:K15:41)+$Data_atxt{12}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$OperRatings_ar{4}:=Num:C11($Data_atxt{13})
											If ($OperRatings_ar{4}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating SU7 value "+Char:C90(Double quote:K15:41)+$Data_atxt{13}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$OperRatings_ar{5}:=Num:C11($Data_atxt{14})
											If ($OperRatings_ar{5}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating EV2 value "+Char:C90(Double quote:K15:41)+$Data_atxt{14}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											$OperRatings_ar{6}:=Num:C11($Data_atxt{15})
											If ($OperRatings_ar{6}<0)
												$valueError_txt:=$valueError_txt+Choose:C955(($valueError_txt#""); Char:C90(Tab:K15:37); "")+\
													"Input Operating EV3 value "+Char:C90(Double quote:K15:41)+$Data_atxt{15}+Char:C90(Double quote:K15:41)+\
													" is negative"
											End if 
											
											If ($valueError_txt#"")
												SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
													"Ratings Error :"+Char:C90(Tab:K15:37)+$valueError_txt+Char:C90(Carriage return:K15:38))
												$ErrCount:=$ErrCount+1
											Else 
												
												//now load the rating report record
												QUERY:C277([RatingReports:65]; [RatingReports:65]RatingID:21=$ratinIDs_aL{1})
												
												If (ut_LoadRecordInteractive(->[RatingReports:65]))
													SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
														"LoadReport :"+Char:C90(Tab:K15:37)+"Loaded Rating report dated "+String:C10([RatingReports:65]ReportDate:4)+\
														" NBIS letter date "+String:C10([RatingReports:65]NBIS_Letter_d:36; Blank if null date:K1:9)+Char:C90(Carriage return:K15:38))
													
													QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[RatingReports:65]BIN:1)
													
													C_BOOLEAN:C305($DataUpdate_b)
													$DataUpdate_b:=False:C215  //assume there are no changes
													
													//loop thru the types
													C_LONGINT:C283($vehType_L)
													For ($vehType_L; 1; Size of array:C274($RtgVehType_atxt))
														//check if the rating report already has the vehicle 
														QUERY:C277([RatingReportVehicles:191]; [RatingReportVehicles:191]RatingID:2=$ratinIDs_aL{1}; *)
														QUERY:C277([RatingReportVehicles:191];  & ; [RatingReportVehicles:191]VehicleID:7=$RtgVehId_aL{$vehType_L})
														C_BOOLEAN:C305($loadData_b; $newrec_b)
														$loadData_b:=True:C214
														$newrec_b:=False:C215
														Case of 
															: (Records in selection:C76([RatingReportVehicles:191])=0)
																//need to create one
																CREATE RECORD:C68([RatingReportVehicles:191])
																[RatingReportVehicles:191]RatingID:2:=$ratinIDs_aL{1}
																Inc_Sequence(Table name:C256(->[RatingReportVehicles:191]); ->[RatingReportVehicles:191]RatingVehicleID:1)
																SAVE RECORD:C53([RatingReportVehicles:191])
																LogNewRecord(->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2; Table name:C256(->[RatingReportVehicles:191]))
																SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
																	"Created record :"+Char:C90(Tab:K15:37)+"Created record for Vehicle "+$RtgVehType_atxt{$vehType_L}\
																	+Char:C90(Carriage return:K15:38))
																$newrec_b:=True:C214
																
															: (Records in selection:C76([RatingReportVehicles:191])=1)
																//load it
																If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
																Else 
																	SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
																		"Load Error :"+Char:C90(Tab:K15:37)+"Could not load existing record for Vehicle "+$RtgVehType_atxt{$vehType_L}\
																		+Char:C90(Carriage return:K15:38))
																	$loadData_b:=False:C215
																	$ErrCount:=$ErrCount+1
																	
																End if 
															Else 
																//more than one record exists
																SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
																	"Reference Error :"+Char:C90(Tab:K15:37)+"Found "+String:C10(Records in selection:C76([RatingReportVehicles:191]))+" records for Vehicle "+$RtgVehType_atxt{$vehType_L}\
																	+Char:C90(Carriage return:K15:38))
																$loadData_b:=False:C215
																$ErrCount:=$ErrCount+1
																
														End case 
														
														If ($loadData_b)
															InitChangeStack(1)
															[RatingReportVehicles:191]VehicleID:7:=$RtgVehId_aL{$vehType_L}
															[RatingReportVehicles:191]InvRating:3:=$InvRatings_ar{$vehType_L}
															[RatingReportVehicles:191]OperRating:4:=$OperRatings_ar{$vehType_L}
															PushAllChanges(1; ->[RatingReportVehicles:191]; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1)
															If (Size of array:C274(PTR_CHANGES{1})>0)
																FlushGrpChgs(1; ->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
																SAVE RECORD:C53([RatingReportVehicles:191])
																SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
																	"Saved Data :"+Char:C90(Tab:K15:37)+"Saved / updated data for Vehicle "+$RtgVehType_atxt{$vehType_L}\
																	+Char:C90(Carriage return:K15:38))
																$DataUpdate_b:=True:C214  // vehicle data has been updated
																If ($newrec_b)
																	$New_L:=$New_L+1
																Else 
																	$Updated_L:=$Updated_L+1
																End if 
															Else 
																SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
																	"NoChanges :"+Char:C90(Tab:K15:37)+"No changes needed for Vehicle "+$RtgVehType_atxt{$vehType_L}\
																	+Char:C90(Carriage return:K15:38))
																
															End if 
															
														End if 
														
													End for   //loop over vehicle types
													
													If ($DataUpdate_b)
														//add to the notes in the rating report
														[RatingReports:65]RatingInfo:20:="SU/EV rating loads dated "+String:C10($dataDate_d)+" uploaded/updated on "+String:C10(Current date:C33(*))+\
															Char:C90(Carriage return:K15:38)+[RatingReports:65]RatingInfo:20
														LogChanges(->[RatingReports:65]RatingInfo:20; ->[Bridge MHD NBIS:1]BIN:3; ->[RatingReports:65]BIN:1; ->[RatingReports:65]RatingID:21; 1)
														SAVE RECORD:C53([RatingReports:65])
														SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
															"ReportUpdate :"+Char:C90(Tab:K15:37)+"Updated notes in rating report"\
															+Char:C90(Carriage return:K15:38))
														$ReportUpd_L:=$ReportUpd_L+1
														
													End if 
												Else 
													SEND PACKET:C103($logfile_t; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Tab:K15:37)+String:C10($loop_L)+Char:C90(Tab:K15:37)+\
														"Load Rating :"+Char:C90(Tab:K15:37)+"Could not load for editing Rating report dated "+String:C10($RatingDates_ad{1})\
														+Char:C90(Carriage return:K15:38))
													$ErrCount:=$ErrCount+1
													
												End if   //if rating report record loaded
												
												
											End if   //if no value errors
											
										End if   //if no line error
										
									End if   //end of if progress stopped
									
								End for   // line loop
								
								//quit progress
								Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
								
								CLOSE DOCUMENT:C267($logfile_t)
								
								
								ALERT:C41("Processed "+String:C10(Size of array:C274($Lines_atxt))+" total lines."+\
									" Updated "+String:C10($ReportUpd_L)+" rating reports. Added "+\
									String:C10($New_L)+" vehicles. Updated "+String:C10($Updated_L)+" Vehicles."+\
									" There were "+String:C10($ErrCount)+" errors encountered. See the log created for more details."+\
									" The Bridge list will be updated with the BINs found in data")
								C_LONGINT:C283($bridgeRec_L; $origCount_L)
								$origCount_L:=Size of array:C274($StartBINS_atxt)
								For ($bridgeRec_L; $origCount_L; 1; -1)
									If (Find in array:C230($BINs_atxt; $StartBINS_atxt{$bridgeRec_L})>0)
									Else 
										DELETE FROM ARRAY:C228($StartBINS_atxt; $bridgeRec_L; 1)
										DELETE FROM ARRAY:C228($RecNumbers_aL; $bridgeRec_L; 1)
									End if 
									
								End for 
								CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $RecNumbers_aL)
								
								SHOW ON DISK:C922($LogFiles_atxt{1})
								
							End if   //ok on creation of log file
							
							
						End if   // end of if header errors
						
				End case   //end of 1st round of header error checks 
				
				SET AUTOMATIC RELATIONS:C310($autoOne; $autoMany)
				
		End case   //end of check of line count and tab delim
		
End case 

//End RatRep_LoadSU_EV_data