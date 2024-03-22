//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/15/08, 16:48:19
	// ----------------------------------------------------
	// Method: ut_ExportABPBridgePhotos
	// Description
	// utility to export to a folder elevation photos for ABP bridges.
	// 1-Will read a file containing pairs of ProjectFile_no and BDEPT
	// 2-Find inventory photo inspections for these bridges
	// 3-Assemble the latest inv photo inspection
	// 4-get the related Elevation photos
	// 5- Save them to a pre-determined folder using
	//  ` "PFileNo-BDEPT-PhotoDesc.JPG"
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_LONGINT:C283($k; $I)
	C_TIME:C306($ImportFIle_t)
	ALERT:C41("select import file for ABPBridges")
	$ImportFIle_t:=Open document:C264(""; "")
	ARRAY TEXT:C222($Pfiles_atxt; 0)
	ARRAY TEXT:C222($Bdepts_atxt; 0)
	If (OK=1)
		C_LONGINT:C283($linecount_L)
		C_TEXT:C284($tBuffer_txt; $attrid_txt; $attrname_txt; $attrdesc_txt; $BDEPT_txt; $BaseFolder_txt)
		C_LONGINT:C283($attrID_L; $TabPos_L; $PrjFileNo_L; $PFILEID_L)
		C_LONGINT:C283($loaded_L; $exist_L; $noMatch_L)
		$BaseFolder_txt:=GetPath(Document)
		RECEIVE PACKET:C104($ImportFIle_t; $Tbuffer_txt; <>sCR)
		READ ONLY:C145(*)
		If ($Tbuffer_txt=("PROJECT_NO"+<>sTAB+"BDEPT@"))
			$linecount_L:=0
			$loaded_L:=0
			$exist_L:=0
			$noMatch_L:=0
			SHORT_MESSAGE("Reading file...")
			ARRAY TEXT:C222($LoadedPairs_atxt; 0)
			While (OK=1)
				RECEIVE PACKET:C104($ImportFIle_t; $Tbuffer_txt; <>sCR)
				$linecount_L:=$linecount_L+1
				$TabPos_L:=Position:C15(<>sTAB; $Tbuffer_txt)
				If ($TabPos_L>0)
					$PrjFileNo_L:=Num:C11(Substring:C12($Tbuffer_txt; 1; ($TabPos_L-1)))
					If ($PrjFileNo_L>0)
						$Tbuffer_txt:=Substring:C12($Tbuffer_txt; ($TabPos_L+1))
						$TabPos_L:=Position:C15(<>sTAB; $Tbuffer_txt)
						If ($TabPos_L>0)
							$BDEPT_txt:=Substring:C12($Tbuffer_txt; 1; ($TabPos_L-1))
						Else 
							$BDEPT_txt:=$Tbuffer_txt
						End if 
						If ($BDEPT_txt#"")
							//got everything
							$loaded_L:=$loaded_L+1
							INSERT IN ARRAY:C227($Pfiles_atxt; 1; 1)
							INSERT IN ARRAY:C227($Bdepts_atxt; 1; 1)
							$Pfiles_atxt{1}:=String:C10($PrjFileNo_L)
							$Bdepts_atxt{1}:=$BDEPT_txt
						End if 
					End if 
				End if 
			End while 
			CLOSE WINDOW:C154
			ALERT:C41("Read "+String:C10($linecount_L)+" ProjBridge lines. Added "+String:C10($loaded_L)+" new, Found "+String:C10($exist_L)+" already here, Found "+String:C10($noMatch_L)+" non-matching.")
			
		Else 
			ALERT:C41("Expecting header with column names PROJECT_NO and BDEPT !")
		End if 
		CLOSE DOCUMENT:C267($ImportFIle_t)
		
		If (Size of array:C274($Bdepts_atxt)>0)
			If (False:C215)
				C_TEXT:C284($rootFolder_txt; $PhotoFile_txt; $Bdept_txt; $Pfileno_txt)
				$rootFolder_txt:=ut_GetUserHomeFolder+"ABPPhotos"
				If (Not:C34(Test path name:C476($rootFolder_txt)=Is a folder:K24:2))
					CREATE FOLDER:C475($rootFolder_txt)
				End if 
				
			Else 
				$rootFolder_txt:=Select folder:C670("Choose folder for pictures")
			End if 
			
			SHORT_MESSAGE("Getting Bridges........")
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $Bdepts_atxt)
			ARRAY TEXT:C222($BDEPTBIns_atxt; Size of array:C274($Bdepts_atxt))
			ARRAY LONGINT:C221($PhotoFounds_aL; Size of array:C274($Bdepts_atxt))
			ARRAY TEXT:C222($INSPBDEPTBins_atxt; Size of array:C274($Bdepts_atxt))
			ARRAY LONGINT:C221($InspPhotfound_aL; Size of array:C274($Bdepts_atxt))
			
			MESSAGE:C88(<>sCR+"Getting Inv Insps...")
			RELATE MANY SELECTION:C340([InventoryPhotoInsp:112]BIN:2)
			CREATE EMPTY SET:C140([InventoryPhotoInsp:112]; "ABPINVPHOTOINSP")
			MESSAGE:C88(<>sCR+"Getting the latest...")
			ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2; >; [InventoryPhotoInsp:112]InvPhotoDate_D:3; <)
			C_TEXT:C284($lastBIN_txt)
			C_DATE:C307($LastDate_d)
			$lastBIN_txt:=""
			FIRST RECORD:C50([InventoryPhotoInsp:112])
			While (Not:C34(End selection:C36([InventoryPhotoInsp:112])))
				If ([InventoryPhotoInsp:112]BIN:2#$lastBIN_txt)
					$lastBIN_txt:=[InventoryPhotoInsp:112]BIN:2
					ADD TO SET:C119([InventoryPhotoInsp:112]; "ABPINVPHOTOINSP")
				End if 
				NEXT RECORD:C51([InventoryPhotoInsp:112])
			End while 
			USE SET:C118("ABPINVPHOTOINSP")
			CLEAR SET:C117("ABPINVPHOTOINSP")
			ARRAY TEXT:C222($InvBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
			SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]BIN:2; $InvBins_as)
			CONFIRM:C162("Export Inventory photos?")
			If (OK=1)
				MESSAGE:C88(<>sCR+"Getting the photos...")
				RELATE MANY SELECTION:C340([InventoryPhotos:113]InvPhotoInsp_ID:2)
				//QUERY([InventoryPhotos];[InventoryPhotos]InvPhotoInsp_ID=[InventoryPhotoInsp]InvPhotoInspID_L)
				QUERY SELECTION:C341([InventoryPhotos:113]; [InventoryPhotos:113]PhotoDescr_txt:3="@Elevation@")
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				
				MESSAGE:C88(<>sCR+"Exporting "+String:C10(Records in selection:C76([InventoryPhotos:113]))+" photos...")
				
				FIRST RECORD:C50([InventoryPhotos:113])
				While (Not:C34(End selection:C36([InventoryPhotos:113])))
					$Bdept_txt:=""
					$Pfileno_txt:=""
					QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoInspID_L:1=[InventoryPhotos:113]InvPhotoInsp_ID:2)
					FIRST RECORD:C50([InventoryPhotoInsp:112])
					If (Records in selection:C76([InventoryPhotoInsp:112])>0)
						QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[InventoryPhotoInsp:112]BIN:2)
						If (Records in selection:C76([Bridge MHD NBIS:1])>0)
							FIRST RECORD:C50([Bridge MHD NBIS:1])
							$Bdept_txt:=[Bridge MHD NBIS:1]BDEPT:1
						End if 
					End if 
					$k:=Find in array:C230($Bdepts_atxt; $Bdept_txt)
					If ($k>0)
						$Pfileno_txt:=$Pfiles_atxt{$k}
					End if 
					$PhotoFile_txt:=$rootFolder_txt+":"+$Pfileno_txt+"-"+$Bdept_txt+"-"+[InventoryPhotoInsp:112]BIN:2+"-"+[InventoryPhotos:113]PhotoDescr_txt:3+".JPG"
					$PhotoFounds_aL{$k}:=$PhotoFounds_aL{$k}+1  //increment photo counter
					If (Position:C15([InventoryPhotoInsp:112]BIN:2; $BDEPTBIns_atxt{$k})<=0)
						$BDEPTBIns_atxt{$k}:=$BDEPTBIns_atxt{$k}+","+[InventoryPhotoInsp:112]BIN:2
					End if 
					If (Test path name:C476($PhotoFile_txt)=Is a document:K24:1)
						//DELETE DOCUMENT($PhotoFile_txt)
					Else 
						BLOB TO DOCUMENT:C526($PhotoFile_txt; [InventoryPhotos:113]InvPhoto_X:4)
						//_ O _SET DOCUMENT TYPE($PhotoFile_txt;"JPEG")
						//_ O _SET DOCUMENT CREATOR($PhotoFile_txt;"????")
					End if 
					
					NEXT RECORD:C51([InventoryPhotos:113])
				End while 
				CLOSE WINDOW:C154
				
			End if 
			
			CONFIRM:C162("Export elevation inspection photos?")
			If (OK=1)
				//now try in regular inspections. this time we will not replace existing photos
				SHORT_MESSAGE("Looking for Inspections..")
				QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $Bdepts_atxt)
				CREATE SET:C116([Bridge MHD NBIS:1]; "ABPBRIDGES")
				MESSAGE:C88(<>sCR+"Removing Found ones...")
				SET QUERY DESTINATION:C396(Into set:K19:2; "BINSALREADYFOUND")
				QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $InvBins_as)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				DIFFERENCE:C122("ABPBRIDGES"; "BINSALREADYFOUND"; "ABPBRIDGES")
				USE SET:C118("ABPBRIDGES")
				CLEAR SET:C117("ABPBRIDGES")
				CLEAR SET:C117("BINSALREADYFOUND")
				MESSAGE:C88(<>sCR+"Getting inspections...")
				RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
				MESSAGE:C88(<>sCR+"Getting Non-Dive...")
				QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
				MESSAGE:C88(<>sCR+"Getting Images...")
				RELATE MANY SELECTION:C340([Standard Photos:36]InspID:1)
				MESSAGE:C88(<>sCR+"Getting photos...")
				QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
				MESSAGE:C88(<>sCR+"Getting Elevations...")
				QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]Description:2="@elevation@")
				MESSAGE:C88(<>sCR+"Back to inspections ...")
				RELATE ONE SELECTION:C349([Standard Photos:36]; [Inspections:27])
				ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; <)
				CREATE EMPTY SET:C140([Inspections:27]; "INSPECTIONSTOUSE")
				
				MESSAGE:C88(<>sCR+"Getting latest...")
				$lastBIN_txt:=""
				FIRST RECORD:C50([Inspections:27])
				While (Not:C34(End selection:C36([Inspections:27])))
					If ([Inspections:27]BIN:1#$lastBIN_txt)
						$lastBIN_txt:=[Inspections:27]BIN:1
						ADD TO SET:C119([Inspections:27]; "INSPECTIONSTOUSE")
					End if 
					NEXT RECORD:C51([Inspections:27])
				End while 
				
				USE SET:C118("INSPECTIONSTOUSE")
				CLEAR SET:C117("INSPECTIONSTOUSE")
				
				MESSAGE:C88(<>sCR+"Getting Images...")
				RELATE MANY SELECTION:C340([Standard Photos:36]InspID:1)
				MESSAGE:C88(<>sCR+"Getting photos...")
				QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
				MESSAGE:C88(<>sCR+"Getting elevations...")
				QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]Description:2="@elevation@")
				ARRAY LONGINT:C221($StdRecnums_aL; 0)
				MESSAGE:C88(<>sCR+"Loading IDs...")
				SELECTION TO ARRAY:C260([Standard Photos:36]StdPhotoID:7; $StdRecnums_aL)
				C_LONGINT:C283($photocounter_L)
				$photocounter_L:=1
				C_BLOB:C604($TempBlob)
				MESSAGE:C88(<>sCR+"Exporting "+String:C10(Records in selection:C76([Standard Photos:36]))+" photos...")
				MESSAGE:C88(String:C10($photocounter_L)+":"+String:C10($StdRecnums_aL{$photocounter_L})+"..")
				FIRST RECORD:C50([Standard Photos:36])
				While (Not:C34(End selection:C36([Standard Photos:36])))
					MESSAGE:C88(String:C10(Selected record number:C246([Standard Photos:36]))+"..")
					$Bdept_txt:=""
					$Pfileno_txt:=""
					QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Standard Photos:36]InspID:1)
					FIRST RECORD:C50([Inspections:27])
					If (Records in selection:C76([Inspections:27])>0)
						QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
						If (Records in selection:C76([Bridge MHD NBIS:1])>0)
							FIRST RECORD:C50([Bridge MHD NBIS:1])
							$Bdept_txt:=[Bridge MHD NBIS:1]BDEPT:1
						End if 
					End if 
					$k:=Find in array:C230($Bdepts_atxt; $Bdept_txt)
					If ($k>0)
						$Pfileno_txt:=$Pfiles_atxt{$k}
					End if 
					$PhotoFile_txt:=[Standard Photos:36]Description:2
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; <>sCR; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; <>sLF; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; ":"; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; "/"; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; "\\"; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; <>sQU; "_")
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; <>sTAB; "_")
					$PhotoFile_txt:=Substring:C12($PhotoFile_txt; 1; 40)
					$PhotoFile_txt:=Replace string:C233($PhotoFile_txt; "."; "")
					$PhotoFile_txt:=$rootFolder_txt+":"+$Pfileno_txt+"-"+$Bdept_txt+"-"+[Inspections:27]BIN:1+"-"+Substring:C12($PhotoFile_txt; 1; 40)+".JPG"
					If (Position:C15([Inspections:27]BIN:1; $INSPBDEPTBins_atxt{$k})<=0)
						$INSPBDEPTBins_atxt{$k}:=$INSPBDEPTBins_atxt{$k}+","+[Inspections:27]BIN:1
					End if 
					$InspPhotfound_aL{$k}:=$InspPhotfound_aL{$k}+1
					If (Test path name:C476($PhotoFile_txt)=Is a document:K24:1)
					Else 
						PICTURE TO BLOB:C692([Standard Photos:36]Std Photo:3; $TempBlob; "JPEG")
						BLOB TO DOCUMENT:C526($PhotoFile_txt; $TempBlob)
						//_ O _SET DOCUMENT TYPE($PhotoFile_txt;"JPEG")
						//_ O _SET DOCUMENT CREATOR($PhotoFile_txt;"????")
					End if 
					$photocounter_L:=$photocounter_L+1
					If ($photocounter_L<=Size of array:C274($StdRecnums_aL))
						MESSAGE:C88(String:C10($photocounter_L)+":"+String:C10($StdRecnums_aL{$photocounter_L})+"..")
					End if 
					NEXT RECORD:C51([Standard Photos:36])
				End while 
				SET BLOB SIZE:C606($TempBlob; 0)
				
			End if 
			
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			C_TIME:C306($reportFile_t)
			$reportFile_t:=Create document:C266($BaseFolder_txt+"ABPPhotoReport.txt"; "TEXT")
			If (OK=1)
				//_ O _SET DOCUMENT CREATOR($BaseFolder_txt+"ABPPhotoReport.txt";"????")
				For ($i; 1; Size of array:C274($BDEPTBIns_atxt))
					If ($BDEPTBIns_atxt{$i}=",@")
						$BDEPTBIns_atxt{$i}:=Substring:C12($BDEPTBIns_atxt{$i}; 2)
					End if 
					If ($INSPBDEPTBins_atxt{$i}=",@")
						$INSPBDEPTBins_atxt{$i}:=Substring:C12($INSPBDEPTBins_atxt{$i}; 2)
					End if 
					
					SEND PACKET:C103($reportFile_t; $Pfiles_atxt{$i}+<>sTAB+$Bdepts_atxt{$i}+<>sTAB+$BDEPTBIns_atxt{$i}+<>sTAB+String:C10($PhotoFounds_aL{$i})+<>sTAB+$INSPBDEPTBins_atxt{$i}+<>sTAB+String:C10($InspPhotfound_aL{$i})+<>sCR)
					
				End for 
				CLOSE DOCUMENT:C267($reportFile_t)
			End if 
			ARRAY TEXT:C222($BDEPTBIns_atxt; 0)
			ARRAY LONGINT:C221($PhotoFounds_aL; 0)
		End if 
		
		ARRAY TEXT:C222($Pfiles_atxt; 0)
		ARRAY TEXT:C222($Bdepts_atxt; 0)
		
		READ WRITE:C146(*)
	End if 
End if 