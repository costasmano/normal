//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/10, 09:32:46
	// ----------------------------------------------------
	// Method: DCM_UtilLoadXMLTemplate
	// Description
	//  ` Read an excel workbook in xml format and create the templates used for 
	//  ` generating the excel workbook reports from the district maintenance screens
	// 
	//  `param template names
	//"XML_DCMWorkBookHdr"
	//"XML_DCMWorkBookSTY"
	//"XML_DCMCONTRShtHDR"
	//"XML_DCMCONTRShtALs"
	//"XML_DCMCONTRShtBRLs"
	//"XML_DCMCONTRShtITLs"
	//"XML_DCMCONTRShtFTR"
	//"XML_DCMWOSheetHDR"
	//"XML_DCMWOBRGLIST"
	//"XML_DCMWOAttchList"
	//"XML_DCMWOBIDITEMS"
	//"XML_DCMWOSheetFTR"
	//"XML_DCMProjReport"
	//"XML_DCMWorkBookFTR"
	
	// Parameters
	// $0 : See below : depends on the task parameter
	// $1 : $Task_txt : Optional 
	// $2 : $Pointer
	// $3 : $Long
	// $4 : $long
	// $5 : $Text
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_TEXT:C284($Task_txt)
$Task_txt:=""
Case of 
	: (Count parameters:C259>0)
		C_TEXT:C284($1)
		$Task_txt:=$1
End case 

Case of 
	: ($Task_txt="ROWSTART")
		C_POINTER:C301($2)
		C_LONGINT:C283($3; $nextSect_L)
		C_LONGINT:C283($0)
		$nextSect_L:=$3
		C_LONGINT:C283($loop_L)
		For ($loop_L; $nextSect_L; 1; -1)
			If (Substring:C12($2->; $loop_L; 4)="<Row")
				$nextSect_L:=$loop_L-1
				$loop_L:=0
			End if 
			
		End for 
		$0:=$nextSect_L
		
	: ($Task_txt="ROWEND")
		C_POINTER:C301($2)
		C_LONGINT:C283($3; $nextSect_L)
		C_LONGINT:C283($0)
		$nextSect_L:=$3
		C_LONGINT:C283($loop_L)
		For ($loop_L; $nextSect_L; Length:C16($2->))
			If (Substring:C12($2->; $loop_L; 6)="</Row>")
				$nextSect_L:=$loop_L+6
				$loop_L:=Length:C16($2->)+1
			End if 
			
		End for 
		$0:=$nextSect_L
		
	: ($Task_txt="DOLOOP")
		C_POINTER:C301($2)
		C_LONGINT:C283($3; $LoopStart_L)
		C_LONGINT:C283($4; $LoopEnd_L)
		C_TEXT:C284($5)
		$LoopStart_L:=$3
		$LoopEnd_L:=$4
		C_TEXT:C284($part1_txt; $part2_txt; $part3_txt)
		$part1_txt:=Substring:C12($2->; 1; ($LoopStart_L-1))
		$part2_txt:=Substring:C12($2->; $LoopStart_L; ($LoopEnd_L-$LoopStart_L+1))
		$part3_txt:=Substring:C12($2->; $LoopEnd_L+1)
		
		$2->:=$part1_txt+"<!--4DLOOP "+$5+"-->"+$part2_txt+"<!--#4DENDLOOP-->"+$part3_txt
		$0:=$LoopStart_L
		
	: ($Task_txt="SAVEPARA")
		C_POINTER:C301($2)
		C_LONGINT:C283($3; $LoopStart_L)
		C_LONGINT:C283($4; $LoopEnd_L)
		C_TEXT:C284($5; $6)
		InitChangeStack(DCM_UTILStack)
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$5)
		If (Records in selection:C76([Parameters:107])=0)
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:=$5
			LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "PARAMETERS")
			[Parameters:107]Value:3:=$6
			PushChange(DCM_UTILStack; ->[Parameters:107]Value:3)
		Else 
		End if 
		[Parameters:107]Description:2:=$2->
		PushChange(DCM_UTILStack; ->[Parameters:107]Value:3)
		FlushGrpChgs(DCM_UTILStack; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
		
	: ($Task_txt="REPLACE")
		C_POINTER:C301($2)
		$2->:=Replace string:C233($2->; Char:C90(10); Char:C90(13))
		//Contract Shhet hdr
		
		$2->:=Replace string:C233($2->; "58805.0"; "<!--#4DVAR [DCM_Contracts]ContractNo-->")
		$2->:=Replace string:C233($2->; "58805"; "<!--#4DVAR [DCM_Contracts]ContractNo-->")
		$2->:=Replace string:C233($2->; "666666.0"; "<!--#4DVAR DCM_ProjFileNo_L-->")
		$2->:=Replace string:C233($2->; "666666"; "<!--#4DVAR DCM_ProjFileNo_L-->")
		$2->:=Replace string:C233($2->; "vContractor"; "<!--#4DVAR [DCM_Contracts]ConsultantName-->")
		$2->:=Replace string:C233($2->; "ContrDesc"; "<!--#4DVAR DCM_ContrDesc_txt-->")
		$2->:=Replace string:C233($2->; "2010-12-01T00:00:00.000"; "<!--#4DVAR ut_DateToExcel([DCM_Contracts]AwardContractDate)-->")
		$2->:=Replace string:C233($2->; "2011-12-01T00:00:00.000"; "<!--#4DVAR ut_DateToExcel([DCM_Contracts]InitialCompleteDate)-->")
		$2->:=Replace string:C233($2->; "500001.0"; "<!--#4DVAR [DCM_Contracts]InitContractTotal-->")
		$2->:=Replace string:C233($2->; "500002.0"; "<!--#4DVAR [DCM_Contracts]ApproxSpent-->")
		$2->:=Replace string:C233($2->; "500003.0"; "<!--#4DVAR [DCM_Contracts]ApproxRemainingFund-->")
		//Contract Shhet Work order list
		$2->:=Replace string:C233($2->; ">1.0</"; "><!--#4DVAR DCM_WONo_al{DCM_WONo_al}--></")
		$2->:=Replace string:C233($2->; ">500004.0</"; "><!--#4DVAR DCM_WOInitEst_ar{DCM_WONo_al}--></")
		$2->:=Replace string:C233($2->; ">500005.0</"; "><!--#4DVAR DCM_WOFinalCost_ar{DCM_WONo_al}--></")
		$2->:=Replace string:C233($2->; "CAdesc_a"; "<!--#4DVAR DCM_Assgn_Desc_atxt{DCM_WONo_al}-->")
		//Contract Bridge list
		$2->:=Replace string:C233($2->; ">2.0</"; "><!--#4DVAR DCM_CO_BR_WO_al{DCM_CO_BR_WO_al}--></")
		$2->:=Replace string:C233($2->; ">CBVarBIN</"; "><!--#4DVAR DCM_CO_BR_BIN_atxt{DCM_CO_BR_WO_al}--></")
		$2->:=Replace string:C233($2->; "CBVarBridgno"; "<!--#4DVAR DCM_CO_BR_Brno_atxt{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "CBVarProjTYpe"; "<!--#4DVAR DCM_CO_BR_Type_atxt{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "CBVarSD"; "<!--#4DVAR DCM_CO_BR_SD_atxt{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "CBVarTown"; "<!--#4DVAR DCM_CO_BR_Town_atxt{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "CBVarLocation"; "<!--#4DVAR DCM_CO_BR_Loc_atxt{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "500006.0"; "<!--#4DVAR DCM_CO_BR_WO_al{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "500007.0"; "<!--#4DVAR DCM_CO_BR_WO_al{DCM_CO_BR_WO_al}-->")
		$2->:=Replace string:C233($2->; "500008.0"; "<!--#4DVAR DCM_CO_BR_WO_al{DCM_CO_BR_WO_al}-->")
		//Contract Shhet Bid items
		$2->:=Replace string:C233($2->; "CVarItemNo"; "<!--#4DVAR ITMLB_ItemNos_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "CVarItemDEscription"; "<!--#4DVAR ITMLB_ItemDesc_atxt{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "CVarUnits"; "<!--#4DVAR ITMLB_ItemUnit_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "500009.0"; "<!--#4DVAR ITMLB_ItemPrice_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "200.0"; "<!--#4DVAR ITMLB_ItemQ_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "300.0"; "<!--#4DVAR ITMLB_ItemQCEst_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "400.0"; "<!--#4DVAR ITMLB_ItemQOEst_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "500.0"; "<!--#4DVAR ITMLB_ItemQEnt_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "5.000003E6"; "<!--#4DVAR DCM_ItemSum_r-->")
		$2->:=Replace string:C233($2->; "5.0E6"; "<!--#4DVAR DCM_CO_CEstSum_r-->")
		$2->:=Replace string:C233($2->; "5.000001E6"; "<!--#4DVAR DCM_CO_OEstSum_r-->")
		$2->:=Replace string:C233($2->; "5.000002E6"; "<!--#4DVAR DCM_ItemUsedSum_r-->")
		
		$2->:=Replace string:C233($2->; " currdate</"; " <!--#4DVAR Current Date(*)--></")
		//Work Order  Sht hdr
		$2->:=Replace string:C233($2->; "VarAssgnNo"; "<!--#4DVAR [DCM_WorkOrders]AssignNo-->")
		$2->:=Replace string:C233($2->; "varABPStat"; "<!--#4DVAR DCM_ABPSTatus_txt-->")
		$2->:=Replace string:C233($2->; "Wdesc"; "<!--#4DVAR [DCM_WorkOrders]Description-->")
		$2->:=Replace string:C233($2->; ">2.0E6</"; "><!--#4DVAR [DCM_WorkOrders]Est_ConstrSalary--></")
		$2->:=Replace string:C233($2->; ">3.0E6</"; "><!--#4DVAR [DCM_WorkOrders]Actual_salary--></")
		$2->:=Replace string:C233($2->; ">4.0E6</"; "><!--#4DVAR [DCM_WorkOrders]Actual_ConstrSalary--></")
		//Work Order  Bridge list
		$2->:=Replace string:C233($2->; "WVarBIN"; "<!--#4DVAR DCM_WO_BINS_atxt{DCM_WO_BINS_atxt}-->")
		$2->:=Replace string:C233($2->; "wVarBridgno"; "<!--#4DVAR DCM_WO_BDEPT_atxt{DCM_WO_BINS_atxt}-->")
		$2->:=Replace string:C233($2->; "wVarProjTYpe"; "<!--#4DVAR DCM_WO_PRJTYPE_atxt{DCM_WO_BINS_atxt}-->")
		$2->:=Replace string:C233($2->; "wVarSD"; "<!--#4DVAR f_Boolean2String(DCM_WO_SDR_ab{DCM_WO_BINS_atxt};"+<>sQu+"YN"+<>sQu+")-->")
		$2->:=Replace string:C233($2->; "wVarTown"; "<!--#4DVAR DCM_WO_Town_atxt{DCM_WO_BINS_atxt}-->")
		$2->:=Replace string:C233($2->; "wVarLocation"; "<!--#4DVAR DCM_WO_Location_atxt{DCM_WO_BINS_atxt}-->")
		//Work Order  Attahcment list
		$2->:=Replace string:C233($2->; "wvarAttachment"; "<!--#4DVAR DCM_AttachmentList_atxt{DCM_AttachmentList_atxt}-->")
		//Work Order  Bid Items
		$2->:=Replace string:C233($2->; "wVarItemNo"; "<!--#4DVAR ITMLB_ItemNos_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "WVarItemDEscription"; "<!--#4DVAR ITMLB_ItemDesc_atxt{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "WVarItemUnits"; "<!--#4DVAR ITMLB_ItemUnit_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "500010.0"; "<!--#4DVAR ITMLB_ItemPrice_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "201.0"; "<!--#4DVAR ITMLB_ItemQ_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "301.0"; "<!--#4DVAR DCM_WO_ItemQCEstimate_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "401.0"; "<!--#4DVAR DCM_WO_ItemQOEstimate_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "501.0"; "<!--#4DVAR DCM_WO_ItemQActual_ar{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "5.00001E6"; "<!--#4DVAR DCM_WO_CEstSum_r-->")
		$2->:=Replace string:C233($2->; "5.000011E6"; "<!--#4DVAR DCM_WO_OEstSum_r-->")
		$2->:=Replace string:C233($2->; "5.000012E6"; "<!--#4DVAR DCM_WO_ItemSum_r-->")
		//Bridge PRoj sheet
		$2->:=Replace string:C233($2->; "bbrno"; "<!--#4DVAR [DCM_Project]BridgeNo-->")
		$2->:=Replace string:C233($2->; "bbin"; "<!--#4DVAR [DCM_Project]BIN-->")
		$2->:=Replace string:C233($2->; ">3.0</"; "><!--#4DVAR [DCM_WorkOrders]AssignNo--></")
		$2->:=Replace string:C233($2->; "btwn"; "<!--#4DVAR vTown-->")
		$2->:=Replace string:C233($2->; "bloc"; "<!--#4DVAR vLocation-->")
		$2->:=Replace string:C233($2->; "b58"; "<!--#4DVAR DCM_BrgI58_s-->")
		$2->:=Replace string:C233($2->; "b59"; "<!--#4DVAR DCM_BrgI59_s-->")
		$2->:=Replace string:C233($2->; "b60"; "<!--#4DVAR DCM_BrgI60_s-->")
		$2->:=Replace string:C233($2->; "b61"; "<!--#4DVAR DCM_BrgI61_s-->")
		$2->:=Replace string:C233($2->; "b113"; "<!--#4DVAR DCM_BrgI113_s-->")
		$2->:=Replace string:C233($2->; ">99.9</"; "><!--#4DVAR DCM_BrgAASHTO_r--></")
		$2->:=Replace string:C233($2->; "bsdfo"; "<!--#4DVAR DCM_BrgSDFO_s-->")
		
		//Bridge PRoj sheet Ponits
		$2->:=Replace string:C233($2->; "belno"; "<!--#4DVAR DCM_CUUsedElNos_aL{DCM_CUUsedElNos_aL}-->")
		$2->:=Replace string:C233($2->; "beldesc"; "<!--#4DVAR DCM_CUUsedDesc_atxt{DCM_CUUsedElNos_aL}-->")
		$2->:=Replace string:C233($2->; "benv"; "<!--#4DVAR DCM_CUUsedEnv_ai{DCM_CUUsedElNos_aL}-->")
		$2->:=Replace string:C233($2->; "belunit"; "<!--#4DVAR DCM_CUUsedUnits_atxt{DCM_CUUsedElNos_aL}-->")
		$2->:=Replace string:C233($2->; ">3000.0</"; "><!--#4DVAR DCM_CUUsedQ_ar{DCM_CUUsedElNos_aL}--></")
		$2->:=Replace string:C233($2->; ">2000.0</"; "><!--#4DVAR DCM_CUUsedQ1_ar{DCM_CUUsedElNos_aL}--></")
		$2->:=Replace string:C233($2->; "belcomts"; "<!--#4DVAR DCM_CUUsedComments_atxt{DCM_CUUsedElNos_aL}-->")
		
		//Bridge PRoj Bid ITems
		$2->:=Replace string:C233($2->; "bItemno"; "<!--#4DVAR ITMLB_ItemNos_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "bItemDesc"; "<!--#4DVAR ITMLB_ItemDesc_atxt{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; "bItemunits"; "<!--#4DVAR ITMLB_ItemUnit_as{ITMLB_ItemNos_as}-->")
		$2->:=Replace string:C233($2->; ">5000.0</"; "><!--#4DVAR ITMLB_ItemPrice_ar{ITMLB_ItemNos_as}--></")
		$2->:=Replace string:C233($2->; ">202.0</"; "><!--#4DVAR ITMLB_ItemQ_ar{ITMLB_ItemNos_as}--></")
		$2->:=Replace string:C233($2->; ">302.0</"; "><!--#4DVAR DCM_P_ITMLB_ItemQCEST_ar{ITMLB_ItemNos_as}--></")
		$2->:=Replace string:C233($2->; ">402.0</"; "><!--#4DVAR DCM_P_ITMLB_ItemQOEST_ar{ITMLB_ItemNos_as}--></")
		$2->:=Replace string:C233($2->; ">502.0</"; "><!--#4DVAR DCM_P_ITMLB_ItemQEnt_ar{ITMLB_ItemNos_as}--></")
		$2->:=Replace string:C233($2->; ">5.00002E6</"; "><!--#4DVAR DCM_P_CEstItemSum_r--></")
		$2->:=Replace string:C233($2->; ">5.000021E6</"; "><!--#4DVAR DCM_P_OEstItemSum_r--></")
		$2->:=Replace string:C233($2->; ">5.000022E6</"; "><!--#4DVAR DCM_P_ItemSum_r--></")
		
		
	: ($Task_txt="")
		//Open
		C_TIME:C306($templ_t)
		$templ_t:=Open document:C264(""; ""; Read mode:K24:5)
		If (OK=1)
			READ WRITE:C146([Parameters:107])
			C_BLOB:C604($Templ_blb)
			C_TEXT:C284($Templ_txt)
			//  `load
			DOCUMENT TO BLOB:C525(Document; $Templ_blb)
			CLOSE DOCUMENT:C267($templ_t)
			
			If (BLOB size:C605($Templ_blb)>0)
				C_LONGINT:C283(DCM_UTILStack)
				If (DCM_UTILStack=0)
					DCM_UTILStack:=Size of array:C274(ptr_Changes)
					DCM_UTILStack:=DCM_UTILStack+1
				End if 
				
				$Templ_txt:=BLOB to text:C555($Templ_blb; Mac text without length:K22:10)
				C_LONGINT:C283($StyleS_L; $styleE_L)
				$StyleS_L:=Position:C15("<Styles>"; $Templ_txt)
				C_TEXT:C284($Styles_txt)
				$Styles_txt:=Substring:C12($Templ_txt; $StyleS_L)
				$Templ_txt:=$Styles_txt
				$styleE_L:=Position:C15("</Styles>"; $Styles_txt)
				$Styles_txt:=Substring:C12($Styles_txt; 1; ($styleE_L+Length:C16("</Styles>")))
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Styles_txt; 0; 0; "XML_DCMWorkBookSTY"; "Styles for DCM Workbook")
				C_LONGINT:C283($contrShtS_L)
				$contrShtS_L:=Position:C15("<Worksheet ss:Name"; $Templ_txt)
				C_TEXT:C284($Wksht_txt)
				$Templ_txt:=Substring:C12($Templ_txt; $contrShtS_L)
				DCM_UtilLoadXMLTemplate("REPLACE"; ->$Templ_txt)
				
				C_LONGINT:C283($nextSect_L; $LoopStart_L; $LoopEnd_L)
				$nextSect_L:=Position:C15(">Assignments</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMCONTRShtHDR"; "HDR for DCM Contr Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Bridge Projects</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{DCM_WONo_al}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "DCM_WONo_al")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMCONTRShtALs"; "AsgnList for DCM Contr Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Bid Items for Contract</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{DCM_CO_BR_WO_al}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "DCM_CO_BR_WO_al")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMCONTRShtBRLs"; "BrgList for DCM Contr Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Date of Report : "; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{ITMLB_ItemNos_as}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "ITMLB_ItemNos_as")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMCONTRShtITLs"; "BidItems for DCM Contr Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15("<Worksheet ss:Name"; $Templ_txt)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; ($nextSect_L-1))
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMCONTRShtFTR"; "FTR for DCM Contr Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; $nextSect_L)
				$nextSect_L:=Position:C15(">Bridge Projects</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMWOSheetHDR"; "HDR for DCM WO Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Attachment List</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{DCM_WO_BINS_atxt}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "DCM_WO_BINS_atxt")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMWOBRGLIST"; "Bridges for DCM WO Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Bid Items for Work Order</Data>"; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{DCM_AttachmentList_atxt}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "DCM_AttachmentList_atxt")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMWOAttchList"; "Attach for DCM WO Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15(">Date of Report : "; $Templ_txt)
				$nextSect_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Templ_txt; $nextSect_L)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; $nextSect_L)
				$LoopStart_L:=Position:C15("{ITMLB_ItemNos_as}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "ITMLB_ItemNos_as")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMWOBIDITEMS"; "BidItems for DCM WO Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; ($nextSect_L+1))
				$nextSect_L:=Position:C15("<Worksheet ss:Name"; $Templ_txt)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; ($nextSect_L-1))
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMWOSheetFTR"; "FTR for DCM WO Sheet")
				
				$Templ_txt:=Substring:C12($Templ_txt; $nextSect_L)
				$nextSect_L:=Position:C15("</Worksheet>"; $Templ_txt)
				$Wksht_txt:=Substring:C12($Templ_txt; 1; ($nextSect_L+Length:C16("</Worksheet>")))
				
				$LoopStart_L:=Position:C15("{DCM_CUUsedElNos_aL}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "DCM_CUUsedElNos_aL")
				$LoopStart_L:=Position:C15("{ITMLB_ItemNos_as}"; $Wksht_txt)
				$LoopEnd_L:=DCM_UtilLoadXMLTemplate("ROWEND"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("ROWSTART"; ->$Wksht_txt; $LoopStart_L)
				$LoopStart_L:=DCM_UtilLoadXMLTemplate("DOLOOP"; ->$Wksht_txt; $LoopStart_L; $LoopEnd_L; "ITMLB_ItemNos_as")
				
				DCM_UtilLoadXMLTemplate("SAVEPARA"; ->$Wksht_txt; 0; 0; "XML_DCMProjReport"; "Distr Contr Maint Project Report")
				
			End if 
			
		End if 
End case 