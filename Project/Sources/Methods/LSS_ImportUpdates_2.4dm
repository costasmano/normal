//%attributes = {"invisible":true}
//Method: LSS_ImportUpdates_2
//Description
// Import data to update Ancillary inventory version 2
// has more options, and requires matching of import data to columns in import file.
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 05/01/23, 13:27:12
	// ----------------------------------------------------
	//Created : 
	Mods_2023_07
	//  `Copy from LSS_ImportUpdates_2 ;added more options to the import - ability to match columns to data
End if 
//
C_LONGINT:C283($Option_L)
ARRAY TEXT:C222($importChoices_atxt; 0)
APPEND TO ARRAY:C911($importChoices_atxt; "Update Pinfo and date built")
APPEND TO ARRAY:C911($importChoices_atxt; "Update Lat Lon")
APPEND TO ARRAY:C911($importChoices_atxt; "Mark Removed with Pinfo and Yr")
APPEND TO ARRAY:C911($importChoices_atxt; "Update Pinfo removed - mark active")
APPEND TO ARRAY:C911($importChoices_atxt; "Add new record and mark active")
APPEND TO ARRAY:C911($importChoices_atxt; "Add proposed record")
$Option_L:=G_PickFromList(->$importChoices_atxt; "Choose import type")

C_TEXT:C284($importFile_txt; $logfile_txt; $errorfile_txt)
C_OBJECT:C1216($importFile_o; $logfile_o; $errorfile_o)
$importFile_txt:=Select document:C905(""; ".txt;.csv"; "Select import text file"; 0)
If (Ok=1)
	C_BOOLEAN:C305($savechanges_b)
	CONFIRM:C162("Save changes to database or run a test?"; "Run test"; "Save")
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
	
	$lines_c:=Split string:C1554($filedata_txt; Char:C90(Carriage return:K15:38); sk trim spaces:K86:2)
	
	If ($lines_c.length<2)
		ALERT:C41("Less than two lines found in selected file!")
	Else 
		//start the bar
		C_OBJECT:C1216($progress_o)
		Progress QUIT(0)
		$progress_o:=ProgressNew("Ancillary update from file"; $lines_c.length; True:C214; " lines"; 3)
		Progress SET PROGRESS($progress_o.progress; -1)
		Progress SET MESSAGE($progress_o.progress; "Initial setup")
		
		//initial setup of variables needed
		LSS_SetUp
		SORT ARRAY:C229(LSS_STID_atxt; LSS_STDescription_atxt; >)  //sort the structure type arrays
		
		Progress SET MESSAGE($progress_o.progress; "Configuring import")
		
		ARRAY POINTER:C280($data_aptr; 0)
		ARRAY TEXT:C222($datavar_atxt; 0)
		ARRAY LONGINT:C221($datacolumns_aL; 0)
		
		//variables read from file
		C_TEXT:C284($strno_txt; $cat_txt; $Descr_txt; $Lat_txt; $lon_txt; $prjno_txt; $yearblt_txt)
		C_TEXT:C284($type_txt; $town_txt; $mile_txt; $route_txt)
		
		Case of 
			: ($Option_L=1)  // Update Pinfo and date built
				APPEND TO ARRAY:C911($data_aptr; ->$strno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$prjno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$yearblt_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$strno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$prjno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$yearblt_txt")
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Pinfo"+","+"Yr Built")
				$errors_c.push("Line"+","+"Struct Num"+","+"Error")
				
			: ($Option_L=2)  //Update Lat Lon
				APPEND TO ARRAY:C911($data_aptr; ->$strno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$Lat_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$lon_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$strno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$Lat_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$lon_txt")
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Lat"+","+"Lon")
				$errors_c.push("Line"+","+"Error")
				
			: ($Option_L=3)  //Mark Removed with Pinfo and Yr
				APPEND TO ARRAY:C911($data_aptr; ->$strno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$prjno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$yearblt_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$strno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$prjno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$yearblt_txt")
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Pinfo"+","+"Yr removed")
				$errors_c.push("Line"+","+"Struct Num"+","+"Error")
				
			: ($Option_L=4)  //Update Pinfo removed - mark active
				APPEND TO ARRAY:C911($data_aptr; ->$strno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$prjno_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$strno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$prjno_txt")
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Pinfo")
				$errors_c.push("Line"+","+"Error")
				
			: ($Option_L=5)  // new record and mark active
				APPEND TO ARRAY:C911($data_aptr; ->$prjno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$type_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$town_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$mile_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$route_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$Lat_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$lon_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$yearblt_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$prjno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$type_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$town_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$mile_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$route_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$Lat_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$lon_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$yearblt_txt")
				ARRAY LONGINT:C221($datacolumns_aL; Size of array:C274($data_aptr))
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Type"+","+"Lat"+","+"Lon")
				$errors_c.push("Line"+","+"Error")
				
			: ($Option_L=6)  //Add proposed record
				
				APPEND TO ARRAY:C911($data_aptr; ->$prjno_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$type_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$town_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$mile_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$route_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$Lat_txt)
				APPEND TO ARRAY:C911($data_aptr; ->$lon_txt)
				APPEND TO ARRAY:C911($datavar_atxt; "$prjno_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$type_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$town_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$mile_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$route_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$Lat_txt")
				APPEND TO ARRAY:C911($datavar_atxt; "$lon_txt")
				
				$messages_c.push("Line"+","+"Struct Num"+","+"Status"+","+"Type"+","+"Lat"+","+"Lon")
				$errors_c.push("Line"+","+"Error")
				
		End case 
		
		ARRAY LONGINT:C221($datacolumns_aL; Size of array:C274($data_aptr))
		
		
		//match columns from headers of first row
		$rowdata_c:=Split string:C1554($lines_c[0]; $column_sep; sk trim spaces:K86:2)  //get the column names from the first row
		ARRAY TEXT:C222($columnnames_atxt; 0)
		COLLECTION TO ARRAY:C1562($rowdata_c; $columnnames_atxt)
		$rowdata_c:=Split string:C1554($lines_c[1]; $column_sep; sk trim spaces:K86:2)  // get a sample data from the second row
		ARRAY LONGINT:C221($columnnumbers_aL; Size of array:C274($columnnames_atxt))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($columnnumbers_aL))
			$columnnumbers_aL{$loop_L}:=$loop_L
			$columnnames_atxt{$loop_L}:=$columnnames_atxt{$loop_L}+" : <"+$rowdata_c[$loop_L-1]+">"
		End for 
		
		C_LONGINT:C283($column_pick)
		C_BOOLEAN:C305($picked_b; $abort_b)
		
		For ($loop_L; 1; Size of array:C274($data_aptr))
			$picked_b:=False:C215
			$abort_b:=False:C215
			Repeat 
				$column_pick:=G_PickFromList(->$columnnames_atxt; "Select column for "+$datavar_atxt{$loop_L})
				
				If ($column_pick>0)
					$picked_b:=True:C214
					$datacolumns_aL{$loop_L}:=$columnnumbers_aL{$column_pick}
					//remove column from list
					DELETE FROM ARRAY:C228($columnnames_atxt; $column_pick; 1)
					DELETE FROM ARRAY:C228($columnnumbers_aL; $column_pick; 1)
					
				Else 
					CONFIRM:C162("Try again or abort column selection?"; "Try again"; "abort")
					If (OK=0)
						$abort_b:=True:C214
					End if 
				End if 
				
			Until ($picked_b | $abort_b)
			
			
			If ($abort_b)
				$loop_L:=Size of array:C274($data_aptr)+1
			End if 
			
		End for 
		
		
		If (Not:C34($abort_b))  //column selection was not aborted
			
			C_COLLECTION:C1488($rowdata_c)
			C_LONGINT:C283($row)
			
			C_LONGINT:C283($indx_L; $start_L)
			
			//get all pinfo numbers to check
			ALL RECORDS:C47([PRJ_ProjectFile:117])
			ARRAY LONGINT:C221($pfileNos_aL; 0)
			SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileNumber_l:3; $pfileNos_aL)
			
			//Assume header row : start from element [1]. 
			
			C_LONGINT:C283($dataloop_L)
			C_POINTER:C301($data_ptr)
			For ($row; 1; ($lines_c.length-1))
				//update progress
				UpdateProgressNew($progress_o; $row)
				$rowdata_c:=Split string:C1554($lines_c[$row]; $column_sep; sk trim spaces:K86:2)
				If ($rowdata_c.length>0)
					
					//load data
					For ($dataloop_L; 1; Size of array:C274($data_aptr))
						$data_ptr:=$data_aptr{$dataloop_L}
						$data_ptr->:=$rowdata_c[$datacolumns_aL{$dataloop_L}-1]  //collection index starts from 0
					End for 
					
					Case of 
							
						: ($Option_L=1)  //Update of records
							
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
							
							If (Records in selection:C76([LSS_Inventory:165])=1)
								
								If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
									
									//check proj file num
									
									If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
										$errors_c.push(String:C10($row)+","+$strno_txt+","+"PINFO number"+","+$prjno_txt+","+"not found!")
									End if 
									
									[LSS_Inventory:165]LSS_Status_s:35:="Active"
									[LSS_Inventory:165]LSS_ProjNoBuilt_L:37:=Num:C11($prjno_txt)
									[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
									[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
									[LSS_Inventory:165]LSS_YearBuilt_s:11:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
									$messages_c.push(String:C10($row)+","+$strno_txt+","+\
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
							
						: ($Option_L=2)  //Update lat lon
							
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
							
							If (Records in selection:C76([LSS_Inventory:165])=1)
								
								If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
									[LSS_Inventory:165]LSS_Latitude_r:19:=Num:C11($Lat_txt)
									[LSS_Inventory:165]LSS_Longitude_r:18:=Num:C11($lon_txt)
									[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
									[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
									
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
							
						: ($Option_L=3)  // mark records as removed
							
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
							
							If (Records in selection:C76([LSS_Inventory:165])=1)
								
								If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
									
									If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
										$errors_c.push(String:C10($row)+","+$strno_txt+","+"PINFO number,"+$prjno_txt+",not found!")
									End if 
									
									[LSS_Inventory:165]LSS_Status_s:35:="Removed"
									[LSS_Inventory:165]LSS_ProjNoRemoved_L:38:=Num:C11($prjno_txt)
									[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
									[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
									[LSS_Inventory:165]LSS_YearRemoved_s:12:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
									$messages_c.push(String:C10($row)+","+$strno_txt+","+\
										[LSS_Inventory:165]LSS_Status_s:35+","+\
										String:C10([LSS_Inventory:165]LSS_ProjNoRemoved_L:38)+","+\
										String:C10([LSS_Inventory:165]LSS_YearRemoved_s:12))
									
									If ($savechanges_b)
										SAVE RECORD:C53([LSS_Inventory:165])
									End if 
									
								Else 
									$errors_c.push(String:C10($row)+","+$strno_txt+","+"Record locked!")
								End if 
								
							Else 
								$errors_c.push(String:C10($row)+","+$strno_txt+","+"Not found!")
							End if 
							
						: ($Option_L=4)  // //Update Pinfo removed - mark active
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$strno_txt)
							
							If (Records in selection:C76([LSS_Inventory:165])=1)
								
								If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
									
									If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
										$errors_c.push(String:C10($row)+","+$strno_txt+","+"PINFO number,"+$prjno_txt+",not found!")
									End if 
									
									[LSS_Inventory:165]LSS_Status_s:35:="Active"
									[LSS_Inventory:165]LSS_ProjNoRemoved_L:38:=Num:C11($prjno_txt)
									[LSS_Inventory:165]LSS_ModifiedBy_s:30:=Current user:C182
									[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
									$messages_c.push(String:C10($row)+","+$strno_txt+","+\
										[LSS_Inventory:165]LSS_Status_s:35+","+\
										String:C10([LSS_Inventory:165]LSS_ProjNoRemoved_L:38))
									
									If ($savechanges_b)
										SAVE RECORD:C53([LSS_Inventory:165])
									End if 
									
								Else 
									$errors_c.push(String:C10($row)+","+$strno_txt+","+"Record locked!")
								End if 
								
							Else 
								$errors_c.push(String:C10($row)+","+$strno_txt+","+"Not found!")
							End if 
							
						: ($Option_L=5)  // add existing records mark active
							
							C_BOOLEAN:C305($error_b)
							$error_b:=False:C215
							
							If ($town_txt="NORTH ATTLEBOROUGH")
								$town_txt:="North Attleboro"
							End if 
							
							C_LONGINT:C283($townCode_L; $distr_L)
							C_TEXT:C284(LSS_TownCode_s)
							$townCode_L:=Find in array:C230(<>aTownName; $town_txt)
							If ($townCode_L>0)
								$distr_L:=Num:C11(<>aDistrict{$townCode_L})
								LSS_TownCode_s:=<>aBDEPT{$townCode_L}
							Else 
								$errors_c.push(String:C10($row)+","+\
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
									$errors_c.push(String:C10($row)+","+\
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
									$errors_c.push(String:C10($row)+","+\
										"Route designation not found in "+$route_txt)
									
							End case 
							
							If ($routeParts_c.length=2)
								$routedir:=$routeParts_c[1]
							Else 
								$error_b:=True:C214
								$errors_c.push(String:C10($row)+","+\
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
							
							//check to see if there is another active structure at same lat lon
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Status_s:35="Active"; *)
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
								$errors_c.push(String:C10($row)+","+"Duplicate structure number(s),"+$dupStrnums_txt+\
									" found with type "+$cat_txt+\
									" Route "+$route_txt+\
									" Lat "+$Lat_txt+\
									" Lon "+$lon_txt)
								UNLOAD RECORD:C212([LSS_Inventory:165])
							End if 
							
							If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
								$errors_c.push(String:C10($row)+","+"PINFO number "+$prjno_txt+" not found!")
							End if 
							
							If (Not:C34($error_b))
								//no errors so far - create record
								CREATE RECORD:C68([LSS_Inventory:165])
								C_LONGINT:C283($NextID_L)
								Inc_Sequence("LSS_InventoryId_s"; ->$NextID_L)
								[LSS_Inventory:165]LSS_InventoryId_s:1:=String:C10($NextID_L; <>KeyMask_s)
								[LSS_Inventory:165]LSS_Status_s:35:="Active"
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
								[LSS_Inventory:165]LSS_YearBuilt_s:11:=String:C10(Year of:C25(Date:C102($yearblt_txt)))
								[LSS_Inventory:165]LSS_StructureTypeId_s:25:=LSS_STID_atxt{$indx_L}
								[LSS_Inventory:165]LSS_CreatedBy_s:27:=Current user:C182
								[LSS_Inventory:165]LSS_CreatedISODate_s:29:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
								LSS_SetInventoryNumber
								
								If ([LSS_Inventory:165]LSS_StructureNumber_s:6#"")
									$messages_c.push(String:C10($row)+","+\
										[LSS_Inventory:165]LSS_StructureNumber_s:6+","+\
										[LSS_Inventory:165]LSS_Status_s:35+","+\
										[LSS_Inventory:165]LSS_InventoryType_s:28+","+\
										String:C10([LSS_Inventory:165]LSS_Latitude_r:19)+","+\
										String:C10([LSS_Inventory:165]LSS_Longitude_r:18))
									
									If ($savechanges_b)
										SAVE RECORD:C53([LSS_Inventory:165])
									End if 
									
								Else 
									$errors_c.push("Line "+String:C10($row)+","+"Structure number was not generated!")
								End if 
								
							End if   // no errors found to create record
							
						: ($Option_L=6)  // add proposed records
							
							
							C_BOOLEAN:C305($error_b)
							$error_b:=False:C215
							
							If ($town_txt="NORTH ATTLEBOROUGH")
								$town_txt:="North Attleboro"
							End if 
							
							C_LONGINT:C283($townCode_L; $distr_L)
							C_TEXT:C284(LSS_TownCode_s)
							$townCode_L:=Find in array:C230(<>aTownName; $town_txt)
							If ($townCode_L>0)
								$distr_L:=Num:C11(<>aDistrict{$townCode_L})
								LSS_TownCode_s:=<>aBDEPT{$townCode_L}
							Else 
								$errors_c.push(String:C10($row)+","+\
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
									$errors_c.push(String:C10($row)+","+\
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
									$errors_c.push(String:C10($row)+","+\
										"Route designation not found in "+$route_txt)
									
							End case 
							
							If ($routeParts_c.length=2)
								$routedir:=$routeParts_c[1]
							Else 
								$error_b:=True:C214
								$errors_c.push(String:C10($row)+","+\
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
							
							//check to see if there is another proposed structure at same lat lon
							QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Status_s:35="Proposed"; *)
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
								$errors_c.push(String:C10($row)+","+"Duplicate structure number(s),"+$dupStrnums_txt+\
									" found with type "+$cat_txt+\
									" Route "+$route_txt+\
									" Lat "+$Lat_txt+\
									" Lon "+$lon_txt)
								UNLOAD RECORD:C212([LSS_Inventory:165])
							End if 
							
							If (Find in array:C230($pfileNos_aL; Num:C11($prjno_txt))<=0)
								$errors_c.push(String:C10($row)+","+"PINFO number "+$prjno_txt+" not found!")
							End if 
							
							If (Not:C34($error_b))
								//no errors so far - create record
								CREATE RECORD:C68([LSS_Inventory:165])
								C_LONGINT:C283($NextID_L)
								Inc_Sequence("LSS_InventoryId_s"; ->$NextID_L)
								[LSS_Inventory:165]LSS_InventoryId_s:1:=String:C10($NextID_L; <>KeyMask_s)
								[LSS_Inventory:165]LSS_Status_s:35:="Proposed"
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
								[LSS_Inventory:165]LSS_CreatedBy_s:27:=Current user:C182
								[LSS_Inventory:165]LSS_CreatedISODate_s:29:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
								LSS_SetInventoryNumber
								
								If ([LSS_Inventory:165]LSS_StructureNumber_s:6#"")
									$messages_c.push(String:C10($row)+","+\
										[LSS_Inventory:165]LSS_StructureNumber_s:6+","+\
										[LSS_Inventory:165]LSS_Status_s:35+","+\
										[LSS_Inventory:165]LSS_InventoryType_s:28+","+\
										String:C10([LSS_Inventory:165]LSS_Latitude_r:19)+","+\
										String:C10([LSS_Inventory:165]LSS_Longitude_r:18))
									
									If ($savechanges_b)
										SAVE RECORD:C53([LSS_Inventory:165])
									End if 
									
								Else 
									$errors_c.push("Line "+String:C10($row)+","+"Structure number was not generated!")
								End if 
								
							End if   // no errors found to create record
							
					End case   // end of import options
					
					
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
				//$logfile_o.delete()
			End if 
			
			If ($errors_c.length>1)
				$errorfile_o.setText($errors_c.join(Char:C90(Carriage return:K15:38)))
				$wk1:=XCEL_Workbook_open($errorfile_o.platformPath)
				$wk2:=XCEL_workbook_save_as_xlsx($wk1; Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
				XCEL_workbook_close($wk1)
				XCEL_workbook_close($wk2)
				//$errorfile_o.delete()
				ALERT:C41("Errors detected! - see file "+Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
				SHOW ON DISK:C922(Replace string:C233($errorfile_o.platformPath; $errorfile_o.extension; ".xlsx"))
				
			End if 
			
		Else   //column selection was not aborted
			
			//quit progress
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			
		End if   //column selection was aborted
		
		
	End if   // more than two lines found in file
	
End if 
//End LSS_ImportUpdates