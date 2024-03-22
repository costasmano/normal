//%attributes = {"invisible":true}
//Method: ParsePersonnelexport
//Description
// Method to parse XML export from the External server from Personnel and FileID res table
// and update another server's Personnel table with the machine login info
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-22 18:42:50
	// ----------------------------------------------------
	//Created : 
	
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	
	C_TEXT:C284($xmldoc; $xmlTree)
	ARRAY TEXT:C222($xmlfiles_atxt; 0)
	$xmldoc:=Select document:C905(""; ".xml"; "select Personnel export xml file to parse"; 0; $xmlfiles_atxt)
	C_BOOLEAN:C305($updateRemote_b)
	
	
End if 
If (Ok=1)
	$xmlTree:=DOM Parse XML source:C719($xmlfiles_atxt{1})
	C_OBJECT:C1216($personnel_o)
	SHORT_MESSAGE("Parsing personnel")
	$personnel_o:=Xml_ToObject($xmlTree)
	DOM CLOSE XML:C722($xmlTree)
	CLOSE WINDOW:C154
	$xmldoc:=Select document:C905(""; ".xml"; "select FileIDRes export xml file to parse"; 0; $xmlfiles_atxt)
	
	If (Ok=1)
		$xmlTree:=DOM Parse XML source:C719($xmlfiles_atxt{1})
		C_OBJECT:C1216($fileIDRes_o)
		SHORT_MESSAGE("Parsing FileIDRes")
		$fileIDRes_o:=Xml_ToObject($xmlTree)
		DOM CLOSE XML:C722($xmlTree)
		CLOSE WINDOW:C154
		
		ARRAY LONGINT:C221($ExtIDs_aL; 0)
		ARRAY LONGINT:C221($MainServIDs_aL; 0)
		C_LONGINT:C283($fileidrefs_L; $FileIdRef_L)
		$fileidrefs_L:=$fileIDRes_o.Root.FileIDRes_Table.length
		ARRAY LONGINT:C221($ExtIDs_aL; $fileidrefs_L)
		ARRAY LONGINT:C221($MainServIDs_aL; $fileidrefs_L)
		C_LONGINT:C283($RefId_L)
		$RefId_L:=0
		For ($FileIdRef_L; 0; $fileidrefs_L-1)
			If ($fileIDRes_o.Root.FileIDRes_Table[$FileIdRef_L].Destination="MHD BMS")
				$RefId_L:=$RefId_L+1
				$ExtIDs_aL{$RefId_L}:=Num:C11($fileIDRes_o.Root.FileIDRes_Table[$FileIdRef_L].Local_ID)
				$MainServIDs_aL{$RefId_L}:=Num:C11($fileIDRes_o.Root.FileIDRes_Table[$FileIdRef_L].Destination_ID)
			End if 
		End for 
		
		C_LONGINT:C283($pers_L; $numPers_L)
		$numPers_L:=$personnel_o.Root.Personnel.length
		
		C_TEXT:C284($Machine_txt)
		
		C_OBJECT:C1216($Pers_o; $machine_o; $remotemachine_o)
		C_BOOLEAN:C305(4D_ERROR_B)
		//$Pers_o.MachineName_txt
		//$Pers_o.First_Name
		//$Pers_o.Last_Name
		//$Pers_o.Person_ID
		//$Pers_o.Employer
		//$Pers_o.User_ID_4D
		clone_IPAddress_txt:="146.243.128.5:19812"
		Username_txt:="designer"
		clone_ControlConnect
		If (OK=1)
			
			C_LONGINT:C283($FidIndx_L; $RemoteID_L; $remote4DUID_L)
			C_TEXT:C284($remoteFname; $RemoteLName; $remoteEmpl; $remoteMach)
			
			ARRAY TEXT:C222($ExtName_atxt; $personnel_o.Root.Personnel.length)
			ARRAY TEXT:C222($ExtMachine_atxt; $personnel_o.Root.Personnel.length)
			ARRAY LONGINT:C221($ExtPersID_aL; $personnel_o.Root.Personnel.length)
			ARRAY LONGINT:C221($Ext4DUID_aL; $personnel_o.Root.Personnel.length)
			ARRAY TEXT:C222($ServerName_atxt; $personnel_o.Root.Personnel.length)
			ARRAY TEXT:C222($ServerMachine_atxt; $personnel_o.Root.Personnel.length)
			ARRAY LONGINT:C221($ServerPersID_aL; $personnel_o.Root.Personnel.length)
			ARRAY LONGINT:C221($Server4DUID_aL; $personnel_o.Root.Personnel.length)
			ARRAY TEXT:C222($FinalMachine_atxt; $personnel_o.Root.Personnel.length)
			
			CREATE RECORD:C68([Activity Log:59])
			[Activity Log:59]FileID Local:24:=Table:C252(->[Personnel:42])
			[Activity Log:59]FieldID Local:25:=Field:C253(->[Personnel:42]Person ID:1)
			
			C_BOOLEAN:C305(InWHKRUpdate_b)
			InWHKRUpdate_b:=False:C215  // need this for proper working in ut_SQLSelectForLoad
			C_LONGINT:C283($pers_L)
			$pers_L:=0
			//start the bar
			C_OBJECT:C1216($progress_o)
			$progress_o:=ProgressNew("Scanning Personnel"; $personnel_o.Root.Personnel.length; \
				True:C214; " Person"; 3)
			C_BOOLEAN:C305($doneForeach)
			$doneForeach:=False:C215
			For each ($Pers_o; $personnel_o.Root.Personnel) While ($doneForeach=False:C215)
				$pers_L:=$pers_L+1
				
				//update progress
				UpdateProgressNew($progress_o; $pers_L)
				
				$ExtName_atxt{$pers_L}:=$Pers_o.First_Name+" "+$Pers_o.Last_Name
				$ExtPersID_aL{$pers_L}:=Num:C11($Pers_o.Person_ID)
				$Ext4DUID_aL{$pers_L}:=Num:C11($Pers_o.User_ID_4D)
				$ExtMachine_atxt{$pers_L}:=$Pers_o.Machine_Name
				
				If ($Pers_o.Machine_Name#"")
					
					//Find the remote Id
					$FidIndx_L:=Find in array:C230($ExtIDs_aL; Num:C11($Pers_o.Person_ID))
					If ($FidIndx_L>0)
						$RemoteID_L:=$MainServIDs_aL{$FidIndx_L}
					Else 
						$RemoteID_L:=Num:C11($Pers_o.Person_ID)
					End if 
					Begin SQL
						select 
						[Personnel].[First Name],
						[Personnel].[Last Name],
						[Personnel].[Employer],
						[Personnel].[MachineName_txt],
						[Personnel].[UserID_4D]
						from [Personnel]
						where [Personnel].[Person ID] = :$RemoteID_L
						into :$remoteFname , :$RemoteLName, :$remoteEmpl, :$remoteMach, :$remote4DUID_L ;
					End SQL
					
					$ServerName_atxt{$pers_L}:=$remoteFname+" "+$RemoteLName
					$ServerPersID_aL{$pers_L}:=$RemoteID_L
					$Server4DUID_aL{$pers_L}:=$remote4DUID_L
					$ServerMachine_atxt{$pers_L}:=$remoteMach
					
					If (($remoteFname+$RemoteLName)=\
						($Pers_o.First_Name+$Pers_o.Last_Name))
						//names match - 
						4D_ERROR_B:=False:C215
						ON ERR CALL:C155("4D_Errors")
						$machine_o:=JSON Parse:C1218($Pers_o.Machine_Name; Is object:K8:27)
						$remotemachine_o:=JSON Parse:C1218($remoteMach; Is object:K8:27)
						ON ERR CALL:C155("")
						
						If (OB Is empty:C1297($machine_o))
							//external machine log has not been converted - covnert it now
							$machine_o:=PERS_ConvertStatsToObj($Pers_o.Machine_Name)
						End if 
						
						$updateRemote_b:=False:C215
						
						If (OB Is empty:C1297($remotemachine_o) & ($remoteMach#""))
							//Remote is not blank and not converted - convert it and mark to update it
							$remotemachine_o:=PERS_ConvertStatsToObj($remoteMach)
							$remoteMach:=JSON Stringify:C1217($remotemachine_o)
							$FinalMachine_atxt{$pers_L}:=$remoteMach
							$updateRemote_b:=True:C214
						End if 
						
						
						Case of 
							: (Not:C34(OB Is empty:C1297($machine_o)) & OB Is empty:C1297($remotemachine_o))
								//external is an object but remote is still empty
								//update server with the $pers_o.Machine_Name
								$remoteMach:=JSON Stringify:C1217($machine_o)
								$FinalMachine_atxt{$pers_L}:=$remoteMach
								$updateRemote_b:=True:C214
								
							: (OB Is empty:C1297($machine_o) & Not:C34(OB Is empty:C1297($remotemachine_o)))
								//external empty ; remote is not empty - leave 
							: (OB Is empty:C1297($machine_o) & OB Is empty:C1297($remotemachine_o))
								//both are empty ; leave 
								
							: (Not:C34(OB Is empty:C1297($machine_o)) & Not:C34(OB Is empty:C1297($remotemachine_o)))
								//They are both not empty - merge them
								ARRAY OBJECT:C1221($extStations_ao; 0)
								ARRAY OBJECT:C1221($mainStations_ao; 0)
								OB GET ARRAY:C1229($machine_o; "stations"; $extStations_ao)
								OB GET ARRAY:C1229($remotemachine_o; "stations"; $mainStations_ao)
								C_LONGINT:C283($ext_L; $main_L; $found_L)
								For ($ext_L; 1; Size of array:C274($extStations_ao))
									$found_L:=0
									For ($main_L; 1; Size of array:C274($mainStations_ao))
										If ($extStations_ao{$ext_L}.station=$mainStations_ao{$main_L}.station)
											//got a matching station name - check which date is latest
											$found_L:=$main_L
											
											Case of 
												: (Not:C34(OB Is defined:C1231($extStations_ao{$ext_L}; "lastdate")))
													//no date from external - leave it
												: (Not:C34(OB Is defined:C1231($mainStations_ao{$main_L}; "lastdate")))
													//no date in main - add all data from external
													$mainStations_ao{$main_L}:=$extStations_ao{$ext_L}
													$updateRemote_b:=True:C214
												Else 
													If ($extStations_ao{$ext_L}.lastdate>$mainStations_ao{$main_L}.lastdate)
														$mainStations_ao{$main_L}.lastdate:=$extStations_ao{$ext_L}.lastdate
														$updateRemote_b:=True:C214
													End if 
											End case 
											$main_L:=Size of array:C274($mainStations_ao)+1
										End if 
										
									End for 
									
									If ($found_L=0)
										//did not find it - append 
										APPEND TO ARRAY:C911($mainStations_ao; $extStations_ao{$ext_L})
										$updateRemote_b:=True:C214
									End if 
								End for 
								
								
								If ($updateRemote_b)
									SORT_Object_Array(->$mainStations_ao; "lastdate"; False:C215)  //sort descending
									OB SET ARRAY:C1227($remotemachine_o; "stations"; $mainStations_ao)
									$remoteMach:=JSON Stringify:C1217($remotemachine_o)
									$FinalMachine_atxt{$pers_L}:=$remoteMach
								End if 
								
								
						End case 
						
						If ($updateRemote_b)
							C_LONGINT:C283($numRecReserved_L)
							C_TEXT:C284($sqlcmd)
							$sqlcmd:="Select [Person ID] from [Personnel] "+\
								"where [Person ID] = "+String:C10($RemoteID_L)+\
								" FOR UPDATE ;"
							
							RefID_s:=String:C10($RemoteID_L)
							$numRecReserved_L:=ut_SQLSelectForLoad($sqlcmd; Type:C295([Personnel:42]Person ID:1))
							
							If ($numRecReserved_L=1)
								
								Begin SQL
									Update 
									[Personnel] Set [Personnel].[MachineName_txt]= :$remoteMach
									where [Personnel].[Person ID] = :$RemoteID_L ;
								End SQL
								
								
							End if 
							
						End if 
						
					Else 
						//if names don't match - means something wrong
						ALERT:C41($Pers_o.First_Name+" "+$Pers_o.Last_Name+" ID:"+$Pers_o.Person_ID+" not found in main server with PersID "+String:C10($RemoteID_L)+"!")
						
					End if 
					
				End if 
				
				//check if progress stopped
				If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
					//abort loop
					$doneForeach:=True:C214
				End if 
				
			End for each 
			//quit progress
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			
			SQL LOGOUT:C872
			
			C_TEXT:C284($CSVText_txt)
			$CSVText_txt:=ut_ArrayToText_CSV(","; ->$ExtName_atxt; ->$ExtPersID_aL; \
				->$Ext4DUID_aL; ->$ExtMachine_atxt; \
				->$ServerName_atxt; ->$ServerPersID_aL; ->$Server4DUID_aL; \
				->$ServerMachine_atxt; ->$FinalMachine_atxt)
			C_TEXT:C284($csvFile_txt)
			ARRAY TEXT:C222($csv_files_atxt; 0)
			$csvFile_txt:=Select document:C905(""; "csv"; "Select output for csv results"; File name entry:K24:17; $csv_files_atxt)
			If (OK=1)
				C_TIME:C306($csv_t)
				$csv_t:=Create document:C266($csv_files_atxt{1})
				CLOSE DOCUMENT:C267($csv_t)
				TEXT TO DOCUMENT:C1237($csv_files_atxt{1}; $CSVText_txt; UTF8 text without length:K22:17)
				SHOW ON DISK:C922($csv_files_atxt{1})
			End if 
		End if 
	End if 
	
End if 

//End ParsePersonnelexport