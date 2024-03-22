//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintRFP_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:26:44)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07  // twice
	// Modified by: costasmanousakis-(Designer)-(9/11/2007 12:53:05)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vPlural_is)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vStructure)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vInspMonth)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vSectionHead)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($Town)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($BridgeNo)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($NewBridgeNoFormat)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($ProjectType)  // Command Replaced was o_C_STRING length was 100

C_TEXT:C284(vProjectList)
C_DATE:C307(vToday)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)


If (Not:C34(Is new record:C668([Contract_Assignment_Maintenance:101])))
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_ReqFee")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		vContactName:="Contact_Name"
		vLastName:="Last_Name"
		vSectionHead:=CM_GetSectionHead
		vAddress1:="Address_Line_1"
		vAddress2:="Address_Line_2"
		vToday:=Current date:C33(*)
		vProjectList:=""
		vContractNo:=[Contract_Assignment_Maintenance:101]ContractNo:1
		vAssignNo:=[Contract_Assignment_Maintenance:101]AssignNo:2
		vCompanyName:=[Contract_Maintenance:97]ConsultantName:3
		
		GetConsltAddress(vCompanyName; "DESIGN")
		
		//get all the projects that belong to this assignment
		QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]ContractNo:2=vContractNo; *)
		QUERY:C277([Contract_Project_Maintenance:100];  & ; [Contract_Project_Maintenance:100]AssignNo:9=vAssignNo)
		ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignNo:9; >; [Contract_Project_Maintenance:100]BIN:5; >)
		
		$Recs:=Records in selection:C76([Contract_Project_Maintenance:100])
		If ($Recs>1)
			vPlural_is:="are"
			vStructure:="structures"
		Else 
			vPlural_is:="is"
			vStructure:="structure"
		End if 
		CM_GetPersonnelData
		C_TEXT:C284($Districts_txt)
		$Districts_txt:=""
		//loop through all the projects to get all the information 
		For ($i; 1; Records in selection:C76([Contract_Project_Maintenance:100]))
			$Town:=[Contract_Project_Maintenance:100]Town:7
			
			$BridgeNo:=[Contract_Project_Maintenance:100]BridgeNo:4
			$NewBridgeNoFormat:=Substring:C12($BridgeNo; 1; 1)+"-"+Substring:C12($BridgeNo; 2; 2)+"-"+Substring:C12($BridgeNo; 4; 3)
			
			$BIN:=[Contract_Project_Maintenance:100]BIN:5
			$ProjectType:=[Contract_Project_Maintenance:100]Project Type:3
			If (Position:C15([Contract_Project_Maintenance:100]District:8; $Districts_txt)>0)
			Else 
				$Districts_txt:=$Districts_txt+[Contract_Project_Maintenance:100]District:8+";"
			End if 
			
			vDistrict:=[Contract_Project_Maintenance:100]District:8
			vProjectList:=vProjectList+$Town+<>sTab+$NewBridgeNoFormat+"("+$BIN+")"+<>sTab+$ProjectType+<>sCR
			
			//go to the next record
			NEXT RECORD:C51([Contract_Project_Maintenance:100])
		End for 
		C_TEXT:C284(CM_StrMntEngrs_txt)
		CM_StrMntEngrs_txt:=CM_GetStrMntEngrs($Districts_txt)
		G_WP_MakeDocument
		
		REDRAW WINDOW:C456
	End if 
	
	
Else 
	ALERT:C41("You have to create this assignment first and add projects to it to generate this "+"letter.")
End if 
