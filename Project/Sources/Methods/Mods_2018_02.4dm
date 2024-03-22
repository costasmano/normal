//%attributes = {"invisible":true}
//Method: Mods_2018_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/12/18, 17:08:40
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
End if 
//
Mods_2018_02  //Add code to confirm change if data already exists
//Modified by: Chuck Miller (2/15/18 15:20:31)
//Method: [TIN_Inspections].Input.Rating Report
//Method: [TIN_Inspections].Input.WeightPosting

// Added code to enable or disable 4D write area depending upon whether in read write mode or not
//NTI_InspectionInput_FM
//Modified by: Chuck Miller (2/15/18 13:04:57)


//Allow for change of tunnel number to allow for T or B as first character of second position
//Modified by: Chuck Miller (2/20/18 17:14:30)
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Prefix_txt
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Number_s
//Method: NTI_SetTunnelNumber
//Compiler_Tunnels
//Method: ut_LimitLength//This method added to make sure string entered is not greater than passed in number of characters
//Compiler_Utilities

//**********`Modified by: Costas Manousakis-(Designer)-(2/23/18)
// Modified Method(s) : 
//CM_MailInvoiceNotice 
//CM_MailInvoiceNotice_2
//LSS_SendAcceptRejectEmail 
//Mail_BridgeStatusRpt 
//Mail_SendInspRevuNotif 
//Mail_SendTINRevuNotif 
//mail_testSend 
//ut_ControlSendMail 
//ut_SendEmail 
//WKHR_MailReviewNotice 
//  `remove IT_MacTCPInit

//End Mods_2018_02