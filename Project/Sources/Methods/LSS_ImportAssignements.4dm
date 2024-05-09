//%attributes = {}
//Method: LSS_ImportAssignements
//Description
// Import LSS Inspection assignments from a text file
// should report back what type inspection was created initial or routine
// input is :
//   col1 : structure number
//   col2 : contract number
//   col3 : assignment number
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 29, 2024, 11:53:21
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
End if 
//

C_COLLECTION:C1488($Required_c; $ImportColumns_c)
$Required_c:=New collection:C1472
$Required_c.push(New object:C1471("name"; "StructNum"; "indx"; 1))
$Required_c.push(New object:C1471("name"; "ContractNum"; "indx"; 2))
$Required_c.push(New object:C1471("name"; "AssignNum"; "indx"; 3))

C_TEXT:C284($importFile_txt)
$importFile_txt:=Select document:C905(""; ".txt"; "Select import file"; 0)
If (Ok=1)
	C_OBJECT:C1216($importFile_o)
	$importFile_o:=File:C1566(Document; fk platform path:K87:2)
	//load all data as text
	C_TEXT:C284($importdata_txt; $inspectiontype_txt)
	$importdata_txt:=$importFile_o.getText()
	C_COLLECTION:C1488($lines_c)
	$lines_c:=Split string:C1554($importdata_txt; Char:C90(Carriage return:K15:38))
	
	Case of 
		: ($lines_c.length<2)
			ALERT:C41("Empty file or only one line in file!")
		Else 
			//get first two lines and parse into header and data
			C_COLLECTION:C1488($headers_c; $data_c; $Datadescr_c)
			$headers_c:=Split string:C1554($lines_c[0]; Char:C90(Tab:K15:37); sk trim spaces:K86:2)
			//need to clear \n when in windows for lines after the first one  [0]
			$data_c:=Split string:C1554(Replace string:C233($lines_c[1]; "\n"; ""); Char:C90(Tab:K15:37); sk trim spaces:K86:2)
			
			Case of 
				: ($headers_c.length#$data_c.length)
					ALERT:C41("Number of header columns and data columns do not match!")
				: ($headers_c.length#$Required_c.length)
					ALERT:C41("Number of header columns is not the same as the needed columns")
					
				Else 
					C_TEXT:C284($verify_txt)
					$verify_txt:=""
					C_LONGINT:C283($hdr_i)
					For ($hdr_i; 0; ($Required_c.length-1))
						$verify_txt:=$verify_txt+$Required_c[$hdr_i].name+" -> "+$headers_c[$hdr_i]+" : "+$data_c[$hdr_i]+"\n"
					End for 
					CONFIRM:C162("Verify conversion :\n"+\
						"RequiredCol -> HeaderFromFile : DataFromFile\n"+\
						$verify_txt; "Proceed"; "Cancel")
					
					If (OK=1)
						C_COLLECTION:C1488($contracts_c; $contractmodc_c)
						$contracts_c:=JSON Parse:C1218(ut_GetSysParameter("LSS_Contracts"); Is collection:K8:32)
						$contractmodc_c:=New collection:C1472  //possible updates to contracts
						
						C_LONGINT:C283($lineNum_L; $numlines_L; $ID_L)
						
						$numlines_L:=$lines_c.length
						ARRAY TEXT:C222($strNumProcessed_atxt; $numlines_L)
						
						C_COLLECTION:C1488($log_c; $error_c)
						$log_c:=New collection:C1472
						$error_c:=New collection:C1472
						C_BOOLEAN:C305($processline_b)
						//start the bar
						C_OBJECT:C1216($lineProgress_o; $log_o; $lastinsp_o; $inv_o)
						
						$lineProgress_o:=ProgressNew("Processing assignments"; $numlines_L; True:C214; " assignments"; 3)
						//start from second line 
						For ($lineNum_L; 1; $numlines_L-1)
							//update progress
							UpdateProgressNew($lineProgress_o; $lineNum_L)
							$processline_b:=True:C214
							
							$data_c:=Split string:C1554(Replace string:C233($lines_c[$lineNum_L]; "\n"; ""); Char:C90(Tab:K15:37); sk trim spaces:K86:2)
							
							Case of 
								: ($data_c.length=0)
									//blank line
									$processline_b:=False:C215
								: ($data_c.length<$Required_c.length)
									//not enough columns - error
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Missing data!"))
								Else 
									$strNumProcessed_atxt{$lineNum_L}:=$data_c[0]
									$log_o:=(New object:C1471("line"; $lineNum_L; "starttime"; String:C10(Current date:C33; ISO date:K1:8; Current time:C178); \
										"strnum"; $data_c[0]))
									$inv_o:=ds:C1482.LSS_Inventory.query("LSS_StructureNumber_s = :1"; $data_c[0])
									
							End case 
							
							// checks
							Case of 
								: (Not:C34($processline_b))
									//blank or incomplete line
									
								: ($lineNum_L>1) & (Find in array:C230($strNumProcessed_atxt; $data_c[0])<$lineNum_L)
									//duplicated structure number
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Duplicated Structure number same as in line# "+String:C10(Find in array:C230($strNumProcessed_atxt; $data_c[0]))))
									
								: ($inv_o.length=0)
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Structure number not found in database!"))
									
								: ($inv_o[0].LSS_Status_s="Removed")
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Structure number has Status=Removed!"))
									
								: (Num:C11($data_c[1])=0)
									//zero contract num
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Zero contract number "+$data_c[1]))
									
								: ($contracts_c.query("ContractNo = :1"; Num:C11($data_c[1])).length=0)
									//contract not found in anc inspection contract list
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Contract number "+$data_c[1]+" not found in list of Anc. Insp. contracts in system parameter LSS_Contracts"))
									
								: (Num:C11($data_c[2])=0)
									//zero assignment num
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "Zero assignment number "+$data_c[2]))
									
								: (ds:C1482.LSS_Inspection.query("Link_92.LSS_StructureNumber_s = :1 and LSS_ContractNo_L > :2 and LSS_InspectionDate_d = :3"; \
									$data_c[0]; 0; !00-00-00!).length>0)
									//there is an inspection assignement for this structure already
									$processline_b:=False:C215
									$error_c.push(New object:C1471("line"; $lineNum_L; "strnum"; $data_c[0]; \
										"error"; "There is already an inspection assignment for this structure!"))
							End case 
							
							If ($processline_b)
								//look for previous initial or routine report
								$lastinsp_o:=ds:C1482.LSS_Inspection.query("Link_92.LSS_StructureNumber_s = :1 and "+\
									"(LSS_InspectionTypeId_s = :2 | LSS_InspectionTypeId_s = :3) and "+\
									"LSS_InspectionDate_d > :4"; $data_c[0]; "@01"; "@02"; !00-00-00!).orderBy("LSS_InspectionDate_d Desc")
								If ($lastinsp_o.length>0)
									//found one - copy it and create a routine!
									$inspectiontype_txt:=ds:C1482.LSS_refInspectionType.query("LSS_InspectionTypeId_s = :1 & LSS_Description_txt =:2"; $inv_o[0].LSS_InventoryType_s+"@"; "routine").first().LSS_InspectionTypeId_s
									
									//have to use classic commands to duplicate
									QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=$lastinsp_o.first().LSS_InspectionId_s)
									
									C_OBJECT:C1216($param_o)
									$param_o:=New object:C1471("contractno"; Num:C11($data_c[1]); "assignno"; Num:C11($data_c[2]); "insptype"; $inspectiontype_txt; "showmessage"; True:C214; \
										"strnum"; $inv_o[0].LSS_StructureNumber_s)
									
									LSS_DuplicateInspection($param_o)
									OB SET:C1220($log_o; "action"; "routine"; "inspid"; $param_o.newinspid; "insptype"; $param_o.newinsptype; \
										"contract"; Num:C11($data_c[1]); "assignment"; Num:C11($data_c[2]); \
										"oldinspid"; $param_o.oldinspid; "oldinsptype"; $param_o.oldinsptype; "oldinspdate"; $param_o.oldinspdate; "items"; $param_o.items)
									
								Else 
									//no recent initial or routine
									//create an initial
									$inspectiontype_txt:=ds:C1482.LSS_refInspectionType.query("LSS_InspectionTypeId_s = :1 & LSS_Description_txt =:2"; $inv_o[0].LSS_InventoryType_s+"@"; "initial").first().LSS_InspectionTypeId_s
									CREATE RECORD:C68([LSS_Inspection:164])
									Inc_Sequence("LSS_InspectionId_s"; ->$ID_L)
									[LSS_Inspection:164]LSS_InspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
									[LSS_Inspection:164]LSS_InventoryId_s:2:=$inv_o[0].LSS_InventoryId_s
									[LSS_Inspection:164]LSS_InspectionTypeId_s:3:=$inspectiontype_txt
									[LSS_Inspection:164]LSS_InspectionDate_d:4:=!00-00-00!
									[LSS_Inspection:164]LSS_CreatedBy_s:45:="AssignmentImport"  // show source is an import of assignments
									[LSS_Inspection:164]LSS_CreatedISODate_s:46:=ISODateTime(Current date:C33; Current time:C178)
									[LSS_Inspection:164]LSS_ContractNo_L:60:=Num:C11($data_c[1])
									[LSS_Inspection:164]LSS_AssignmentNo_L:61:=Num:C11($data_c[2])
									SAVE RECORD:C53([LSS_Inspection:164])
									OB SET:C1220($log_o; "action"; "Initial"; "inspid"; [LSS_Inspection:164]LSS_InspectionId_s:1; \
										"insptype"; $inspectiontype_txt; "contract"; Num:C11($data_c[1]); "assignment"; Num:C11($data_c[2]))
									UNLOAD RECORD:C212([LSS_Inspection:164])
									
								End if 
								
								//check to see if the assignment # exists - if not add it - and indicate that the contracts obj was changed
								C_OBJECT:C1216($contr_o)
								$contr_o:=$contracts_c.query("ContractNo = :1"; Num:C11($data_c[1]))[0]
								
								Case of 
									: ($contr_o.Assignments=Null:C1517)
										//no assignments yet - add this one
										$contractmodc_c.push(New object:C1471("contract"; Num:C11($data_c[1]); "assignnum"; Num:C11($data_c[2])))
										$contr_o.Assignments:=New collection:C1472(New object:C1471("assignnum"; Num:C11($data_c[2])))
										
									: ($contr_o.Assignments.query("assignnum = :1"; Num:C11($data_c[2])).length=0)
										$contractmodc_c.push(New object:C1471("contract"; Num:C11($data_c[1]); "assignnum"; Num:C11($data_c[2])))
										// assignment number not found - add and sort
										$contr_o.Assignments.push(New object:C1471("assignnum"; Num:C11($data_c[2])))
										$contr_o.Assignments:=$contr_o.Assignments.orderBy("assignnum asc")
										
								End case 
								
							End if 
							
							$log_c.push($log_o)
							
							//check if progress stopped
							If (Progress Stopped(OB Get:C1224($lineProgress_o; "progress"; Is longint:K8:6)))
								//abort loop
								$lineNum_L:=$lines_c.length+1
							End if 
							
						End for   //line loop
						
						//quit progress
						Progress QUIT(OB Get:C1224($lineProgress_o; "progress"; Is longint:K8:6))
						
						If ($contractmodc_c.length>0)
							C_OBJECT:C1216($chg_o)
							C_TEXT:C284($msg_txt)
							For each ($chg_o; $contractmodc_c)
								$msg_txt:=$msg_txt+"\n"+String:C10($chg_o.contract)+" - "+String:C10($chg_o.assignnum)
							End for each 
							//contracts has been modified - try to update it
							// use classic 4D because changes in parameters table should be in activity log 
							QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="LSS_Contracts")
							
							If (ut_LoadRecordInteractive(->[Parameters:107]))
								[Parameters:107]Description:2:=JSON Stringify:C1217($contracts_c; *)
								LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
								SAVE RECORD:C53([Parameters:107])
								UNLOAD RECORD:C212([Parameters:107])
								ALERT:C41("Ancillary Contracts record has been update to include new assignements found in the import data.\n"+\
									"The following new Contract-Assignments were added:"+$msg_txt)
								//update storage too
								LSS_ContractsToStorage
							Else 
								
								ALERT:C41("Could not load Ancillary Contracts record to update assignement list! This can be done manually later!"+\
									"\nThe following new Contract-Assignment pairs were found in the import data:"+$msg_txt)
							End if 
							
						End if 
						
						C_TEXT:C284($filecontent_txt; $logfile_txt; $timestamp_txt)
						$timestamp_txt:=Replace string:C233(ISODateTime(Current date:C33; Current time:C178); ":"; "-")
						C_LONGINT:C283($col_)
						ARRAY TEXT:C222($attributes_atxt; 0)
						ARRAY LONGINT:C221($attrTypes_aL; 0)
						C_LONGINT:C283($progress_L)
						$progress_L:=Progress New
						Progress SET TITLE($progress_L; "Processing log")
						Progress SET PROGRESS($progress_L; -1)
						
						If (True:C214)
							//loop through log collection and 
							$filecontent_txt:=""
							ARRAY TEXT:C222($columnnames_atxt; 0)
							
							For each ($log_o; $log_c)
								OB GET PROPERTY NAMES:C1232($log_o; $attributes_atxt; $attrTypes_aL)
								
								For ($col_; 1; Size of array:C274($attributes_atxt))
									If (Find in array:C230($columnnames_atxt; $attributes_atxt{$col_})<0)
										APPEND TO ARRAY:C911($columnnames_atxt; $attributes_atxt{$col_})
									End if 
									
									Case of 
										: ($attrTypes_aL{$col_}=Is null:K8:31) | ($attrTypes_aL{$col_}=Is boolean:K8:9) | ($attrTypes_aL{$col_}=Is real:K8:4) | ($attrTypes_aL{$col_}=Is text:K8:3)
											$filecontent_txt:=$filecontent_txt+OB Get:C1224($log_o; $attributes_atxt{$col_}; Is text:K8:3)+","
										: ($attrTypes_aL{$col_}=Is collection:K8:32)
											$filecontent_txt:=$filecontent_txt+JSON Stringify:C1217(OB Get:C1224($log_o; $attributes_atxt{$col_}; Is collection:K8:32))+","
										: ($attrTypes_aL{$col_}=Is object:K8:27)
											$filecontent_txt:=$filecontent_txt+JSON Stringify:C1217(OB Get:C1224($log_o; $attributes_atxt{$col_}; Is object:K8:27))+","
										: ($attrTypes_aL{$col_}=Object array:K8:28)
											//don't know if this works
											$filecontent_txt:=$filecontent_txt+JSON Stringify:C1217(OB Get:C1224($log_o; $attributes_atxt{$col_}; Object array:K8:28))+","
										Else 
											
									End case 
									
								End for 
								$filecontent_txt:=$filecontent_txt+Char:C90(Carriage return:K15:38)
								
							End for each 
							
							C_TEXT:C284($header_txt)
							$header_txt:=ut_ArrayToText(->$columnnames_atxt; ",")
							$filecontent_txt:=$header_txt+Char:C90(Carriage return:K15:38)+$filecontent_txt
							
						Else 
							$filecontent_txt:=JSON Stringify:C1217($log_c; *)
							
						End if 
						
						$logfile_txt:=$importFile_o.parent.platformPath+$importFile_o.name+"_log_"+$timestamp_txt+".csv"
						C_OBJECT:C1216($logfile_o)
						$logfile_o:=File:C1566($logfile_txt; fk platform path:K87:2)
						$logfile_o.setText($filecontent_txt)
						
						Progress QUIT($progress_L)
						
						If ($error_c.length>0)
							
							If (True:C214)
								$filecontent_txt:=""
								OB GET PROPERTY NAMES:C1232($error_c[0]; $attributes_atxt)
								//header
								$filecontent_txt:=$attributes_atxt{1}
								For ($col_; 2; Size of array:C274($attributes_atxt))
									$filecontent_txt:=$filecontent_txt+","+$attributes_atxt{$col_}
								End for 
								$filecontent_txt:=$filecontent_txt+Char:C90(Carriage return:K15:38)
								C_OBJECT:C1216($err_)
								For each ($err_; $error_c)
									
									$filecontent_txt:=$filecontent_txt+OB Get:C1224($err_; $attributes_atxt{1}; Is text:K8:3)
									For ($col_; 2; Size of array:C274($attributes_atxt))
										$filecontent_txt:=$filecontent_txt+","+OB Get:C1224($err_; $attributes_atxt{$col_}; Is text:K8:3)
									End for 
									$filecontent_txt:=$filecontent_txt+Char:C90(Carriage return:K15:38)
								End for each 
								
							Else 
								$filecontent_txt:=JSON Stringify:C1217($error_c; *)
								
							End if 
							
							$logfile_txt:=$importFile_o.parent.platformPath+$importFile_o.name+"_err_"+$timestamp_txt+".csv"
							$logfile_o:=File:C1566($logfile_txt; fk platform path:K87:2)
							$logfile_o.setText($filecontent_txt)
							
							ALERT:C41("Errors were found! See error file")
							
						End if 
						
						SHOW ON DISK:C922($logfile_txt)
						
					End if   // conversion columns to data verified 
					
			End case   //if header and data column count checks
			
	End case   //case of line count
	
End if   //if file selected
//End LSS_ImportAssignements   