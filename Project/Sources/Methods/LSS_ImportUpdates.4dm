//%attributes = {"invisible":true}
//Method: LSS_ImportUpdates
//Description
// Import data to update Ancillary inventory 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 05/01/23, 13:27:12
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
	// Modified by: Costas Manousakis-(Designer)-(2023-10-25 18:32:29)
	Mods_2023_10
	//  `changed to use G_PickFromList ;added options to update Lat Lon , import active structures
	//  `when adding structures - consider the Description import column for [LSS_Inventory]LSS_StructureTypeId_s
	//  `when adding structures - consider the year built for active structures - ignore for proposed
	
End if 
//
C_LONGINT:C283($Option_L)

ARRAY TEXT:C222($Options_atxt; 0)
APPEND TO ARRAY:C911($Options_atxt; "Update Status Projno Yr blt")
APPEND TO ARRAY:C911($Options_atxt; "Mark Removed")
APPEND TO ARRAY:C911($Options_atxt; "Import Proposed")
APPEND TO ARRAY:C911($Options_atxt; "Update LatLon")
APPEND TO ARRAY:C911($Options_atxt; "Import Active")
$Option_L:=G_PickFromList(->$Options_atxt; "Select import/update option")

If ($Option_L>0)
	C_TEXT:C284($importFile_txt; $logfile_txt; $errorfile_txt)
	C_OBJECT:C1216($importFile_o; $logfile_o; $errorfile_o)
	$importFile_txt:=Select document:C905(""; ".txt;.csv"; "Select import text file"; 0)
	If (OK=1)
	Else 
		$Option_L:=0
	End if 
End if 

If ($Option_L>0)
	C_BOOLEAN:C305($savechanges_b)
	CONFIRM:C162("Save changes?"; "Don't Save"; "Save")
	$savechanges_b:=(ok=0)
	$importFile_o:=File:C1566(Document; fk platform path:K87:2)
	$logfile_o:=File:C1566($importFile_o.parent.platformPath+$importFile_o.name+"_"+\
		ut_CreateTimeStamp+".csv"; fk platform path:K87:2)
	$errorfile_o:=File:C1566($importFile_o.parent.platformPath+$importFile_o.name+"_"+\
		ut_CreateTimeStamp+"_err.csv"; fk platform path:K87:2)
	
	C_TEXT:C284($column_sep)
	If ($importFile_o.extension=".csv")
		$column_sep:=","
	Else 
		$column_sep:=Char:C90(Tab:K15:37)  // for text files assume tab
	End if 
	
	C_TEXT:C284($filedata_txt)
	$filedata_txt:=$importFile_o.getText("UTF-8"; Document with CR:K24:21)
	
	C_COLLECTION:C1488($lines_c; $errors_c; $messages_c)
	$errors_c:=New collection:C1472
	$messages_c:=New collection:C1472
	
	//add header for messages
	Case of 
		: ($Option_L=1)
			$messages_c.push("Line"+","+"Obj ID"+","+"Struct Num"+","+"Status"+","+"Pinfo"+","+"Yr Built")
			$errors_c.push("Line"+","+"Struct Num"+","+"Error")
			
		: ($Option_L=2)
			$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Pinfo"+","+"Yr Built")
			$errors_c.push("Line"+","+"Struct Num"+","+"Error")
		: ($Option_L=3) | ($Option_L=5)
			$messages_c.push("Line"+","+"Obj ID"+","+"Struct Num"+","+"Type"+","+"Lat"+","+"Lon")
			$errors_c.push("Line"+","+"Obj ID"+","+"Error")
		: ($Option_L=4)
			$messages_c.push("Line"+","+"Struct Num"+","+"Lat"+","+"Lon")
			$errors_c.push("Line"+","+"Error")
			
	End case 
	
	C_OBJECT:C1216($progress_o)
	Progress QUIT(0)
	$progress_o:=ProgressNew("Ancillary "+\
		Choose:C955($Option_L; ""; "Update status-pinfo"; "Mark Removed"; "Import Proposed"; "update LatLon"; "Import Active")+\
		" from file"; $lines_c.length; True:C214; " lines"; 3)
	Progress SET MESSAGE($progress_o.progress; "Lines..."; False:C215)
	$lines_c:=Split string:C1554($filedata_txt; Char:C90(Carriage return:K15:38); sk trim spaces:K86:2)
	//Assume header row. 
	C_TEXT:C284($row_txt)
	C_COLLECTION:C1488($rowdata_c)
	C_LONGINT:C283($row)
	Progress SET MESSAGE($progress_o.progress; "Setup..."; False:C215)
	LSS_SetUp
	SORT ARRAY:C229(LSS_STID_atxt; LSS_STDescription_atxt; >)  //sort the structure type arrays
	//start the bar
	
	C_LONGINT:C283($indx_L; $start_L)
	
	//get all pinfo numbers to check
	ALL RECORDS:C47([PRJ_ProjectFile:117])
	ARRAY LONGINT:C221($pfileNos_aL; 0)
	SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileNumber_l:3; $pfileNos_aL)
	
	//Assume header row : start from element [1]. 
	
	For ($row; 1; ($lines_c.length-1))
		//update progress
		UpdateProgressNew($progress_o; $row)
		$rowdata_c:=Split string:C1554($lines_c[$row]; $column_sep; sk trim spaces:K86:2)
		If ($rowdata_c.length>0)
			Case of 
					
				: ($Option_L=1)  //Update of records with pinfo/year built and make active
					
					If ($rowdata_c.length>=4)  // need at least 4 columns
						
						C_TEXT:C284($strno_txt; $cat_txt; $Descr_txt; $Lat_txt; $lon_txt; $prjno_txt; $yearblt_txt; $obj_txt)
						$obj_txt:=$rowdata_c[0]
						$strno_txt:=$rowdata_c[1]
						//$cat_txt:=$rowdata_c[2]
						//$Descr_txt:=$rowdata_c[3]
						//$Lat_txt:=$rowdata_c[4]
						//$lon_txt:=$rowdata_c[5]
						$prjno_txt:=$rowdata_c[2]
						$yearblt_txt:=$rowdata_c[3]
						QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
						
						If (Records in selection:C76([LSS_Inventory:165])=1)
							
							If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
								
								If (False:C215)
									//check if $descr is a valid structure type
									$indx_L:=Find in array:C230(LSS_STID_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25)
									
									If (LSS_STDescription_atxt{$indx_L}#$Descr_txt)
										// description does not match
										//try to find correct ID for the structure type descr
										$start_L:=Find in array:C230(LSS_STID_atxt; $cat_txt+"-@")  // find index where this category starts
										$indx_L:=Find in array:C230(LSS_STDescription_atxt; $Descr_txt; $start_L)
										
										Case of 
											: ($indx_L<0)
												//description not found!
												$errors_c.push(String:C10($row)+","+$strno_txt+","+\
													"Structure description "+$Descr_txt+" not found")
											: (LSS_STID_atxt{$indx_L}#($cat_txt+"-@"))
												$errors_c.push(String:C10($row)+","+$strno_txt+","+\
													"Structure description "+$Descr_txt+" not found for category "+$cat_txt)
											Else 
												C_LONGINT:C283($currID_L)
												$currID_L:=Find in array:C230(LSS_STID_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25)
												If ($currID_L<0)
													$currID_L:=0
												End if 
												$messages_c.push(String:C10($row)+","+$obj_txt+","+$strno_txt+","+\
													"Updating Structure type to "+LSS_STID_atxt{$indx_L}+"="+LSS_STDescription_atxt{$indx_L}+\
													" from "+[LSS_Inventory:165]LSS_StructureTypeId_s:25+"="+LSS_STDescription_atxt{$currID_L})
												[LSS_Inventory:165]LSS_StructureTypeId_s:25:=LSS_STID_atxt{$indx_L}
										End case 
										
									End if 
									
								End if 
								
								//check proj file num
								
								If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
									$errors_c.push(String:C10($row)+","+$strno_txt+","+"PINFO number"+","+$prjno_txt+","+"not found!")
								End if 
								
								[LSS_Inventory:165]LSS_Status_s:35:="Active"
								//[LSS_Inventory]LSS_Latitude_r:=Num($Lat_txt)
								//[LSS_Inventory]LSS_Longitude_r:=Num($lon_txt)
								[LSS_Inventory:165]LSS_ProjNoBuilt_L:37:=Num:C11($prjno_txt)
								[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
								[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
								[LSS_Inventory:165]LSS_YearBuilt_s:11:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
								$messages_c.push(String:C10($row)+","+$obj_txt+","+$strno_txt+","+\
									[LSS_Inventory:165]LSS_Status_s:35+","+\
									String:C10([LSS_Inventory:165]LSS_ProjNoBuilt_L:37)+","+\
									[LSS_Inventory:165]LSS_YearBuilt_s:11)
								
								If ($savechanges_b)
									SAVE RECORD:C53([LSS_Inventory:165])
								End if 
								
							Else 
								$errors_c.push(String:C10($row)+","+$strno_txt+","+"Record locked!")
							End if 
							
						Else 
							$errors_c.push(String:C10($row)+","+$strno_txt+","+"Not found!")
						End if 
						
					Else 
						$errors_c.push(String:C10($row)+", ,Not enough columns for update - need 4 , found :"+String:C10($rowdata_c.length)+" !")
					End if 
				: ($Option_L=4)  //Update of Lat Lon
					
					If ($rowdata_c.length>=3)  // need at least 3 columns
						C_TEXT:C284($strno_txt; $cat_txt; $Descr_txt; $Lat_txt; $lon_txt; $prjno_txt; $yearblt_txt; $obj_txt)
						$strno_txt:=$rowdata_c[0]
						//$cat_txt:=$rowdata_c[2]
						//$Descr_txt:=$rowdata_c[3]
						$lon_txt:=$rowdata_c[1]
						$Lat_txt:=$rowdata_c[2]
						//$prjno_txt:=$rowdata_c[2]
						//$yearblt_txt:=$rowdata_c[3]
						QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
						
						If (Records in selection:C76([LSS_Inventory:165])=1)
							
							If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
								
								
								//[LSS_Inventory]LSS_Status_s:="Active"
								[LSS_Inventory:165]LSS_Latitude_r:19:=Num:C11($Lat_txt)
								[LSS_Inventory:165]LSS_Longitude_r:18:=Num:C11($lon_txt)
								//[LSS_Inventory]LSS_ProjNoBuilt_L:=Num($prjno_txt)
								[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
								[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
								//[LSS_Inventory]LSS_YearBuilt_s:=String(Year of(Date($yearblt_txt)))
								$messages_c.push(String:C10($row)+","+$strno_txt+","+\
									String:C10([LSS_Inventory:165]LSS_Latitude_r:19)+","+\
									String:C10([LSS_Inventory:165]LSS_Longitude_r:18))
								
								If ($savechanges_b)
									SAVE RECORD:C53([LSS_Inventory:165])
								End if 
								
							Else 
								$errors_c.push(String:C10($row)+","+$strno_txt+","+"Record locked!")
							End if 
							
						Else 
							$errors_c.push(String:C10($row)+","+$strno_txt+","+"Not found!")
						End if 
						
						
					Else 
						$errors_c.push(String:C10($row)+", ,Not enough columns for Lat Lon update - need 3 , found :"+String:C10($rowdata_c.length)+" !")
						
					End if 
					
				: ($Option_L=2)  // mark records as removed with pinfo/year removed and make removed
					
					C_TEXT:C284($strno_txt; $cat_txt; $Descr_txt; $Lat_txt; $lon_txt; $prjno_txt; $yearblt_txt)
					If ($rowdata_c.length>=3)
						
						$strno_txt:=$rowdata_c[0]
						//$cat_txt:=$rowdata_c[1]
						//$Descr_txt:=$rowdata_c[2]
						//$Lat_txt:=$rowdata_c[3]
						//$lon_txt:=$rowdata_c[4]
						$prjno_txt:=$rowdata_c[1]
						$yearblt_txt:=$rowdata_c[2]
						
						QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
						
						If (Records in selection:C76([LSS_Inventory:165])=1)
							
							If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
								
								If (False:C215)
									//check if $descr is a valid structure type
									$indx_L:=Find in array:C230(LSS_STID_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25)
									
									If (LSS_STDescription_atxt{$indx_L}#$Descr_txt)
										// description does not match
										//try to find correct ID for the structure type descr
										$start_L:=Find in array:C230(LSS_STID_atxt; $cat_txt+"-@")  // find index where this category starts
										$indx_L:=Find in array:C230(LSS_STDescription_atxt; $Descr_txt; $start_L)
										
										Case of 
											: ($indx_L<0)
												//description not found!
												$errors_c.push(String:C10($row)+","+$strno_txt+","+\
													"Structure description "+$Descr_txt+" not found")
											: (LSS_STID_atxt{$indx_L}#$cat_txt+"-@")
												$errors_c.push(String:C10($row)+","+$strno_txt+","+\
													"Structure description "+$Descr_txt+" not found for category "+$cat_txt)
											Else 
												$messages_c.push(String:C10($row)+","+$strno_txt+","+\
													"Updating Structure type to "+LSS_STID_atxt{$indx_L}+"="+LSS_STDescription_atxt{$indx_L})
												[LSS_Inventory:165]LSS_StructureTypeId_s:25:=LSS_STID_atxt{$indx_L}
										End case 
										
									End if 
									
								End if 
								
								If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
									$errors_c.push(String:C10($row)+","+$strno_txt+","+"PINFO number,"+$prjno_txt+",not found!")
								End if 
								
								[LSS_Inventory:165]LSS_Status_s:35:="Removed"
								//[LSS_Inventory]LSS_Latitude_r:=Num($Lat_txt)
								//[LSS_Inventory]LSS_Longitude_r:=Num($lon_txt)
								[LSS_Inventory:165]LSS_ProjNoRemoved_L:38:=Num:C11($prjno_txt)
								[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
								[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
								[LSS_Inventory:165]LSS_YearRemoved_s:12:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
								//[LSS_Inventory]LSS_YearBuilt_s:=String(Year of(Date($yearblt_txt)))
								$messages_c.push(String:C10($row)+","+$strno_txt+","+\
									[LSS_Inventory:165]LSS_Status_s:35+","+\
									String:C10([LSS_Inventory:165]LSS_ProjNoRemoved_L:38)+","+\
									String:C10([LSS_Inventory:165]LSS_YearRemoved_s:12))  // +","+[LSS_Inventory]LSS_YearBuilt_s)
								
								If ($savechanges_b)
									SAVE RECORD:C53([LSS_Inventory:165])
								End if 
								
							Else 
								$errors_c.push(String:C10($row)+","+$strno_txt+","+"Record locked!")
							End if 
							
						Else 
							$errors_c.push(String:C10($row)+","+$strno_txt+","+"Not found!")
						End if 
						
					Else 
						$errors_c.push(String:C10($row)+", ,Not enough columns for removed - need 3 , found :"+String:C10($rowdata_c.length)+" !")
						
					End if 
					
				: ($Option_L=3) | ($Option_L=5)  // add proposed or active records 
					
					C_TEXT:C284($obj_txt; $strno_txt; $type_txt; $cat_txt; $Descr_txt; $Lat_txt; $lon_txt; $prjno_txt; $yearblt_txt; $town_txt; $mile_txt; $route_txt; $newStatus_txt)
					
					If ($Option_L=3)
						$newStatus_txt:="Proposed"
					Else 
						$newStatus_txt:="Active"
					End if 
					
					If ($rowdata_c.length>=18)
						C_BOOLEAN:C305($error_b)
						$error_b:=False:C215
						
						$obj_txt:=$rowdata_c[0]  //object ID
						$prjno_txt:=$rowdata_c[1]
						$type_txt:=$rowdata_c[2]
						$Descr_txt:=$rowdata_c[3]
						$town_txt:=$rowdata_c[9]
						If ($town_txt="NORTH ATTLEBOROUGH")
							$town_txt:="North Attleboro"
						End if 
						$mile_txt:=$rowdata_c[13]
						$route_txt:=$rowdata_c[14]
						$Lat_txt:=$rowdata_c[15]
						$lon_txt:=$rowdata_c[16]
						$yearblt_txt:=$rowdata_c[17]
						
						C_LONGINT:C283($townCode_L; $distr_L)
						C_TEXT:C284(LSS_TownCode_s)
						$townCode_L:=Find in array:C230(<>aTownName; $town_txt)
						If ($townCode_L>0)
							$distr_L:=Num:C11(<>aDistrict{$townCode_L})
							LSS_TownCode_s:=<>aBDEPT{$townCode_L}
						Else 
							$errors_c.push(String:C10($row)+","+$obj_txt+","+\
								"Town name ["+$town_txt+"] not found!")
							$error_b:=True:C214
						End if 
						
						$cat_txt:=""
						Case of 
							: ($type_txt="Sign")
								$cat_txt:="HS"
							: ($type_txt="ITS")
								$cat_txt:="IT"
							: ($type_txt="Signal")
								$cat_txt:="SI"
							: ($type_txt="Light")
								$cat_txt:="LI"
								
							Else 
								$errors_c.push(String:C10($row)+","+$obj_txt+","+\
									"Unknown Type "+$type_txt+"!")
								$error_b:=True:C214
						End case 
						
						//parse route
						C_TEXT:C284(LSS_RouteDesignation_s; $routeNum_txt; $routedir; $route_txt)
						C_LONGINT:C283($routeNum_L; $MaxNumber_L; LSS_Route_L)
						C_COLLECTION:C1488($routeParts_c)
						$routeParts_c:=Split string:C1554($route_txt; " "; sk trim spaces:K86:2)
						Case of 
							: ($route_txt="I@")
								LSS_RouteDesignation_s:="I"
								
							: ($route_txt="SR@")
								LSS_RouteDesignation_s:="M"
								
							: ($route_txt="US@")
								LSS_RouteDesignation_s:="U"
								
							Else 
								$error_b:=True:C214
								$errors_c.push(String:C10($row)+","+$obj_txt+","+\
									"Route designation not found in "+$route_txt)
								
						End case 
						
						If ($routeParts_c.length=2)
							$routedir:=$routeParts_c[1]
						Else 
							$error_b:=True:C214
							$errors_c.push(String:C10($row)+","+$obj_txt+","+\
								"Route direction not found in "+$route_txt)
							
						End if 
						
						LSS_Route_L:=Num:C11($routeParts_c[0])
						C_LONGINT:C283(LSS_RouteSuffix_L; LSS_SIN_2_L)
						LSS_SIN_2_L:=0
						LSS_RouteSuffix_L:=0
						//check if there is a route suffix and build the search string for the ID number - can only be A
						If (Substring:C12($routeParts_c[0]; Length:C16($routeParts_c[0]))="A")
							LSS_RouteSuffix_L:=1  //used in LSS_SetInventoryNumber
						End if 
						
						$indx_L:=0  //this will default to a blank for struct descr
						If (($cat_txt#"") & ($Descr_txt#""))
							//try to find correct ID for the structure type descr
							$start_L:=Find in array:C230(LSS_STID_atxt; $cat_txt+"-@")  // find index where this category starts
							//for signals and lights 
							Case of 
								: ($cat_txt="SI")
									If ($Descr_txt="@ Signal")
										$Descr_txt:=Replace string:C233($Descr_txt; " Signal"; "")
									End if 
								: ($cat_txt="LI")
									If ($Descr_txt="@ Light")
										$Descr_txt:=Replace string:C233($Descr_txt; " Light"; "")
									End if 
							End case 
							
							$indx_L:=Find in array:C230(LSS_STDescription_atxt; $Descr_txt; $start_L)
							
							Case of 
								: ($indx_L<0)
									//description not found!
									$errors_c.push(String:C10($row)+","+$obj_txt+","+\
										"Structure description ["+$Descr_txt+"] not found for category "+$cat_txt)
									//$error_b:=True
									$indx_L:=0  // don't throw error , just leave StructureType blank
									
								: (LSS_STID_atxt{$indx_L}#($cat_txt+"-@"))
									$errors_c.push(String:C10($row)+","+$obj_txt+","+\
										"Structure description "+$Descr_txt+" not found for category "+$cat_txt)
									//$error_b:=True
									$indx_L:=0  // don't throw error , just leave StructureType blank
									
							End case 
							
						End if 
						
						//check to see if there is another proposed or active structure at same lat lon
						
						QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Status_s:35=$newStatus_txt; *)
						
						QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_InventoryType_s:28=$cat_txt; *)
						If (LSS_RouteSuffix_L=0)
							$route_txt:=(LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12($routedir; 1; 1))
						Else 
							$route_txt:=(LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12($routedir; 1; 1))
						End if 
						QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Route_s:9=$route_txt; *)
						QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Latitude_r:19=Num:C11($Lat_txt); *)
						QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Longitude_r:18=Num:C11($lon_txt))
						If (Records in selection:C76([LSS_Inventory:165])#0)
							ARRAY TEXT:C222($dupStrnums_atxt; 0)
							SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_StructureNumber_s:6; $dupStrnums_atxt)
							C_TEXT:C284($dupStrnums_txt)
							$dupStrnums_txt:="<"+ut_ArrayToText(->$dupStrnums_atxt; "><")+">"
							$error_b:=True:C214
							$errors_c.push(String:C10($row)+","+$obj_txt+","+"Duplicate structure number(s),"+$dupStrnums_txt+\
								" found with type "+$cat_txt+\
								" Route "+$route_txt+\
								" Lat "+$Lat_txt+\
								" Lon "+$lon_txt)
							UNLOAD RECORD:C212([LSS_Inventory:165])
						End if 
						
						If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
							$errors_c.push(String:C10($row)+","+$obj_txt+","+"PINFO number "+$prjno_txt+" not found!")
						End if 
						
						If (Not:C34($error_b))
							//no errors so far - create record
							CREATE RECORD:C68([LSS_Inventory:165])
							C_LONGINT:C283($NextID_L)
							Inc_Sequence("LSS_InventoryId_s"; ->$NextID_L)
							[LSS_Inventory:165]LSS_InventoryId_s:1:=String:C10($NextID_L; <>KeyMask_s)
							[LSS_Inventory:165]LSS_Status_s:35:=$newStatus_txt
							[LSS_Inventory:165]LSS_InventoryType_s:28:=$cat_txt
							[LSS_Inventory:165]LSS_Category_s:2:=$type_txt
							[LSS_Inventory:165]LSS_District_L:3:=$distr_L
							[LSS_Inventory:165]LSS_RouteDirection_s:14:=$routedir
							[LSS_Inventory:165]LSS_MilePoint_r:8:=Num:C11($mile_txt)
							[LSS_Inventory:165]LSS_KiloPoint_r:7:=Round:C94([LSS_Inventory:165]LSS_MilePoint_r:8*1.609344; 2)
							If ([LSS_Inventory:165]LSS_MilePoint_r:8=0)
								[LSS_Inventory:165]LSS_MilePoint_r:8:=0.001  // mile point cannot be zero
							End if 
							[LSS_Inventory:165]LSS_Latitude_r:19:=Num:C11($Lat_txt)
							[LSS_Inventory:165]LSS_Town_s:4:=<>aTownName{$townCode_L}
							[LSS_Inventory:165]LSS_Longitude_r:18:=Num:C11($lon_txt)
							[LSS_Inventory:165]LSS_ProjNoBuilt_L:37:=Num:C11($prjno_txt)
							[LSS_Inventory:165]LSS_StructureTypeId_s:25:=LSS_STID_atxt{$indx_L}
							
							If ($Option_L=5)
								//use the year built when importing active structures - ignore for proposed
								[LSS_Inventory:165]LSS_YearBuilt_s:11:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
							End if 
							
							[LSS_Inventory:165]LSS_CreatedBy_s:27:=Current user:C182
							[LSS_Inventory:165]LSS_CreatedISODate_s:29:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
							LSS_SetInventoryNumber
							
							If ([LSS_Inventory:165]LSS_StructureNumber_s:6#"")
								$messages_c.push(String:C10($row)+","+$obj_txt+","+\
									[LSS_Inventory:165]LSS_StructureNumber_s:6+","+\
									[LSS_Inventory:165]LSS_InventoryType_s:28+","+\
									String:C10([LSS_Inventory:165]LSS_Latitude_r:19)+","+\
									String:C10([LSS_Inventory:165]LSS_Longitude_r:18))
								
								If ($savechanges_b)
									SAVE RECORD:C53([LSS_Inventory:165])
								End if 
								
							Else 
								$errors_c.push("Line "+String:C10($row)+","+"Obj ID,"+$obj_txt+","+"Structure number was not generated!")
							End if 
							
						End if 
					Else 
						$errors_c.push("Line "+String:C10($row)+",Not enough columns for proposed - need 18, found :"+String:C10($rowdata_c.length)+" !")
						
					End if 
					
			End case 
		End if 
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
			//abort loop
			$row:=$lines_c.length+1
		End if 
		
	End for 
	
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	C_TEXT:C284($wk1; $wk2)
	If ($messages_c.length>0)
		$logfile_o.setText($messages_c.join(Char:C90(Carriage return:K15:38)))
		$wk1:=XCEL_Workbook_open($logfile_o.platformPath)
		$wk2:=XCEL_workbook_save_as_xlsx($wk1; Replace string:C233($logfile_o.platformPath; $logfile_o.extension; ".xlsx"))
		XCEL_workbook_close($wk1)
		XCEL_workbook_close($wk2)
		
		If ($errors_c.length=1)
			//show the results if there are no errors
			SHOW ON DISK:C922(Replace string:C233($logfile_o.platformPath; $logfile_o.extension; ".xlsx"))
		End if 
		$logfile_o.delete()
	End if 
	
	If ($errors_c.length>1)
		$errorfile_o.setText($errors_c.join(Char:C90(Carriage return:K15:38)))
		$wk1:=XCEL_Workbook_open($errorfile_o.platformPath)
		$wk2:=XCEL_workbook_save_as_xlsx($wk1; Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
		XCEL_workbook_close($wk1)
		XCEL_workbook_close($wk2)
		$errorfile_o.delete()
		ALERT:C41("Errors detected! - see file "+Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
		SHOW ON DISK:C922(Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
		
	End if 
	
End if 
//End LSS_ImportUpdates