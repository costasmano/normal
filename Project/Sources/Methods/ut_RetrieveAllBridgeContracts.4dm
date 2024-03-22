//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/08, 12:53:05
	// ----------------------------------------------------
	// Method: Method: ut_RetrieveAllBridgeContracts
	// Description
	//  `Retrieve info about all contracts related to bridges from the [Contracts] , [Contract_Maintenance]
	//  `and [PRJ_DesignContracts] tables. compile it into arrays, and stuff the arrays in a blob.
	// 
	// 
	// Parameters
	// $0 : $$Result_Blb
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2009_05  //r001  `05/14/09, 14:51:59  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//CHANGE TO USE  [PRJ_DCPFJoin] TABLE TO GET PROJECT FILE
	Mods_2009_06  //r002 `06/11/09, 13:43:32   `Merge PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v1
End if 
C_TEXT:C284($Task_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task_txt:=$1
Else 
	$Task_txt:=""
End if 
C_LONGINT:C283($iLoop)
Case of 
	: ($Task_txt="")
		C_BLOB:C604($0; $Result_Blb)
		READ ONLY:C145(*)
		ut_RetrieveAllBridgeContracts("INIT")
		ut_RetrieveAllBridgeContracts("GETINSPRTGS")
		ut_RetrieveAllBridgeContracts("GETPRESERVATION")
		ut_RetrieveAllBridgeContracts("DESIGN")
		//Store in Blob to return
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		VARIABLE TO BLOB:C532(RTCONTR_ContractNo_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltName_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltNamePinfo_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltAddr_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltPhone_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltEmail_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ConsltContact_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_AwardDate_aD; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_InitComplDate_aD; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ExtenComplDate_aD; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_Status_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ContrType_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ContrTypePinfo_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ContrDesc_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_FedAid_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ProjMgr_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ProjMgrPInfo_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_TotFundEnc_ar; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_TotFundApproxRem_ar; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_ProjNumbers_atxt; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_NumAssign_aL; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_NumInvoice_aL; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_NumInvoiceAcc_aL; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_TotAmtInvoice_ar; $Result_Blb; $offset_L)
		VARIABLE TO BLOB:C532(RTCONTR_TotAmtPaid_ar; $Result_Blb; $offset_L)
		
		READ WRITE:C146(*)
		$0:=$Result_Blb
		SET BLOB SIZE:C606($Result_Blb; 0)
		ut_RetrieveAllBridgeContracts("INIT")
		
	: ($Task_txt="GETINSPRTGS")
		//Insp /Ratings
		QUERY:C277([Contracts:79]; [Contracts:79]ContractNo:1#"")
		ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1)
		FIRST RECORD:C50([Contracts:79])
		RTCONTR_ProjMgr_txt:="Brian Clang"
		
		While (Not:C34(End selection:C36([Contracts:79])))
			RTCONTR_contractCount_L:=RTCONTR_contractCount_L+1
			RTCONTR_ContractNo_txt:=[Contracts:79]ContractNo:1
			RTCONTR_ConsltName_txt:=[Contracts:79]ConsltName:3
			QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=[Contracts:79]ConsltName:3; *)
			If ([Contracts:79]ContractType:2="@Inspe@")
				QUERY:C277([Conslt Address:77];  & ; [Conslt Address:77]Func_Insp:20=True:C214; *)
			End if 
			If ([Contracts:79]ContractType:2="@Ratin@")
				QUERY:C277([Conslt Address:77];  & ; [Conslt Address:77]Func_Rating:19=True:C214; *)
			End if 
			QUERY:C277([Conslt Address:77])
			If (Records in selection:C76([Conslt Address:77])>=1)
				FIRST RECORD:C50([Conslt Address:77])
				RTCONTR_ConsltAddr_txt:=[Conslt Address:77]Street1:8
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+[Conslt Address:77]Street2:9
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]City:10
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]State:11
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]Zip:12
				RTCONTR_ConsltPhone_txt:=[Conslt Address:77]PhoneNo1:13
				RTCONTR_ConsltEmail_txt:=[Conslt Address:77]Email:18
				RTCONTR_ConsltContact_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
			Else 
				RTCONTR_ConsltAddr_txt:=""
				RTCONTR_ConsltPhone_txt:=""
				RTCONTR_ConsltEmail_txt:=""
				RTCONTR_ConsltContact_txt:=""
			End if 
			
			RTCONTR_AwardDate_D:=[Contracts:79]AwardContractDate:4
			RTCONTR_InitComplDate_D:=[Contracts:79]InitialCompleteDate:5
			RTCONTR_ExtenComplDate_D:=[Contracts:79]ExtendedCompleteDate:6
			RTCONTR_ContrType_txt:=[Contracts:79]ContractType:2
			RTCONTR_FedAid_txt:=f_Boolean2String([Contracts:79]FederalFund:8; "YN")
			If ([Contracts:79]FederalAidNo:9#"")
				RTCONTR_FedAid_txt:=RTCONTR_FedAid_txt+","+[Contracts:79]FederalAidNo:9
			End if 
			RTCONTR_TotFundEnc_r:=[Contracts:79]TotalEncumbered:16
			RTCONTR_TotFundApproxRem_r:=[Contracts:79]ApproxRemainingFund:19
			SET QUERY DESTINATION:C396(Into variable:K19:4; RTCONTR_NumAssign_L)
			QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			QUERY:C277([Contract Invoice:84]; [Contract Invoice:84]ContractNo:3=[Contracts:79]ContractNo:1)
			RTCONTR_NumInvoice_L:=Records in selection:C76([Contract Invoice:84])
			ARRAY REAL:C219($invAmt_ar; 0)
			ARRAY BOOLEAN:C223($invAcc_ab; 0)
			SELECTION TO ARRAY:C260([Contract Invoice:84]TotalAmount:11; $invAmt_ar; [Contract Invoice:84]Accepted:12; $invAcc_ab)
			RTCONTR_NumInvoiceAcc_L:=0
			RTCONTR_TotAmtInvoice_r:=0
			RTCONTR_TotAmtPaid_r:=0
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274($invAmt_ar))
				RTCONTR_TotAmtInvoice_r:=RTCONTR_TotAmtInvoice_r+$invAmt_ar{$i}
				If ($invAcc_ab{$i})
					RTCONTR_TotAmtPaid_r:=RTCONTR_TotAmtPaid_r+$invAmt_ar{$i}
					RTCONTR_NumInvoiceAcc_L:=RTCONTR_NumInvoiceAcc_L+1
				End if 
				
			End for 
			
			ut_RetrieveAllBridgeContracts("GETPRJCONTRACTINFO")
			
			ut_RetrieveAllBridgeContracts("ADDTOARRAYS")
			
			NEXT RECORD:C51([Contracts:79])
		End while 
		
	: ($Task_txt="GETPRESERVATION")
		//Preservation contracts
		QUERY:C277([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1#"")
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1)
		FIRST RECORD:C50([Contract_Maintenance:97])
		While (Not:C34(End selection:C36([Contract_Maintenance:97])))
			RTCONTR_contractCount_L:=RTCONTR_contractCount_L+1
			//table [Contract_Maintenance]
			RTCONTR_ContractNo_txt:=[Contract_Maintenance:97]ContractNo:1
			RTCONTR_ConsltName_txt:=[Contract_Maintenance:97]ConsultantName:3
			QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=[Contract_Maintenance:97]ConsultantName:3; *)
			QUERY:C277([Conslt Address:77];  & ; [Conslt Address:77]Func_Design:21=True:C214)
			If (Records in selection:C76([Conslt Address:77])>=1)
				FIRST RECORD:C50([Conslt Address:77])
				RTCONTR_ConsltAddr_txt:=[Conslt Address:77]Street1:8
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+[Conslt Address:77]Street2:9
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]City:10
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]State:11
				RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]Zip:12
				RTCONTR_ConsltPhone_txt:=[Conslt Address:77]PhoneNo1:13
				RTCONTR_ConsltEmail_txt:=[Conslt Address:77]Email:18
				RTCONTR_ConsltContact_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
			Else 
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=[Contract_Maintenance:97]ConsultantName:3)
				If (Records in selection:C76([Conslt Address:77])>1)
					FIRST RECORD:C50([Conslt Address:77])
					RTCONTR_ConsltAddr_txt:=[Conslt Address:77]Street1:8
					RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+[Conslt Address:77]Street2:9
					RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]City:10
					RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]State:11
					RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]Zip:12
					RTCONTR_ConsltPhone_txt:=[Conslt Address:77]PhoneNo1:13
					RTCONTR_ConsltEmail_txt:=[Conslt Address:77]Email:18
					RTCONTR_ConsltContact_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
				Else 
					RTCONTR_ConsltAddr_txt:=""
					RTCONTR_ConsltPhone_txt:=""
					RTCONTR_ConsltEmail_txt:=""
					RTCONTR_ConsltContact_txt:=""
				End if 
			End if 
			
			RTCONTR_AwardDate_D:=[Contract_Maintenance:97]AwardContractDate:4
			RTCONTR_InitComplDate_D:=[Contract_Maintenance:97]InitialCompleteDate:5
			RTCONTR_ExtenComplDate_D:=[Contract_Maintenance:97]ExtendedCompleteDate:6
			RTCONTR_Status_txt:=[Contract_Maintenance:97]ContractStatus:7
			RTCONTR_ContrType_txt:=[Contract_Maintenance:97]ContractType:8
			RTCONTR_FedAid_txt:=f_Boolean2String([Contract_Maintenance:97]FederalFund:29; "YN")
			If ([Contract_Maintenance:97]FederalAidNo:9#"")
				RTCONTR_FedAid_txt:=RTCONTR_FedAid_txt+","+[Contract_Maintenance:97]FederalAidNo:9
			End if 
			RTCONTR_ProjMgr_txt:=[Contract_Maintenance:97]BridgePrjMgr:33
			RTCONTR_TotFundEnc_r:=[Contract_Maintenance:97]TotalEncumbered:16
			RTCONTR_TotFundApproxRem_r:=[Contract_Maintenance:97]ApproxRemainingFund:19
			QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
			RTCONTR_NumAssign_L:=Records in selection:C76([Contract_Assignment_Maintenance:101])
			ARRAY TEXT:C222($PfileNos_as; 0)  //Command Replaced was o_ARRAY string length was 30
			DISTINCT VALUES:C339([Contract_Assignment_Maintenance:101]ProjectIS:4; $PfileNos_as)
			RTCONTR_ProjFileNos_txt:=""
			For ($i; 1; Size of array:C274($PfileNos_as))
				If ($PfileNos_as{$i}#"")
					RTCONTR_ProjFileNos_txt:=RTCONTR_ProjFileNos_txt+", "+$PfileNos_as{$i}+","
				End if 
			End for 
			QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]ContractNo:3=[Contract_Maintenance:97]ContractNo:1)
			RTCONTR_NumInvoice_L:=Records in selection:C76([Invoice_Maintenance:95])
			ARRAY REAL:C219($invAmt_ar; 0)
			ARRAY BOOLEAN:C223($invAcc_ab; 0)
			SELECTION TO ARRAY:C260([Invoice_Maintenance:95]TotalAmount:11; $invAmt_ar; [Invoice_Maintenance:95]Accepted:12; $invAcc_ab)
			RTCONTR_NumInvoiceAcc_L:=0
			RTCONTR_TotAmtInvoice_r:=0
			RTCONTR_TotAmtPaid_r:=0
			For ($i; 1; Size of array:C274($invAmt_ar))
				RTCONTR_TotAmtInvoice_r:=RTCONTR_TotAmtInvoice_r+$invAmt_ar{$i}
				If ($invAcc_ab{$i})
					RTCONTR_TotAmtPaid_r:=RTCONTR_TotAmtPaid_r+$invAmt_ar{$i}
					RTCONTR_NumInvoiceAcc_L:=RTCONTR_NumInvoiceAcc_L+1
				End if 
				
			End for 
			ut_RetrieveAllBridgeContracts("GETPRJCONTRACTINFO")
			
			ut_RetrieveAllBridgeContracts("ADDTOARRAYS")
			
			NEXT RECORD:C51([Contract_Maintenance:97])
		End while 
		
	: ($Task_txt="DESIGN")
		//Design Contracts
		RTCONTR_NumInvoice_L:=0  //These are all the same
		RTCONTR_NumInvoiceAcc_L:=0
		RTCONTR_TotAmtInvoice_r:=0
		RTCONTR_TotAmtPaid_r:=0
		RTCONTR_FedAid_txt:=""
		RTCONTR_ContrType_txt:="Design"
		RTCONTR_ProjMgrPInfo_txt:=""
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3>0)
		ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
		ARRAY LONGINT:C221($DesRecNums_aL; 0)
		SELECTION TO ARRAY:C260([PRJ_DesignContracts:123]; $DesRecNums_aL)
		For ($iLoop; 1; Size of array:C274($DesRecNums_aL))
			GOTO RECORD:C242([PRJ_DesignContracts:123]; $DesRecNums_aL{$iLoop})
			LOAD RECORD:C52([PRJ_DesignContracts:123])
			C_LONGINT:C283($InspRtg_L; $Preserv_L)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $InspRtg_L)
			QUERY:C277([Contracts:79]; [Contracts:79]ContractNo:1=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3))
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Preserv_L)
			QUERY:C277([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3))
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (($InspRtg_L+$Preserv_L)=0)
				
				RTCONTR_contractCount_L:=RTCONTR_contractCount_L+1
				RTCONTR_ProjFileNos_txt:=""
				RTCONTR_ConsltAddr_txt:=""
				RTCONTR_ConsltPhone_txt:=""
				RTCONTR_ConsltEmail_txt:=""
				RTCONTR_ConsltContact_txt:=""
				RTCONTR_ConsltName_txt:=""
				RTCONTR_ConsltNamePinfo_txt:=""
				RTCONTR_ProjMgr_txt:=""
				RTCONTR_ContractNo_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
				QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If (Records in selection:C76([Conslt_Name:127])>0)
					RTCONTR_ConsltNamePinfo_txt:=[Conslt_Name:127]ConsultantName_s:2
					QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[Conslt_Name:127]ConsultantNameID_l:1)
					If (Records in selection:C76([Conslt Address:77])>=1)
						FIRST RECORD:C50([Conslt Address:77])
						RTCONTR_ConsltAddr_txt:=[Conslt Address:77]Street1:8
						RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+[Conslt Address:77]Street2:9
						RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]City:10
						RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]State:11
						RTCONTR_ConsltAddr_txt:=RTCONTR_ConsltAddr_txt+","+[Conslt Address:77]Zip:12
						RTCONTR_ConsltPhone_txt:=[Conslt Address:77]PhoneNo1:13
						RTCONTR_ConsltEmail_txt:=[Conslt Address:77]Email:18
						RTCONTR_ConsltContact_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
					End if 
				End if 
				
				
				RTCONTR_AwardDate_D:=!00-00-00!
				If ([PRJ_DesignContracts:123]DC_EstComplete_d:11=!00-00-00!)
					RTCONTR_InitComplDate_D:=[PRJ_DesignContracts:123]DC_Completion_d:8
					RTCONTR_ExtenComplDate_D:=!00-00-00!
				Else 
					RTCONTR_InitComplDate_D:=[PRJ_DesignContracts:123]DC_EstComplete_d:11
					RTCONTR_ExtenComplDate_D:=[PRJ_DesignContracts:123]DC_Completion_d:8
				End if 
				
				ut_RetrieveAllBridgeContracts("STATUS")
				
				RTCONTR_ContrDesc_txt:=[PRJ_DesignContracts:123]DC_Description_txt:4
				RTCONTR_ProjMgrPinfo_txt:=[PRJ_DesignContracts:123]DC_ContractManager_s:13
				RTCONTR_FedAid_txt:=[PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15
				RTCONTR_TotFundEnc_r:=[PRJ_DesignContracts:123]DC_ESTContractAmt_r:10
				RTCONTR_TotFundApproxRem_r:=[PRJ_DesignContracts:123]DC_RemainingAmount_r:7
				RTCONTR_ContrTypePinfo_txt:=[PRJ_DesignContracts:123]DC_ContrTypeDesc_s:14
				
				QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
				ARRAY LONGINT:C221($PfileNos_aL; 0)
				SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]PF_FileID_l:3; $PfileNos_aL)
				QUERY WITH ARRAY:C644([PRJ_ProjectFile:117]PF_FileID_l:1; $PfileNos_aL)
				SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileNumber_l:3; $PfileNos_aL)
				RTCONTR_NumAssign_L:=0
				For ($i; 1; Size of array:C274($PfileNos_aL))
					If ($PfileNos_aL{$i}>0)
						If (Position:C15((","+String:C10($PfileNos_aL{$i})+","); RTCONTR_ProjFileNos_txt)<=0)
							RTCONTR_ProjFileNos_txt:=RTCONTR_ProjFileNos_txt+", "+String:C10($PfileNos_aL{$i})+","
							RTCONTR_NumAssign_L:=RTCONTR_NumAssign_L+1
						Else 
							
						End if 
						
					End if 
				End for 
				ut_RetrieveAllBridgeContracts("ADDTOARRAYS")
				
			End if 
			
		End for 
		
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		
	: ($Task_txt="ADDTOARRAYS")
		
		INSERT IN ARRAY:C227(RTCONTR_ContractNo_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltName_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltNamePinfo_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltAddr_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltPhone_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltEmail_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ConsltContact_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_AwardDate_aD; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_InitComplDate_aD; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ExtenComplDate_aD; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_Status_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ContrType_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ContrTypePinfo_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ContrDesc_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_FedAid_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ProjMgr_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ProjMgrPInfo_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_TotFundEnc_ar; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_TotFundApproxRem_ar; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_ProjNumbers_atxt; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_NumAssign_aL; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_NumInvoice_aL; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_NumInvoiceAcc_aL; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_TotAmtInvoice_ar; RTCONTR_contractCount_L)
		INSERT IN ARRAY:C227(RTCONTR_TotAmtPaid_ar; RTCONTR_contractCount_L)
		RTCONTR_ContrDesc_txt:=Replace string:C233(RTCONTR_ContrDesc_txt; <>sCR; " ")
		RTCONTR_ContrDesc_txt:=Replace string:C233(RTCONTR_ContrDesc_txt; <>sLF; " ")
		RTCONTR_ContrDesc_txt:=Replace string:C233(RTCONTR_ContrDesc_txt; <>sTab; " ")
		RTCONTR_ContractNo_atxt{RTCONTR_contractCount_L}:=RTCONTR_ContractNo_txt
		RTCONTR_ConsltName_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltName_txt
		RTCONTR_ConsltNamePinfo_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltNamePinfo_txt
		RTCONTR_ConsltAddr_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltAddr_txt
		RTCONTR_ConsltPhone_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltPhone_txt
		RTCONTR_ConsltEmail_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltEmail_txt
		RTCONTR_ConsltContact_atxt{RTCONTR_contractCount_L}:=RTCONTR_ConsltContact_txt
		RTCONTR_AwardDate_aD{RTCONTR_contractCount_L}:=RTCONTR_AwardDate_D
		RTCONTR_InitComplDate_aD{RTCONTR_contractCount_L}:=RTCONTR_InitComplDate_D
		RTCONTR_ExtenComplDate_aD{RTCONTR_contractCount_L}:=RTCONTR_ExtenComplDate_D
		RTCONTR_Status_atxt{RTCONTR_contractCount_L}:=RTCONTR_Status_txt
		RTCONTR_ContrType_atxt{RTCONTR_contractCount_L}:=RTCONTR_ContrType_txt
		RTCONTR_ContrTypePinfo_atxt{RTCONTR_contractCount_L}:=RTCONTR_ContrTypePinfo_txt
		RTCONTR_ContrDesc_atxt{RTCONTR_contractCount_L}:=RTCONTR_ContrDesc_txt
		RTCONTR_FedAid_atxt{RTCONTR_contractCount_L}:=RTCONTR_FedAid_txt
		RTCONTR_ProjMgr_atxt{RTCONTR_contractCount_L}:=RTCONTR_ProjMgr_txt
		RTCONTR_ProjMgrPInfo_atxt{RTCONTR_contractCount_L}:=RTCONTR_ProjMgrPInfo_txt
		RTCONTR_TotFundEnc_ar{RTCONTR_contractCount_L}:=RTCONTR_TotFundEnc_r
		RTCONTR_TotFundApproxRem_ar{RTCONTR_contractCount_L}:=RTCONTR_TotFundApproxRem_r
		RTCONTR_ProjFileNos_txt:=Replace string:C233(RTCONTR_ProjFileNos_txt; ",,"; ",")
		
		If (Substring:C12(RTCONTR_ProjFileNos_txt; 1; 1)=",")
			RTCONTR_ProjFileNos_txt:=Substring:C12(RTCONTR_ProjFileNos_txt; 2)
		End if 
		If (Length:C16(RTCONTR_ProjFileNos_txt)>1)
			If (Substring:C12(RTCONTR_ProjFileNos_txt; Length:C16(RTCONTR_ProjFileNos_txt))=",")
				RTCONTR_ProjFileNos_txt:=Substring:C12(RTCONTR_ProjFileNos_txt; 1; (Length:C16(RTCONTR_ProjFileNos_txt)-1))
			End if 
		End if 
		RTCONTR_ProjNumbers_atxt{RTCONTR_contractCount_L}:=RTCONTR_ProjFileNos_txt
		RTCONTR_NumAssign_aL{RTCONTR_contractCount_L}:=RTCONTR_NumAssign_L
		RTCONTR_NumInvoice_aL{RTCONTR_contractCount_L}:=RTCONTR_NumInvoice_L
		RTCONTR_NumInvoiceAcc_aL{RTCONTR_contractCount_L}:=RTCONTR_NumInvoiceAcc_L
		RTCONTR_TotAmtInvoice_ar{RTCONTR_contractCount_L}:=RTCONTR_TotAmtInvoice_r
		RTCONTR_TotAmtPaid_ar{RTCONTR_contractCount_L}:=RTCONTR_TotAmtPaid_r
		
	: ($Task_txt="GETPRJCONTRACTINFO")
		RTCONTR_ContrDesc_txt:=""
		RTCONTR_Status_txt:=""
		RTCONTR_ProjMgrPInfo_txt:=""
		RTCONTR_ContrTypePinfo_txt:=""
		RTCONTR_ConsltNamePinfo_txt:=""
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3=Num:C11(RTCONTR_ContractNo_txt))
		If (Records in selection:C76([PRJ_DesignContracts:123])=1)
			ut_RetrieveAllBridgeContracts("STATUS")
			RTCONTR_ContrDesc_txt:=[PRJ_DesignContracts:123]DC_Description_txt:4
			RTCONTR_ProjMgrPInfo_txt:=[PRJ_DesignContracts:123]DC_ContractManager_s:13
			RTCONTR_ContrTypePinfo_txt:=[PRJ_DesignContracts:123]DC_ContrTypeDesc_s:14
			ARRAY LONGINT:C221($PfileNos_aL; 0)
			
			QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
			SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]PF_FileID_l:3; $PfileNos_aL)
			
			QUERY WITH ARRAY:C644([PRJ_ProjectFile:117]PF_FileID_l:1; $PfileNos_aL)
			
			SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileNumber_l:3; $PfileNos_aL)
			For ($i; 1; Size of array:C274($PfileNos_aL))
				If ($PfileNos_aL{$i}>0)
					If (Position:C15((","+String:C10($PfileNos_aL{$i})+","); RTCONTR_ProjFileNos_txt)<=0)
						RTCONTR_ProjFileNos_txt:=RTCONTR_ProjFileNos_txt+", "+String:C10($PfileNos_aL{$i})+","
						RTCONTR_NumAssign_L:=RTCONTR_NumAssign_L+1
					Else 
						
					End if 
					
				End if 
			End for 
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
			If (Records in selection:C76([Conslt_Name:127])>0)
				RTCONTR_ConsltNamePinfo_txt:=[Conslt_Name:127]ConsultantName_s:2
			End if 
		End if 
		
	: ($Task_txt="STATUS")
		Case of 
			: ([PRJ_DesignContracts:123]DC_Completion_d:8>Current date:C33)
				RTCONTR_Status_txt:="ACTIVE"
			: (([PRJ_DesignContracts:123]DC_Completion_d:8=!00-00-00!) & ([PRJ_DesignContracts:123]DC_EstComplete_d:11=!00-00-00!))
				RTCONTR_Status_txt:="PENDING"
			Else 
				RTCONTR_Status_txt:="COMPLETE"
		End case 
		If ([PRJ_DesignContracts:123]DC_ContractStatus_s:16#RTCONTR_Status_txt)
			RTCONTR_Status_txt:=[PRJ_DesignContracts:123]DC_ContractStatus_s:16
		End if 
		
		
	: ($Task_txt="INIT")
		ARRAY TEXT:C222(RTCONTR_ContractNo_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltName_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltNamePinfo_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltAddr_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltPhone_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltEmail_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ConsltContact_atxt; 0)
		ARRAY DATE:C224(RTCONTR_AwardDate_aD; 0)
		ARRAY DATE:C224(RTCONTR_InitComplDate_aD; 0)
		ARRAY DATE:C224(RTCONTR_ExtenComplDate_aD; 0)
		ARRAY TEXT:C222(RTCONTR_Status_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ContrType_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ContrTypePinfo_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ContrDesc_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_FedAid_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ProjMgr_atxt; 0)
		ARRAY TEXT:C222(RTCONTR_ProjMgrPInfo_atxt; 0)
		ARRAY REAL:C219(RTCONTR_TotFundEnc_ar; 0)
		ARRAY REAL:C219(RTCONTR_TotFundApproxRem_ar; 0)
		ARRAY TEXT:C222(RTCONTR_ProjNumbers_atxt; 0)
		ARRAY LONGINT:C221(RTCONTR_NumAssign_aL; 0)
		ARRAY LONGINT:C221(RTCONTR_NumInvoice_aL; 0)
		ARRAY LONGINT:C221(RTCONTR_NumInvoiceAcc_aL; 0)
		ARRAY REAL:C219(RTCONTR_TotAmtInvoice_ar; 0)
		ARRAY REAL:C219(RTCONTR_TotAmtPaid_ar; 0)
		
		C_TEXT:C284(RTCONTR_ContractNo_txt; RTCONTR_ConsltName_txt; RTCONTR_ConsltNamePinfo_txt; RTCONTR_ConsltAddr_txt; RTCONTR_ConsltPhone_txt; RTCONTR_ConsltEmail_txt; RTCONTR_ConsltContact_txt)
		C_DATE:C307(RTCONTR_AwardDate_D; RTCONTR_InitComplDate_D; RTCONTR_ExtenComplDate_D)
		C_TEXT:C284(RTCONTR_Status_txt; RTCONTR_ContrType_txt; RTCONTR_FedAid_txt; RTCONTR_ProjMgr_txt; RTCONTR_ContrURL_txt; RTCONTR_ProjFileNos_txt)
		C_TEXT:C284(RTCONTR_ContrTypePinfo_txt; RTCONTR_ContrDesc_txt; RTCONTR_ProjMgrPInfo_txt)
		C_REAL:C285(RTCONTR_TotFundEnc_r; RTCONTR_TotFundApproxRem_r)
		C_LONGINT:C283(RTCONTR_NumAssign_L; RTCONTR_NumInvoice_L; RTCONTR_NumInvoiceAcc_L)
		C_REAL:C285(RTCONTR_TotAmtInvoice_r; RTCONTR_TotAmtPaid_r; RTCONTR_AssignmntScore_r)
		C_LONGINT:C283(RTCONTR_contractCount_L)
		RTCONTR_contractCount_L:=0
		RTCONTR_ContractNo_txt:=""
		RTCONTR_ConsltName_txt:=""
		RTCONTR_ConsltAddr_txt:=""
		RTCONTR_ConsltPhone_txt:=""
		RTCONTR_ConsltEmail_txt:=""
		RTCONTR_ConsltContact_txt:=""
		RTCONTR_AwardDate_D:=!00-00-00!
		RTCONTR_InitComplDate_D:=!00-00-00!
		RTCONTR_ExtenComplDate_D:=!00-00-00!
		RTCONTR_Status_txt:=""
		RTCONTR_ContrType_txt:=""
		RTCONTR_ContrTypePinfo_txt:=""
		RTCONTR_ContrDesc_txt:=""
		RTCONTR_FedAid_txt:=""
		RTCONTR_ProjMgr_txt:=""
		RTCONTR_ProjMgrPInfo_txt:=""
		RTCONTR_TotFundEnc_r:=0
		RTCONTR_TotFundApproxRem_r:=0
		RTCONTR_ProjFileNos_txt:=""
		RTCONTR_NumAssign_L:=0
		RTCONTR_NumInvoice_L:=0
		RTCONTR_NumInvoiceAcc_L:=0
		RTCONTR_TotAmtInvoice_r:=0
		RTCONTR_TotAmtPaid_r:=0
		
End case 