//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/15/07, 11:35:43
	// ----------------------------------------------------
	// Method: QR_GetProjInfoNo
	// Description
	// Retrieve the ProjectInfo number related to the current BIN
	// 
	// Parameters
	// $0 : $RelatedPRJINFO
	// $1 : $BIN (Optional)
	// $2 : $Min_date_d (Optional) When specifyin this pass either blank str for $1 or a BIN
	// $3 : $Max_date_d (Optional) 
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/11/10 09:13:54)
	Mods_2010_05
	//  `Added a sort by sched ad date descending and a filter of ad dates > 1950
	//  `Also optional 2nd param to specify the min ad date
	// Modified by: costasmanousakis-(Designer)-(8/25/10 09:38:34)
	Mods_2010_08
	//  `Added reducing the selection of tables to 0
End if 
C_LONGINT:C283($0)
C_TEXT:C284($1; $BIN)  // Command Replaced was o_C_STRING length was 3
If (Count parameters:C259>0)
	$BIN:=$1
	If ($BIN="")
		$BIN:=[Bridge MHD NBIS:1]BIN:3
	End if 
Else 
	$BIN:=[Bridge MHD NBIS:1]BIN:3
End if 
C_DATE:C307($Min_date_d; $Max_date_d)
If (Count parameters:C259>1)
	C_DATE:C307($2)
	$Min_date_d:=$2
Else 
	$Min_date_d:=Date:C102("1/1/1950")
End if 
$Max_date_d:=!00-00-00!
If (Count parameters:C259>2)
	C_DATE:C307($3)
	
	If ($3>$Min_date_d)  //only use it if it is bigger than the min
		$Max_date_d:=$3
	End if 
End if 
//Make sure all records are unloaded and read only
UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
UNLOAD RECORD:C212([PRJ_DesignContracts:123])
UNLOAD RECORD:C212([PRJ_ProjectFile:117])
UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
UNLOAD RECORD:C212([Conslt_Name:127])
UNLOAD RECORD:C212([PRJ_DesignContracts:123])
UNLOAD RECORD:C212([PRJ_Contractor:114])
REDUCE SELECTION:C351([PRJ_ProjectDetailsIncludedBINS:122]; 0)
REDUCE SELECTION:C351([PRJ_ProjectDetails:115]; 0)
REDUCE SELECTION:C351([PRJ_DesignContracts:123]; 0)
REDUCE SELECTION:C351([PRJ_ProjectFile:117]; 0)
REDUCE SELECTION:C351([PRJ_ConstructionProject:116]; 0)
REDUCE SELECTION:C351([Conslt_Name:127]; 0)
REDUCE SELECTION:C351([PRJ_DesignContracts:123]; 0)
REDUCE SELECTION:C351([PRJ_Contractor:114]; 0)

READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
READ ONLY:C145([PRJ_ProjectDetails:115])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_ConstructionProject:116])
READ ONLY:C145([Conslt_Name:127])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_Contractor:114])

SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=$BIN)
RELATE ONE SELECTION:C349([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetails:115])
COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "MYBINPROJDETAILS")
RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5>=$Min_date_d)
If (($Max_date_d>!00-00-00!) & ($Max_date_d>$Min_date_d))
	QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5<=$Max_date_d)
End if 
ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; <)
If (Records in selection:C76([PRJ_ProjectFile:117])>0)
	FIRST RECORD:C50([PRJ_ProjectFile:117])
	//find now related [PRJ_ProjectDetails] record
	USE NAMED SELECTION:C332("MYBINPROJDETAILS")
	CLEAR NAMED SELECTION:C333("MYBINPROJDETAILS")
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
	FIRST RECORD:C50([PRJ_ProjectDetails:115])
	//now find Designer record
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
	
	//now find Constr Contract
	QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]PF_FileID_l:11=[PRJ_ProjectFile:117]PF_FileID_l:1)
	//get the last opened
	ORDER BY:C49([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_BidOpening_d:3; <)
	
	If (Records in selection:C76([PRJ_ConstructionProject:116])>0)
		FIRST RECORD:C50([PRJ_ConstructionProject:116])
		QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=[PRJ_ConstructionProject:116]CTR_ContractorID_l:2)
		
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

$0:=[PRJ_ProjectFile:117]PF_FileNumber_l:3