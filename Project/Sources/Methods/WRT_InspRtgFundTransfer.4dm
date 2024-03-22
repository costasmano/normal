//%attributes = {"invisible":true}
//Method: WRT_InspRtgFundTransfer
//Description
// create a Word doc letter for Transfer of funds in Contslt inp Rating contracts
// run from input form of TranferofFunds CallRefernece #699
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/20, 12:46:41
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
	
End if 
//

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_DATE:C307(vToday)

READ ONLY:C145([Templates:86])
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_InspRtgContr_FundTransfer")
If (Records in selection:C76([Templates:86])=0)
	ALERT:C41("Document template does not exist!")
	
Else 
	
	vContactName:="Contact_Name"
	vLastName:="Last_Name"
	vCompanyName:="Company_Name"
	vAddress1:="Address_Line_1"
	vAddress2:="Address_Line_2"
	C_BOOLEAN:C305($gotDate_b)
	$gotDate_b:=True:C214
	If ([Contract FundTransfer:80]DateApproval:5#!00-00-00!)
		vToday:=[Contract FundTransfer:80]DateApproval:5
	Else 
		
		CONFIRM:C162("Date of approval is blank! Will beu sing today's date for the letter!"; "Continue?"; "Cancel")
		
		If (OK=1)
			vToday:=Current date:C33(*)
		Else 
			$gotDate_b:=False:C215
		End if 
		
	End if   //approval date check
	
	If ($gotDate_b)
		
		C_TEXT:C284(v_79_002_txt)  //contract type
		C_TEXT:C284(v_80_006_txt)  //TransferDirection
		C_REAL:C285(v_80_007_r)  //TransferAmount
		
		v_80_007_r:=[Contract FundTransfer:80]TransferAmount:7
		v_80_006_txt:=Replace string:C233([Contract FundTransfer:80]TransferDirection:6; "From "; "from ")
		v_80_006_txt:=Replace string:C233(v_80_006_txt; "Expense"; "Expenses")
		
		vContractNo:=[Contracts:79]ContractNo:1
		vCompanyName:=[Contracts:79]ConsltName:3
		If ([Contracts:79]ContractType:2="@inspection@")
			GetConsltAddress(vCompanyName; "INSPECTION")
			
		Else 
			GetConsltAddress(vCompanyName; "RATING")
			
		End if 
		v_79_002_txt:=INSPRTG_GetLetterHDR([Contracts:79]ContractType:2)
		
		GetBridgeEngineer
		
		C_TEXT:C284($UserInitial)  // **Replaced old C_STRING length 5
		$UserInitial:=F_GetUserInitial(Current user:C182)
		If ($UserInitial="")
			vWriterInitial:="ENTER_WRITER_INITIAL"
		Else 
			vWriterInitial:=Uppercase:C13($UserInitial)+"/"+Lowercase:C14($UserInitial)
		End if 
		
		G_WP_MakeDocument
		
	End if   //if letter date has been set
	
End if   //if found template

//End WRT_InspRtgFundTransfer