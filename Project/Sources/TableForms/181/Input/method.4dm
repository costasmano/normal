
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 17:01:52
//----------------------------------------------------
//Method: Form Method: [NTI_TunnelInfo];"Input"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/22/15 17:01:54)
	// Modified by: Costas Manousakis-(Designer)-(4/29/16 14:57:48)
	Mods_2016_04_bug
	//  `modified widths of columns in listboxes on page 9 
	// Modified by: Costas Manousakis-(Designer)-(10/5/17 14:29:14)
	Mods_2017_10
	//  `added InspResp field and drop down
	// Modified by: Costas Manousakis-(Designer)-(4/27/18 14:23:59)
	Mods_2018_04_bug
	//  `fix label of item N.3
	// Modified by: Costas Manousakis-(Designer)-(5/3/18 12:54:51)
	Mods_2018_05_bug
	//  //Modified page 5 of [NTI_TunnelInfo];"Input"  Special Member Target and Actual Dates were poiting to Overhead items dates
	// Modified by: Costas Manousakis-(Designer)-(3/14/19 15:32:31)
	Mods_2019_03_bug
	//  `use entry filter AlphaNumA for I11 (LRS Route ID)- CallReference #621
	// Modified by: Costas Manousakis-(Designer)-(4/11/19 11:10:19)
	Mods_2019_04_bug
	//  `hide columns for girder/slab ratings in listbox "TunnelRating_LB" , change size of listbox, change format of dates to internal date short
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

FM_NTITunnelInput

//End Form Method: [NTI_TunnelInfo]Input

