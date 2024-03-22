//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/14/10, 13:35:01
	// ----------------------------------------------------
	// Method: QR_GetConstrContrInfo
	// Description
	//   ` Retrieve the Constr Contr info related to the current BIN based on bid award dates
	// 
	// Parameters
	// $0 : $RelatedPRJINFO
	// $1 : $BIN (Optional)
	// $2 : $Min_BIDOP_d (Optional) When specifyin this pass either blank str for $1 or a BIN
	// $2 : $Max_BIDOP_d (Optional)
	// ----------------------------------------------------
	
	Mods_2010_05
	
End if 
C_TEXT:C284($0)
C_TEXT:C284($1; $BIN)  // Command Replaced was o_C_STRING length was 3
If (Count parameters:C259>0)
	$BIN:=$1
	If ($BIN="")
		$BIN:=[Bridge MHD NBIS:1]BIN:3
	End if 
Else 
	$BIN:=[Bridge MHD NBIS:1]BIN:3
End if 
C_DATE:C307($Min_BIDOP_d; $Max_BIDOP_d)
If (Count parameters:C259>1)
	C_DATE:C307($2)
	$Min_BIDOP_d:=$2
Else 
	$Min_BIDOP_d:=Date:C102("1/1/2000")
End if 
$Max_BIDOP_d:=!00-00-00!
If (Count parameters:C259>2)
	C_DATE:C307($3)
	If ($3>$Min_BIDOP_d)
		//ignore it if it is less than the min date
		$Max_BIDOP_d:=$3
	End if 
End if 
$0:=""

UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
UNLOAD RECORD:C212([PRJ_DesignContracts:123])
UNLOAD RECORD:C212([PRJ_ProjectFile:117])
UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
UNLOAD RECORD:C212([Conslt_Name:127])
UNLOAD RECORD:C212([PRJ_DesignContracts:123])
UNLOAD RECORD:C212([PRJ_Contractor:114])
READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
READ ONLY:C145([PRJ_ProjectDetails:115])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_ConstructionProject:116])
READ ONLY:C145([Conslt_Name:127])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_Contractor:114])

SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
C_BOOLEAN:C305($one_b; $Many_B)
GET AUTOMATIC RELATIONS:C899($one_b; $Many_B)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=$BIN)
RELATE ONE SELECTION:C349([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetails:115])
COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "MYBINPROJDETAILS")
RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
COPY NAMED SELECTION:C331([PRJ_ProjectFile:117]; "MYBINPROJFILES")
RELATE ONE SELECTION:C349([PRJ_ProjectFile:117]; [PRJ_ConstructionProject:116])
QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4>=$Min_BIDOP_d)
If ($Max_BIDOP_d>!00-00-00!)
	QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4<=$Max_BIDOP_d)
End if 
ORDER BY:C49([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_BidOpening_d:3; <)
If (Records in selection:C76([PRJ_ConstructionProject:116])>0)
	FIRST RECORD:C50([PRJ_ConstructionProject:116])
	USE NAMED SELECTION:C332("MYBINPROJFILES")
	CLEAR NAMED SELECTION:C333("MYBINPROJFILES")
	//get back the matching project file
	QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
	USE NAMED SELECTION:C332("MYBINPROJDETAILS")
	CLEAR NAMED SELECTION:C333("MYBINPROJDETAILS")
	//get back the matching bridge specific project
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
	//find contractor
	QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=[PRJ_ConstructionProject:116]CTR_ContractorID_l:2)
	//find designer```
	If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
		
	Else 
		QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
		C_LONGINT:C283($ConsultantIDToUse_l)
		Case of 
			: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
				If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
					QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				Else 
					PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=$ConsultantIDToUse_l)
				End if 
				
			: (Records in selection:C76([PRJ_DCPFJoin:135])<2)
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2)
				PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
				QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=$ConsultantIDToUse_l)
			Else 
				
				PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
				QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=$ConsultantIDToUse_l)
		End case 
		
	End if 
	
Else 
	UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
	UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
	UNLOAD RECORD:C212([PRJ_DesignContracts:123])
	UNLOAD RECORD:C212([PRJ_ProjectFile:117])
	UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
	UNLOAD RECORD:C212([Conslt_Name:127])
	UNLOAD RECORD:C212([PRJ_DesignContracts:123])
	UNLOAD RECORD:C212([PRJ_Contractor:114])
	
End if 
SET AUTOMATIC RELATIONS:C310($one_b; $Many_B)
$0:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5