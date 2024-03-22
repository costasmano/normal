//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/07/14, 21:42:48
//----------------------------------------------------
//Method: clone_ReturnKeyFldandVariable
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283($1; $TableNumber_l; $Loop_l; $Length_l; $Type_l)

$TableNumber_l:=$1
C_TEXT:C284($VariableExtension_txt)
C_POINTER:C301($2; $3; $Field_ptr)
$2->:=0
$3->:=""
C_BOOLEAN:C305($Reindex_b; $GetKey_b)
$Reindex_b:=False:C215
If (Count parameters:C259=4)
	C_BOOLEAN:C305($4)
	$Reindex_b:=$4
End if 

$GetKey_b:=False:C215
Case of 
	: ($TableNumber_l=1)  //Bridge MHD NBIS"
		$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]BIN:3)
	: ($TableNumber_l=2)  //Town Data
		$Loop_l:=Field:C253(->[Town Data:2]BDEPT Prefix:2)
	: ($TableNumber_l=3)  //NBIS Secondary
		$Loop_l:=Field:C253(->[NBIS Secondary:3]NBISSecondaryKey_l:39)
	: ($TableNumber_l=27)  //Inspections
		$Loop_l:=Field:C253(->[Inspections:27]InspID:2)
	: ($TableNumber_l=28)  //Sequences
		$Loop_l:=Field:C253(->[Sequences:28]Name:1)
	: ($TableNumber_l=29)  //ElementsSafety
		$Loop_l:=Field:C253(->[ElementsSafety:29]ElmSafetyID:7)
	: ($TableNumber_l=30)  //ElementDict
		$Loop_l:=Field:C253(->[ElementDict:30]ElementNo:1)
	: ($TableNumber_l=31)  //Inspection Type
		$Loop_l:=Field:C253(->[Inspection Type:31]Code:1)
	: ($TableNumber_l=32)  //Element Cat
		$Loop_l:=Field:C253(->[Element Cat:32]Code:1)
	: ($TableNumber_l=36)  //Standard Photos
		$Loop_l:=Field:C253(->[Standard Photos:36]StdPhotoID:7)
	: ($TableNumber_l=42)  //Personnel
		$Loop_l:=Field:C253(->[Personnel:42]Person ID:1)
	: ($TableNumber_l=37)  //RAILBridgeInfo
		$Loop_l:=Field:C253(->[RAILBridgeInfo:37]BIN:1)
	: ($TableNumber_l=41)  //Pontis_Metrics
		$Loop_l:=Field:C253(->[Pontis_Metrics:41]PM_UniqueKey_s:2)
	: ($TableNumber_l=44)  //BMS Inspections
		$Loop_l:=Field:C253(->[BMS Inspections:44]Inspection ID:1)
	: ($TableNumber_l=45)  //Cond Units
		$Loop_l:=Field:C253(->[Cond Units:45]Cond Unit ID:1)
		$Loop_l:=Field:C253(->[Pontis_Metrics:41]PM_UniqueKey_s:2)
	: ($TableNumber_l=47)  //BMS Elements
		$Loop_l:=Field:C253(->[BMS Elements:47]Element ID:1)
	: ($TableNumber_l=48)  //Environments
		$Loop_l:=Field:C253(->[Environments:48]Envir No:1)
	: ($TableNumber_l=49)  //BMS Categories
		$Loop_l:=Field:C253(->[BMS Categories:49]Category ID:1)
	: ($TableNumber_l=51)  //Cond States
		$Loop_l:=Field:C253(->[Cond States:51]Cond State ID:1)
	: ($TableNumber_l=53)  //CS Notes
		$Loop_l:=Field:C253(->[CS Notes:53]CS Note ID:1)
	: ($TableNumber_l=54)  //Common Notes
		$Loop_l:=Field:C253(->[Common Notes:54]Common Note ID:1)
	: ($TableNumber_l=59)  //Activity Log
		$Loop_l:=Field:C253(->[Activity Log:59]RefID:28)
	: ($TableNumber_l=63)  //Conslt Rating
		$Loop_l:=Field:C253(->[Conslt Rating:63]ConsltRatingID:42)
	: ($TableNumber_l=64)  //Cons Inspection
		$Loop_l:=Field:C253(->[Cons Inspection:64]ConsInspectionID:32)
	: ($TableNumber_l=65)  //RatingReports
		$Loop_l:=Field:C253(->[RatingReports:65]RatingID:21)
	: ($TableNumber_l=73)  //TownLineInfo
		$Loop_l:=Field:C253(->[TownLineInfo:73]RefID:3)
	: ($TableNumber_l=75)  //Bridge Design
		$Loop_l:=Field:C253(->[Bridge Design:75]BridgeDesignID:35)
	: ($TableNumber_l=77)  //Conslt Address
		$Loop_l:=Field:C253(->[Conslt Address:77]ConsltAddressID:1)
	: ($TableNumber_l=78)  //Town Address
		$Loop_l:=Field:C253(->[Town Address:78]TownAddressID:1)
	: ($TableNumber_l=79)  //Contracts
		$Loop_l:=Field:C253(->[Contracts:79]ContractID:29)
	: ($TableNumber_l=80)  //Contract FundTransfer
		$Loop_l:=Field:C253(->[Contract FundTransfer:80]TOF_ID:2)
	: ($TableNumber_l=81)  //Contract ExtendTime
		$Loop_l:=Field:C253(->[Contract ExtendTime:81]EOT_ID:2)
	: ($TableNumber_l=82)  //Contract AddFund
		$Loop_l:=Field:C253(->[Contract AddFund:82]AddFund_ID:2)
	: ($TableNumber_l=83)  //Contract Assignments
		$Loop_l:=Field:C253(->[Contract Assignments:83]AssignID:3)
	: ($TableNumber_l=84)  //Contract Invoice
		$Loop_l:=Field:C253(->[Contract Invoice:84]InvoiceID:1)
	: ($TableNumber_l=86)  //Templates
		$Loop_l:=Field:C253(->[Templates:86]TemplateID:1)
	: ($TableNumber_l=90)  //Combined Inspections
		$Loop_l:=Field:C253(->[Combined Inspections:90]ID:6)
	: ($TableNumber_l=94)  //Invoice_AssignNo_Maintenance
		$Loop_l:=Field:C253(->[Invoice_AssignNo_Maintenance:94]ID:6)
	: ($TableNumber_l=95)  //Invoice_Maintenance
		$Loop_l:=Field:C253(->[Invoice_Maintenance:95]InvoiceID:1)
	: ($TableNumber_l=96)  //FundTransfer_Maintenance
		$Loop_l:=Field:C253(->[FundTransfer_Maintenance:96]TOF_ID:2)
	: ($TableNumber_l=97)  //Contract_Maintenance
		$Loop_l:=Field:C253(->[Contract_Maintenance:97]ContractID:2)
	: ($TableNumber_l=98)  //ExtendTime_Maintenance
		$Loop_l:=Field:C253(->[ExtendTime_Maintenance:98]EOT_ID:2)
	: ($TableNumber_l=99)  //AddFund_Maintenance
		$Loop_l:=Field:C253(->[AddFund_Maintenance:99]AddFund_ID:2)
	: ($TableNumber_l=100)  //Contract_Project_Maintenance
		$Loop_l:=Field:C253(->[Contract_Project_Maintenance:100]ProjectID:1)
	: ($TableNumber_l=101)  //Contract_Assignment_Maintenance
		$Loop_l:=Field:C253(->[Contract_Assignment_Maintenance:101]AssignID:3)
	: ($TableNumber_l=102)  //Addendum_Maintenance
		$Loop_l:=Field:C253(->[Addendum_Maintenance:102]AddendumID:1)
	: ($TableNumber_l=103)  //Work_Estimate
		$Loop_l:=Field:C253(->[Work_Estimate:103]WKID:1)
	: ($TableNumber_l=104)  //WorkHour_Config
		$Loop_l:=Field:C253(->[WorkHour_Config:104]AssignType:2)
	: ($TableNumber_l=106)  //zSpecialReports
		$Loop_l:=Field:C253(->[zSpecialReports:106]Record_ID:7)
	: ($TableNumber_l=107)  //Parameters
		$Loop_l:=Field:C253(->[Parameters:107]ParamCode:1)
	: ($TableNumber_l=108)  //ScourPriorityRank
		$Loop_l:=Field:C253(->[ScourPriorityRank:108]BIN:1)
	: ($TableNumber_l=109)  //PERS_Groups
		$Loop_l:=Field:C253(->[PERS_Groups:109]PERS_GroupID_I:1)
	: ($TableNumber_l=111)  //CM_ExtTimeFYAlloc
		$Loop_l:=Field:C253(->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)
	: ($TableNumber_l=112)  //InventoryPhotoInsp
		$Loop_l:=Field:C253(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
	: ($TableNumber_l=113)  //InventoryPhotos
		$Loop_l:=Field:C253(->[InventoryPhotos:113]InvPhoto_ID:1)
	: ($TableNumber_l=114)  //PRJ_Contractor
		$Loop_l:=Field:C253(->[PRJ_Contractor:114]CTR_ContractorID_l:1)
	: ($TableNumber_l=115)  //PRJ_ProjectDetails
		$Loop_l:=Field:C253(->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	: ($TableNumber_l=116)  //PRJ_ConstructionProject
		$Loop_l:=Field:C253(->[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
	: ($TableNumber_l=117)  //PRJ_ProjectFile
		$Loop_l:=Field:C253(->[PRJ_ProjectFile:117]PF_FileID_l:1)
	: ($TableNumber_l=123)  //PRJ_DesignContracts
		$Loop_l:=Field:C253(->[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
	: ($TableNumber_l=124)  //PRJ_ProjectTimeTracking
		$Loop_l:=Field:C253(->[PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1)
	: ($TableNumber_l=125)  //TableOfLists
		$Loop_l:=Field:C253(->[TableOfLists:125]ListKeyID_L:4)
	: ($TableNumber_l=127)  //Conslt_Name
		$Loop_l:=Field:C253(->[Conslt_Name:127]ConsultantNameID_l:1)
	: ($TableNumber_l=130)  //PRJ_Attributes
		$Loop_l:=Field:C253(->[PRJ_Attributes:130]ATTR_ID_l:1)
	: ($TableNumber_l=132)  //ScourPOA
		$Loop_l:=Field:C253(->[ScourPOA:132]ScourPOAID:1)
	: ($TableNumber_l=133)  //ScourPOA_DetourBridge
		$Loop_l:=Field:C253(->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1)
	: ($TableNumber_l=134)  //ScourPOA_Images
		$Loop_l:=Field:C253(->[ScourPOA_Images:134]ScourPOAImgID:1)
	: ($TableNumber_l=136)  //DCM_Contracts
		$Loop_l:=Field:C253(->[DCM_Contracts:136]ContractID:2)
	: ($TableNumber_l=137)  //DCM_WorkOrders
		$Loop_l:=Field:C253(->[DCM_WorkOrders:137]AssignID:3)
	: ($TableNumber_l=138)  //DCM_Project
		$Loop_l:=Field:C253(->[DCM_Project:138]ProjectID:1)
	: ($TableNumber_l=143)  //DCM_ProjDailys
		$Loop_l:=Field:C253(->[DCM_ProjDailys:143]DailyID_L:2)
	: ($TableNumber_l=144)  //DCM_ProjDailyItems
		$Loop_l:=Field:C253(->[DCM_ProjDailyItems:144]DailyItemID_L:2)
	: ($TableNumber_l=145)  //Preservation_Reviews
		$Loop_l:=Field:C253(->[Preservation_Reviews:145]Review_ID:1)
	: ($TableNumber_l=147)  //LB_QueryTable
		$Loop_l:=Field:C253(->[LB_QueryTable:147]UniqueKey_l:6)
	: ($TableNumber_l=148)  //Preservation_Meetings
		$Loop_l:=Field:C253(->[Preservation_Meetings:148]MeetingID_L:1)
	: ($TableNumber_l=150)  //ScourCriticalInfo
		$Loop_l:=Field:C253(->[ScourCriticalInfo:150]BIN:1)
	: ($TableNumber_l=151)  //TunnelInfo
		$Loop_l:=Field:C253(->[TunnelInfo:151]BIN:1)
	: ($TableNumber_l=152)  //TunnelInspection
		$Loop_l:=Field:C253(->[TunnelInspection:152]TunnelInspID_L:15)
	: ($TableNumber_l=154)  //RatingRequests
		$Loop_l:=Field:C253(->[RatingRequests:154]RatingRequestID_L:2)
	: ($TableNumber_l=155)  //AddtlRatingRequests
		$Loop_l:=Field:C253(->[AddtlRatingRequests:155]AddtlRequestID_L:2)
	: ($TableNumber_l=156)  //BridgeRankCalc
		$Loop_l:=Field:C253(->[BridgeRankCalc:156]RunID_L:1)
	: ($TableNumber_l=157)  //BridgeRankResult
		$Loop_l:=Field:C253(->[BridgeRankResult:157]UniqueKey_s:2)
	: ($TableNumber_l=158)  //ElmtRatingLoads
		$Loop_l:=Field:C253(->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
	: ($TableNumber_l=159)  //LSS_Accessibility
		$Loop_l:=Field:C253(->[LSS_Accessibility:159]LSS_AccessibilityId_s:1)
	: ($TableNumber_l=160)  //LSS_AccessibilityElement
		$Loop_l:=Field:C253(->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1)
	: ($TableNumber_l=161)  //LSS_DMeter
		$Loop_l:=Field:C253(->[LSS_DMeter:161]LSS_DMeterId_s:1)
	: ($TableNumber_l=162)  //LSS_Element
		$Loop_l:=Field:C253(->[LSS_Element:162]LSS_ElementId_L:1)
	: ($TableNumber_l=163)  //LSS_ElementInspection
		$Loop_l:=Field:C253(->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1)
	: ($TableNumber_l=164)  //LSS_Inspection
		$Loop_l:=Field:C253(->[LSS_Inspection:164]LSS_InspectionId_s:1)
	: ($TableNumber_l=165)  //LSS_Inventory
		$Loop_l:=Field:C253(->[LSS_Inventory:165]LSS_InventoryId_s:1)
	: ($TableNumber_l=166)  //LSS_Photos
		$Loop_l:=Field:C253(->[LSS_Photos:166]LSS_PhotoId_s:1)
	: ($TableNumber_l=167)  //LSS_refInspectionType
		$Loop_l:=Field:C253(->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1)
	: ($TableNumber_l=168)  //LSS_refRouteDirection
		$Loop_l:=Field:C253(->[LSS_refRouteDirection:168]LSS_RouteDirectionId_s:1)
	: ($TableNumber_l=169)  //LSS_refStructureCoating
		$Loop_l:=Field:C253(->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1)
	: ($TableNumber_l=170)  //LSS_refStructureMaterial
		$Loop_l:=Field:C253(->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1)
	: ($TableNumber_l=171)  //LSS_refStructureTypes
		$Loop_l:=Field:C253(->[LSS_refStructureTypes:171]LSS_StructureTypeId_s:1)
	: ($TableNumber_l=172)  //LSS_SignPanel
		$Loop_l:=Field:C253(->[LSS_SignPanel:172]LSS_SignPanelId_s:1)
	: ($TableNumber_l=174)  //LSS_TowerDistance
	: ($TableNumber_l=175)  //LSS_UT
		$Loop_l:=Field:C253(->[LSS_UT:175]LSS_UTId_s:1)
	: ($TableNumber_l=176)  //LSS_UtResult
		$Loop_l:=Field:C253(->[LSS_UtResult:176]LSS_UTResultId_s:1)
	: ($TableNumber_l=177)  //LSS_VerticalClearance
		$Loop_l:=Field:C253(->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1)
	: ($TableNumber_l=178)  //PON_ELEM_DEFS
		$Loop_l:=Field:C253(->[PON_ELEM_DEFS:178]ELEM_KEY:1)
	: ($TableNumber_l=179)  //PON_ELEM_INSP
		$Loop_l:=Field:C253(->[PON_ELEM_INSP:179]ELEMID:22)
	: ($TableNumber_l=180)  //PON_ELEM_COSTS
		$Loop_l:=Field:C253(->[PON_ELEM_COSTS:180]COSTID_L:5)
	: ($TableNumber_l=181)  //NTI_TunnelInfo
		$Loop_l:=Field:C253(->[NTI_TunnelInfo:181]NTI_i1_s:6)
	: ($TableNumber_l=182)  //NTI_ELEM_DEFS
		$Loop_l:=Field:C253(->[NTI_ELEM_DEFS:182]ELEM_KEY:4)
	: ($TableNumber_l=183)  //NTI_ELEM_BIN_INSP
		$Loop_l:=Field:C253(->[NTI_ELEM_BIN_INSP:183]ELEMID:2)
	: ($TableNumber_l=184)  //TIN_Inspections
		$Loop_l:=Field:C253(->[TIN_Inspections:184]InspectionID:2)
	: ($TableNumber_l=185)  //NTI_ELEM_TIN_INSP
		$Loop_l:=Field:C253(->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
	: ($TableNumber_l=186)  //TIN_Insp_Images
		$Loop_l:=Field:C253(->[TIN_Insp_Images:186]ImageID:2)
		
	Else 
		$GetKey_b:=True:C214
End case 


C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)

If (Not:C34($GetKey_b))
	GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
	$2->:=$Loop_l
	Case of 
		: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
			$VariableExtension_txt:="_txt"
		: ($Type_l=Is real:K8:4)
			$VariableExtension_txt:="_r"
		: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
			$VariableExtension_txt:="_l"
		: ($Type_l=Is date:K8:7)
			$VariableExtension_txt:="_d"
		: ($Type_l=Is time:K8:8)
			$VariableExtension_txt:="_tm"
		: ($Type_l=Is boolean:K8:9)
			$VariableExtension_txt:="_b"
		: ($Type_l=Is picture:K8:10)
			$VariableExtension_txt:="_p"
		: ($Type_l=Is BLOB:K8:12)
			$VariableExtension_txt:="_blb"
		Else 
			$VariableExtension_txt:=""
	End case 
	
	If ($Type_l#7)  //type 7 is subtable we are not using any data from them
		$3->:="v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt
	End if 
	C_LONGINT:C283($IndexLoop_L)
	
	
Else 
	
	For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
			If ($Unique_b)
				
				Case of 
					: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
						$VariableExtension_txt:="_txt"
					: ($Type_l=Is real:K8:4)
						$VariableExtension_txt:="_r"
					: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
						$VariableExtension_txt:="_l"
					: ($Type_l=Is date:K8:7)
						$VariableExtension_txt:="_d"
					: ($Type_l=Is time:K8:8)
						$VariableExtension_txt:="_tm"
					: ($Type_l=Is boolean:K8:9)
						$VariableExtension_txt:="_b"
					: ($Type_l=Is picture:K8:10)
						$VariableExtension_txt:="_p"
					: ($Type_l=Is BLOB:K8:12)
						$VariableExtension_txt:="_blb"
					Else 
						$VariableExtension_txt:=""
				End case 
				If ($VariableExtension_txt="_txt")
					C_TEXT:C284($ConstraintID_txt)
					C_LONGINT:C283($Primary_key_field_id_L)
					
					Begin SQL
						
						SELECT CONSTRAINT_ID
						FROM _USER_CONSTRAINTS
						WHERE TABLE_ID = :$TableNumber_l AND CONSTRAINT_TYPE = 'P'
						INTO :$ConstraintID_txt;
						
						SELECT COLUMN_ID
						FROM _USER_CONS_COLUMNS
						WHERE CONSTRAINT_ID = :$ConstraintID_txt
						INTO :$Primary_key_field_id_L;
					End SQL
					If ($Primary_key_field_id_L=$Loop_l)
						If (clone_IncludeUUIDS_B)
							$2->:=$Loop_l
						End if 
					Else 
						$2->:=$Loop_l
					End if 
				Else 
					$2->:=$Loop_l
				End if 
				
				If ($Type_l#7)  //type 7 is subtable we are not using any data from them
					$3->:="v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt
				End if 
				//$Loop_l:=Get last field number($TableNumber_l)+1
				
				
			End if 
		End if 
	End for 
End if 
//End clone_ReturnKeyFldandVariable

