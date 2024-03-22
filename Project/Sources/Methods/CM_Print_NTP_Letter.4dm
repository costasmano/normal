//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintNTP_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/13/2006 15:06:07)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:17)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(3/29/2007 16:34:25)
	Mods_2007_CM07
	Mods_2010_02
	//Modified by: Kenny Yang-(Designer) `02/23/10, 11:20:29 
	// added field survey variables need to define
	//it in a table
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:43:56)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vChiefEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vProjectInfo)  // Command Replaced was o_C_STRING length was 50
C_DATE:C307(vToday)
C_LONGINT:C283(vAssignNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDesignTLF; vConstructionTLF; vDirectExpense; vMaxObligation; vfieldsurvey)

If (Not:C34(Is new record:C668([Contract_Assignment_Maintenance:101])))
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_NTP")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		vProjectInfo:=""
		vContactName:="Contact_Name"
		vLastName:="Last_Name"
		//vChiefEngineer:=CM_GetChiefEngineer 
		GetBridgeEngineer
		vAddress1:="Address_Line_1"
		vAddress2:="Address_Line_2"
		vToday:=Current date:C33(*)
		
		vDesignTLF:=0
		vConstructionTLF:=0
		vDirectExpense:=0
		vMaxObligation:=0
		vfieldsurvey:=0  //added this value which is 0 until we can define it in the table
		
		If ([Contract_Assignment_Maintenance:101]ProjectIS:4#"")
			vProjectInfo:=vProjectInfo+"Project File No. "+[Contract_Assignment_Maintenance:101]ProjectIS:4
		End if 
		
		If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Negotiated")
			vDesignTLF:=[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
			vConstructionTLF:=[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
			vDirectExpense:=[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
			//vMaxObligation:=vDesignTLF+vConstructionTLF+vDirectExpense
			vMaxObligation:=[Contract_Assignment_Maintenance:101]Est_Total:15
		Else 
			vDesignTLF:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25
			vConstructionTLF:=[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
			vDirectExpense:=[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
			//vMaxObligation:=vDesignTLF+vConstructionTLF+vDirectExpense
			vMaxObligation:=[Contract_Assignment_Maintenance:101]Actual_Total:9
		End if 
		vDesignTLF:=Round:C94(vDesignTLF; 2)
		vConstructionTLF:=Round:C94(vConstructionTLF; 2)
		vDirectExpense:=Round:C94(vDirectExpense; 2)
		vMaxObligation:=vDesignTLF+vConstructionTLF+vDirectExpense
		
		vContractNo:=[Contract_Maintenance:97]ContractNo:1
		vAssignNo:=[Contract_Assignment_Maintenance:101]AssignNo:2
		vCompanyName:=[Contract_Maintenance:97]ConsultantName:3
		
		GetConsltAddress(vCompanyName; "DESIGN")
		CM_GetPersonnelData
		G_WP_MakeDocument
	End if 
	
	REDRAW WINDOW:C456
	
Else 
	ALERT:C41("You have to create this assignment first before generate this letter.")
End if 