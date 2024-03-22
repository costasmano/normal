//%attributes = {"invisible":true}
C_TEXT:C284($msg_txt; $ReportFolder_txt)
C_TEXT:C284($notFound_txt)

$ReportFolder_txt:=Select folder:C670("Select folder for Reports"; 5)
C_TIME:C306($logFile_t)


SQL LOGIN:C817(""; ""; ""; *)
//ALERT("current data source "+Get current data source)
CONFIRM:C162("current data source "+SQL Get current data source:C990+". Continue with SQL calls to TISH?")
If (OK=1)
	ARRAY LONGINT:C221($Contrnos_aL; 0)
	ARRAY LONGINT:C221($ContrIDS_aL; 0)
	C_LONGINT:C283($StartTic_L; $EndTick_L; $ContrNoTicks_L; $VendorTicks_L)
	$StartTic_L:=Tickcount:C458
	Begin SQL
		SELECT  dbo.[tbl_contract].[contract_no],
		dbo.[tbl_contract].[contract_id]
		
		FROM dbo.[TBL_contract] 
		order by [dbo].[tbl_contract].[contract_no] Asc
		into  :$Contrnos_aL  , :$ContrIDS_aL ;
		
	End SQL
	$EndTick_L:=Tickcount:C458
	$ContrNoTicks_L:=$EndTick_L-$StartTic_L
	//also get the new Vendor IDs
	
	ARRAY LONGINT:C221($VendContrIDS_aL; 0)
	ARRAY LONGINT:C221($VendContrVendIDS_aL; 0)
	ARRAY TEXT:C222($VendorContrVendName_atxt; 0)
	$StartTic_L:=Tickcount:C458
	Begin SQL
		SELECT [CONTRACT_ID], 
		[CHILD_ID], 
		[CHILD_NAME]
		FROM [dbo].[View_CONTRACT_VENDOR]
		where [Parent_ID] is null
		into :$VendContrIDS_aL , :$VendContrVendIDS_aL , :$VendorContrVendName_atxt ;
		
	End SQL
	$EndTick_L:=Tickcount:C458
	$VendorTicks_L:=$EndTick_L-$StartTic_L
	ALERT:C41(String:C10(Size of array:C274($Contrnos_aL))+" Contracts in "+String:C10($ContrNoTicks_L)+" ticks,  "+String:C10(Size of array:C274($VendContrVendIDS_aL))+" Vendors  in "+String:C10($VendorTicks_L)+" ticks")
	SQL LOGOUT:C872
	C_BOOLEAN:C305($SaveToDB_b)
	CONFIRM:C162("Save changes to DB?")
	$SaveToDB_b:=(OK=1)
	READ ONLY:C145(*)
	If ($SaveToDB_b)
		READ WRITE:C146([PRJ_ConstructionProject:116])
		READ WRITE:C146([Conslt_Name:127])
		READ WRITE:C146([PRJ_DesignContracts:123])
		READ WRITE:C146([PRJ_Contractor:114])
	End if 
	
	//Fix Constr contract SQL IDs
	ALL RECORDS:C47([PRJ_ConstructionProject:116])
	C_LONGINT:C283($indx_L; $RecsFixed_L; $recsNotFound_L; $RecsMatch_L)
	FIRST RECORD:C50([PRJ_ConstructionProject:116])
	$RecsFixed_L:=0
	$recsNotFound_L:=0
	$RecsMatch_L:=0
	
	$logFile_t:=Create document:C266($ReportFolder_txt+"ContrSQLID_fix"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt")
	$msg_txt:="CP_ConstructionContractNo_s"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"CP_SQLID_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"$ContrIDS_aL"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"Result"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"Final SQL ID "+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103($logFile_t; $msg_txt)
	While (Not:C34(End selection:C36([PRJ_ConstructionProject:116])))
		$msg_txt:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+Char:C90(Tab:K15:37)
		$msg_txt:=$msg_txt+String:C10([PRJ_ConstructionProject:116]CP_SQLID_l:13)+Char:C90(Tab:K15:37)
		
		
		If ((Num:C11([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)>0) | ([PRJ_ConstructionProject:116]CP_SQLID_l:13>0))
			$indx_L:=Find in array:C230($Contrnos_aL; Num:C11([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5))
			If ($indx_L>0)
				$msg_txt:=$msg_txt+String:C10($ContrIDS_aL{$indx_L})+Char:C90(Tab:K15:37)
				
				If ([PRJ_ConstructionProject:116]CP_SQLID_l:13=$ContrIDS_aL{$indx_L})
					$RecsMatch_L:=$RecsMatch_L+1
					$msg_txt:=$msg_txt+"Match"+Char:C90(Tab:K15:37)
				Else 
					[PRJ_ConstructionProject:116]CP_SQLID_l:13:=$ContrIDS_aL{$indx_L}
					SAVE RECORD:C53([PRJ_ConstructionProject:116])
					$RecsFixed_L:=$RecsFixed_L+1
					$msg_txt:=$msg_txt+"Fixed"+Char:C90(Tab:K15:37)
				End if 
				
			Else 
				[PRJ_ConstructionProject:116]CP_SQLID_l:13:=-(Num:C11([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5))
				$recsNotFound_L:=$recsNotFound_L+1
				$notFound_txt:=$notFound_txt+" "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
				$msg_txt:=$msg_txt+""+Char:C90(Tab:K15:37)
				$msg_txt:=$msg_txt+"NotFound"+Char:C90(Tab:K15:37)
				SAVE RECORD:C53([PRJ_ConstructionProject:116])
			End if 
			$msg_txt:=$msg_txt+String:C10([PRJ_ConstructionProject:116]CP_SQLID_l:13)
			
		End if 
		$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
		SEND PACKET:C103($logFile_t; $msg_txt)
		NEXT RECORD:C51([PRJ_ConstructionProject:116])
	End while 
	CLOSE DOCUMENT:C267($logFile_t)
	SET TEXT TO PASTEBOARD:C523($notFound_txt)
	$msg_txt:="Scanned "+String:C10(Records in selection:C76([PRJ_ConstructionProject:116]))+" Constr. Contracts"
	$msg_txt:=$msg_txt+"Fixed "+String:C10($RecsFixed_L)+" Constr Contr records! "
	$msg_txt:=$msg_txt+"Matched "+String:C10($RecsMatch_L)+" !  "
	$msg_txt:=$msg_txt+"Did not find "+String:C10($recsNotFound_L)+" records! "+$notFound_txt
	$msg_txt:=$msg_txt+" These have been pasted on the clipboard"
	ALERT:C41($msg_txt)
	
	//Fix Design contract SQL IDs
	ALL RECORDS:C47([PRJ_DesignContracts:123])
	$RecsFixed_L:=0
	$recsNotFound_L:=0
	$RecsMatch_L:=0
	$logFile_t:=Create document:C266($ReportFolder_txt+"DesContrIDFix_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt")
	$msg_txt:="DC_DesignContractNumber_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"DC_SQLContractID_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"$ContrIDS_aL"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"Result"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"Final SQL ID "+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103($logFile_t; $msg_txt)
	
	FIRST RECORD:C50([PRJ_DesignContracts:123])
	While (Not:C34(End selection:C36([PRJ_DesignContracts:123])))
		$msg_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+Char:C90(Tab:K15:37)
		$msg_txt:=$msg_txt+String:C10([PRJ_DesignContracts:123]DC_SQLContractID_l:17)+Char:C90(Tab:K15:37)
		
		If (([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3>0) | ([PRJ_DesignContracts:123]DC_SQLContractID_l:17>0))
			$indx_L:=Find in array:C230($Contrnos_aL; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
			If ($indx_L>0)
				$msg_txt:=$msg_txt+String:C10($ContrIDS_aL{$indx_L})+Char:C90(Tab:K15:37)
				
				If ([PRJ_DesignContracts:123]DC_SQLContractID_l:17=$ContrIDS_aL{$indx_L})
					$RecsMatch_L:=$RecsMatch_L+1
					$msg_txt:=$msg_txt+"Match"+Char:C90(Tab:K15:37)
				Else 
					[PRJ_DesignContracts:123]DC_SQLContractID_l:17:=$ContrIDS_aL{$indx_L}
					SAVE RECORD:C53([PRJ_DesignContracts:123])
					$RecsFixed_L:=$RecsFixed_L+1
					$msg_txt:=$msg_txt+"Fixed"+Char:C90(Tab:K15:37)
				End if 
				
			Else 
				$recsNotFound_L:=$recsNotFound_L+1
				[PRJ_DesignContracts:123]DC_SQLContractID_l:17:=-[PRJ_DesignContracts:123]DC_DesignContractNumber_l:3
				SAVE RECORD:C53([PRJ_DesignContracts:123])
				$notFound_txt:=$notFound_txt+" "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
				$msg_txt:=$msg_txt+""+Char:C90(Tab:K15:37)
				$msg_txt:=$msg_txt+"NotFound"+Char:C90(Tab:K15:37)
			End if 
			$msg_txt:=$msg_txt+String:C10([PRJ_DesignContracts:123]DC_SQLContractID_l:17)
			
		End if 
		$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
		SEND PACKET:C103($logFile_t; $msg_txt)
		
		NEXT RECORD:C51([PRJ_DesignContracts:123])
	End while 
	CLOSE DOCUMENT:C267($logFile_t)
	
	SET TEXT TO PASTEBOARD:C523($notFound_txt)
	$msg_txt:="Scanned "+String:C10(Records in selection:C76([PRJ_DesignContracts:123]))+" Design Contracts"
	$msg_txt:=$msg_txt+"Fixed "+String:C10($RecsFixed_L)+" Design Contract records! "
	$msg_txt:=$msg_txt+"Matched "+String:C10($RecsMatch_L)+" !  "
	$msg_txt:=$msg_txt+"Did not find "+String:C10($recsNotFound_L)+" records! "+$notFound_txt
	$msg_txt:=$msg_txt+" These have been pasted on the clipboard"
	
	ALERT:C41($msg_txt)
	
	//now fix the vendor IDs
	//to prevent changing the selection of contracts when searching in vendors
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	
	$logFile_t:=Create document:C266($ReportFolder_txt+"ConstrContrVendorIDFix_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt")
	$msg_txt:="CP_ConstructionContractNo_s"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"CP_SQLID_L"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"$VendContrVendIDS_aL"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"ContractResult"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"VendorResults"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103($logFile_t; $msg_txt)
	
	ALL RECORDS:C47([PRJ_ConstructionProject:116])
	FIRST RECORD:C50([PRJ_ConstructionProject:116])
	C_LONGINT:C283($ContrScanned_L; $ContrVend_L; $VendRecMatch_L; $VendRecUpd_L; $newVendRec_L; $MultVendors_L)
	//Scan the contr contracts - and update contractors only for constuction contracts
	While (Not:C34(End selection:C36([PRJ_ConstructionProject:116])))
		$msg_txt:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+Char:C90(Tab:K15:37)
		$msg_txt:=$msg_txt+String:C10([PRJ_ConstructionProject:116]CP_SQLID_l:13)+Char:C90(Tab:K15:37)
		
		If ([PRJ_ConstructionProject:116]CP_SQLID_l:13>0)
			$indx_L:=Find in array:C230($VendContrIDS_aL; [PRJ_ConstructionProject:116]CP_SQLID_l:13)
			$ContrScanned_L:=$ContrScanned_L+1
			If ($indx_L>0)
				$msg_txt:=$msg_txt+String:C10($VendContrVendIDS_aL{$indx_L})+Char:C90(Tab:K15:37)
				
				If ([PRJ_ConstructionProject:116]CTR_ContractorID_l:2=$VendContrVendIDS_aL{$indx_L})
					$msg_txt:=$msg_txt+"VendorMatch"+Char:C90(Tab:K15:37)
					
				Else 
					[PRJ_ConstructionProject:116]CTR_ContractorID_l:2:=$VendContrVendIDS_aL{$indx_L}
					SAVE RECORD:C53([PRJ_ConstructionProject:116])
					$msg_txt:=$msg_txt+"FixedContractVendor"+Char:C90(Tab:K15:37)
				End if 
				
				$ContrVend_L:=$ContrVend_L+1
				QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=$VendContrVendIDS_aL{$indx_L})
				
				If (Records in selection:C76([PRJ_Contractor:114])>0)
					$msg_txt:=$msg_txt+"FoundContractor"+Char:C90(Tab:K15:37)
					
					//we have some records - update them if needed - only if the name does not match 
					//should be only 1 [PRJ_Contractor]CTR_ContractorID_l is unique
					FIRST RECORD:C50([PRJ_Contractor:114])
					While (Not:C34(End selection:C36([PRJ_Contractor:114])))
						
						If ([PRJ_Contractor:114]CTR_CompanyName_s:2=$VendorContrVendName_atxt{$indx_L})
							//match a=skip it
							$VendRecMatch_L:=$VendRecMatch_L+1
							$msg_txt:=$msg_txt+"VendorMatch"+Char:C90(Tab:K15:37)
						Else 
							//set the name and clear the Vendor code - probably vendor with code from CIS_2000
							//the vendor code will be updated by the nightly pull for blank vendor codes
							[PRJ_Contractor:114]CTR_CompanyName_s:2:=$VendorContrVendName_atxt{$indx_L}
							[PRJ_Contractor:114]CTR_VendorCode_s:3:=""
							SAVE RECORD:C53([PRJ_Contractor:114])
							$msg_txt:=$msg_txt+"VendorNameUpdated"+Char:C90(Tab:K15:37)
							$VendRecUpd_L:=$VendRecUpd_L+1
						End if 
						NEXT RECORD:C51([PRJ_Contractor:114])
					End while 
					
				Else 
					$msg_txt:=$msg_txt+"NewVendorRecord"+Char:C90(Tab:K15:37)
					//record not found - create one
					CREATE RECORD:C68([PRJ_Contractor:114])
					[PRJ_Contractor:114]CTR_ContractorID_l:1:=$VendContrVendIDS_aL{$indx_L}
					[PRJ_Contractor:114]CTR_CompanyName_s:2:=$VendorContrVendName_atxt{$indx_L}
					[PRJ_Contractor:114]CTR_VendorCode_s:3:=""
					SAVE RECORD:C53([PRJ_Contractor:114])
					$newVendRec_L:=$newVendRec_L+1
				End if 
			Else 
				$msg_txt:=$msg_txt+"NoVendor"+Char:C90(Tab:K15:37)
			End if 
			
		End if 
		$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
		SEND PACKET:C103($logFile_t; $msg_txt)
		NEXT RECORD:C51([PRJ_ConstructionProject:116])
	End while 
	CLOSE DOCUMENT:C267($logFile_t)
	
	$msg_txt:="Scanned "+String:C10($ContrScanned_L)+" contr records. "+Char:C90(13)
	$msg_txt:=$msg_txt+"Updated vendor ID in "+String:C10($VendRecUpd_L)+" contract records."+Char:C90(13)
	$msg_txt:=$msg_txt+"Found "+String:C10($VendRecMatch_L)+" vendor records with matching name"+Char:C90(13)
	$msg_txt:=$msg_txt+"Changed vendor name to "+String:C10($VendRecUpd_L)+" vendor records"+Char:C90(13)
	$msg_txt:=$msg_txt+"Created "+String:C10($newVendRec_L)+" new Vendor records"
	ALERT:C41($msg_txt)
	
	
	$logFile_t:=Create document:C266($ReportFolder_txt+"ConsltNameDFix_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt")
	$msg_txt:="DC_DesignContractNumber_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"DC_SQLContractID_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"$VendContrVendIDS_aL"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"[PRJ_DesignContracts]ConsultantNameID_l"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"ContractResult"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+"VendorResults"+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103($logFile_t; $msg_txt)
	
	ALL RECORDS:C47([PRJ_DesignContracts:123])
	FIRST RECORD:C50([PRJ_DesignContracts:123])
	C_LONGINT:C283($ConsMatch_L; $NewRec_L; $NoContrSQLIDFound_L)
	
	SORT ARRAY:C229($VendContrIDS_aL; $VendContrVendIDS_aL; $VendorContrVendName_atxt; >)
	
	While (Not:C34(End selection:C36([PRJ_DesignContracts:123])))
		$msg_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+Char:C90(Tab:K15:37)
		$msg_txt:=$msg_txt+String:C10([PRJ_DesignContracts:123]DC_SQLContractID_l:17)+Char:C90(Tab:K15:37)
		
		If ([PRJ_DesignContracts:123]DC_SQLContractID_l:17>0)
			$indx_L:=Find in array:C230($VendContrIDS_aL; [PRJ_DesignContracts:123]DC_SQLContractID_l:17)
			
			If ($indx_L>0)
				$msg_txt:=$msg_txt+String:C10($VendContrVendIDS_aL{$indx_L})+Char:C90(Tab:K15:37)
				$msg_txt:=$msg_txt+String:C10([PRJ_DesignContracts:123]ConsultantNameID_l:2)+Char:C90(Tab:K15:37)
				
				QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				C_BOOLEAN:C305($needNewREc_b)
				$needNewREc_b:=True:C214
				
				Case of 
					: (Records in selection:C76([Conslt_Name:127])=1)
						FIRST RECORD:C50([Conslt_Name:127])
						If (([Conslt_Name:127]SQL_VendorID_l:3=$VendContrVendIDS_aL{$indx_L}) & ([Conslt_Name:127]ConsultantName_s:2=$VendorContrVendName_atxt{$indx_L}))
							$needNewREc_b:=False:C215
							$ConsMatch_L:=$ConsMatch_L+1
							$msg_txt:=$msg_txt+"SingleVendorMatch"+Char:C90(Tab:K15:37)
						Else 
							$needNewREc_b:=False:C215
							[Conslt_Name:127]ConsultantName_s:2:=$VendorContrVendName_atxt{$indx_L}
							[Conslt_Name:127]SQL_VendorID_l:3:=$VendContrVendIDS_aL{$indx_L}
							If ($SaveToDB_b)
								SAVE RECORD:C53([Conslt_Name:127])
							End if 
							$msg_txt:=$msg_txt+"SingleVendorFIXRec ["+[Conslt_Name:127]ConsultantName_s:2+","+String:C10([Conslt_Name:127]SQL_VendorID_l:3)+"]"+Char:C90(Tab:K15:37)
							
						End if 
					: (Records in selection:C76([Conslt_Name:127])>1)
						//this should never happen - [Conslt_Name]ConsultantNameID_l is unique
						FIRST RECORD:C50([Conslt_Name:127])
						While (Not:C34(End selection:C36([Conslt_Name:127])))
							If (([Conslt_Name:127]SQL_VendorID_l:3=$VendContrVendIDS_aL{$indx_L}) & ([Conslt_Name:127]ConsultantName_s:2=$VendorContrVendName_atxt{$indx_L}))
								$needNewREc_b:=False:C215
								$ConsMatch_L:=$ConsMatch_L+1
								$msg_txt:=$msg_txt+String:C10(Selected record number:C246([Conslt_Name:127]))+": MultVendorMatch"+Char:C90(Tab:K15:37)
							Else 
								$msg_txt:=$msg_txt+String:C10(Selected record number:C246([Conslt_Name:127]))+": MultVendorNOMatch ["+[Conslt_Name:127]ConsultantName_s:2+"]"+Char:C90(Tab:K15:37)
							End if 
							
							NEXT RECORD:C51([Conslt_Name:127])
						End while 
						
					Else 
						
				End case 
				
				If ($needNewREc_b)
					$NewRec_L:=$NewRec_L+1
					
					If ($SaveToDB_b)
						CREATE RECORD:C68([Conslt_Name:127])
						Inc_Sequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)
						[Conslt_Name:127]ConsultantName_s:2:=$VendorContrVendName_atxt{$indx_L}
						[Conslt_Name:127]SQL_VendorID_l:3:=$VendContrVendIDS_aL{$indx_L}
						SAVE RECORD:C53([Conslt_Name:127])
					End if 
					$msg_txt:=$msg_txt+"NewConsltNameRec ["+$VendorContrVendName_atxt{$indx_L}+","+String:C10($VendContrVendIDS_aL{$indx_L})+"]"+Char:C90(Tab:K15:37)
					
					[PRJ_DesignContracts:123]ConsultantNameID_l:2:=[Conslt_Name:127]ConsultantNameID_l:1
					SAVE RECORD:C53([PRJ_DesignContracts:123])
					
				End if 
			Else 
				$msg_txt:=$msg_txt+"VendorIDNotFound"+Char:C90(Tab:K15:37)
				$NoContrSQLIDFound_L:=$NoContrSQLIDFound_L+1
			End if 
			
		End if 
		$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
		SEND PACKET:C103($logFile_t; $msg_txt)
		NEXT RECORD:C51([PRJ_DesignContracts:123])
	End while 
	CLOSE DOCUMENT:C267($logFile_t)
	
	ALERT:C41("Matched "+String:C10($ConsMatch_L)+" consultant names,   added "+String:C10($NewRec_L)+" cons names,  did not match "+String:C10($NoContrSQLIDFound_L)+" contr SQL IDs")
	
End if 

//Fix mult SQL IDs
$logFile_t:=Create document:C266($ReportFolder_txt+"MultConsltNameFix_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt")
$msg_txt:="SQL_VendorID_l"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"ConsultantNameID_l"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"$StrMgrIDs_aL"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"ManagerMatch"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"NumDesContracts"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"SetToConsNameID"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+"DesContractNumbers"+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
SEND PACKET:C103($logFile_t; $msg_txt)

ALL RECORDS:C47([Conslt_Name:127])
QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]SQL_VendorID_l:3>0)
ARRAY LONGINT:C221($ConsnameIds_aL; 0)
ARRAY LONGINT:C221($ConsSQLIDs_aL; 0)
ARRAY LONGINT:C221($StrMgrIDs_aL; 0)
ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]SQL_VendorID_l:3; >; [Conslt_Name:127]CurrentStructureProjectMgr_l:4; <)
SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; $ConsnameIds_aL; [Conslt_Name:127]SQL_VendorID_l:3; $ConsSQLIDs_aL; [Conslt_Name:127]CurrentStructureProjectMgr_l:4; $StrMgrIDs_aL)

SORT ARRAY:C229($ConsSQLIDs_aL; $ConsnameIds_aL; >)

C_LONGINT:C283($loop_L; $CurrSQL_ID_L; $CurrConsNameID_L; $FixDesRecs_L; $CurrStrPrjMgr_L)
$CurrSQL_ID_L:=$ConsSQLIDs_aL{1}
$CurrConsNameID_L:=$ConsnameIds_aL{1}
$CurrStrPrjMgr_L:=$StrMgrIDs_aL{1}
$msg_txt:=String:C10($ConsSQLIDs_aL{1})+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+String:C10($ConsnameIds_aL{1})+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+String:C10($StrMgrIDs_aL{1})+Char:C90(Tab:K15:37)
$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
SEND PACKET:C103($logFile_t; $msg_txt)

C_BOOLEAN:C305($UpdateDesContr_b)
For ($loop_L; 2; Size of array:C274($ConsSQLIDs_aL))
	$msg_txt:=String:C10($ConsSQLIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+String:C10($ConsnameIds_aL{$loop_L})+Char:C90(Tab:K15:37)
	$msg_txt:=$msg_txt+String:C10($StrMgrIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
	
	If ($ConsSQLIDs_aL{$loop_L}=$CurrSQL_ID_L)
		$UpdateDesContr_b:=True:C214
		If ($StrMgrIDs_aL{$loop_L}=0)
			//no mgr : do update of des contract
			$msg_txt:=$msg_txt+"ZeroMgr"+Char:C90(Tab:K15:37)
		Else 
			
			If ($StrMgrIDs_aL{$loop_L}=$CurrStrPrjMgr_L)
				$msg_txt:=$msg_txt+"SameMgr"+Char:C90(Tab:K15:37)
				//same mgr  : do update of des contract
			Else 
				//diff mgr : consider as new combo
				$msg_txt:=$msg_txt+"DiffMgr"+Char:C90(Tab:K15:37)
				$UpdateDesContr_b:=False:C215
				$CurrSQL_ID_L:=$ConsSQLIDs_aL{$loop_L}
				$CurrConsNameID_L:=$ConsnameIds_aL{$loop_L}
				$CurrStrPrjMgr_L:=$StrMgrIDs_aL{$loop_L}
			End if 
			
		End if 
		
		If ($UpdateDesContr_b)
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]ConsultantNameID_l:2=$ConsnameIds_aL{$loop_L})
			
			If (Records in selection:C76([PRJ_DesignContracts:123])>0)
				$msg_txt:=$msg_txt+String:C10(Records in selection:C76([PRJ_DesignContracts:123]))+Char:C90(Tab:K15:37)
				$msg_txt:=$msg_txt+String:C10($CurrConsNameID_L)+Char:C90(Tab:K15:37)
				
				FIRST RECORD:C50([PRJ_DesignContracts:123])
				While (Not:C34(End selection:C36([PRJ_DesignContracts:123])))
					$msg_txt:=$msg_txt+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+", "
					[PRJ_DesignContracts:123]ConsultantNameID_l:2:=$CurrConsNameID_L
					$FixDesRecs_L:=$FixDesRecs_L+1
					SAVE RECORD:C53([PRJ_DesignContracts:123])
					NEXT RECORD:C51([PRJ_DesignContracts:123])
				End while 
				
				$msg_txt:=$msg_txt+Char:C90(Tab:K15:37)
			End if 
			
		End if 
		
	Else 
		$msg_txt:=$msg_txt+"NewSequence"+Char:C90(Tab:K15:37)
		$CurrSQL_ID_L:=$ConsSQLIDs_aL{$loop_L}
		$CurrConsNameID_L:=$ConsnameIds_aL{$loop_L}
		$CurrStrPrjMgr_L:=$StrMgrIDs_aL{$loop_L}
	End if 
	
	$msg_txt:=$msg_txt+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103($logFile_t; $msg_txt)
	
End for 

CLOSE DOCUMENT:C267($logFile_t)

ALERT:C41("Fixed "+String:C10($FixDesRecs_L)+" des contr records")