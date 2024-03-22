//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/04/07, 13:55:08
	// ----------------------------------------------------
	// Method: PRJ_LTR_ConsAddr
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	//Mods_2007_CM12_5301
	Mods_2009_05  //r001  `05/07/09, 12:03:09  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 13:47:35   `Merge PRJ Design Contract Changes
End if 
C_TEXT:C284(vCompanyName; vcontactName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vcontact)  // Command Replaced was o_C_STRING length was 150
C_TEXT:C284(vprefix)  // Command Replaced was o_C_STRING length was 50
Case of 
		
	: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53>0)
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
		If (Records in selection:C76([Conslt Address:77])=0)
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
			vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
		Else 
			vCompanyName:=[Conslt Address:77]ConsltName:2
		End if 
	: ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54>0)
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		If (Records in selection:C76([Conslt Address:77])=0)
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
			vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
		Else 
			vCompanyName:=[Conslt Address:77]ConsltName:2
		End if 
		
	Else 
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		If (Records in selection:C76([Conslt Address:77])=0)
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
			vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
		Else 
			vCompanyName:=[Conslt Address:77]ConsltName:2
		End if 
		
End case 

GetConsltAddress1(vCompanyName; "DESIGN")

vcontact:=vprefix+" "+vcontactName
vcontact:="Attn:"+<>sTab+vcontact