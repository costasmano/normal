//%attributes = {"invisible":true}
//Method: Mods_2013_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/01/13, 09:26:11
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(4/1/13)
// Modified Method(s) : 
//ARCHIVE_Store
//  `Fixed the Show Alert logic and added progress bars

// Modified Forms : 
//[Contracts];"Contracts In"
//  `Made all included subforms automatic width

//[Contract AddFund];"AddFund Out"
//[Contract Assignments];"Assignments Out"
//[Contract ExtendTime];"ExtTime Out"
//[Contract FundTransfer];"TransferFund Out"
//[Contract Invoice];"ContractInvoice Out"
//  `Changed format of all amount variables, adjusted widths of objects and forms; made form horiz margin =0

//[Contract AddFund];"AddFund In"
//[Contract Assignments];"Assignments In"
//[Contract FundTransfer];"TransferFund In"
//[Contract Invoice];"ContractInvoice In"
//  `Changed format of all amount variables, adjusted widths of objects 

//**********`Modified by: Costas Manousakis-(Designer)-(4/4/13)
// Modified Method(s) : 
//INIT_UI_GV
//  `Changed Splash window title to MassDOT

//Modified by: Charles Miller (4/4/13 15:06:43)

//Add AE award date
//renamed [PRJ_ConstructionProject]Dummy_b to [PRJ_ConstructionProject]AEAward_d

//**********`Modified by: Costas Manousakis-(Designer)-(4/9/13)
// Modified Method(s) : 
//WRUTIL_Function
//  `Added process var WRUTIL_WRArea_L because EXECUTE FORMULA cannot refer to the local variable $MyArea in a compiled db
//  `must change parameter CHAR_REPLACED to use the new variable

// Created Method(s) : 
//Compiler_SPRetrieve
//  ` copy of  SQL_ClearArrays for array declaration

// Modified Method(s) : 
//mbta_SortRecords
//  `Added sorting by line, milepost.  sort otder is  Category,  LineName, Milepost, BIN
//  `Only Commuter Rail bridges are sorteb by milepost, so for other categories the milepost array elements are set to 0

//**********`Modified by: Costas Manousakis-(Designer)-(4/10/13)
// Created Method(s) : 
//mail_ValidateEmail
//  ` Validate an email address using regex. 
//Compiler_MailUtils 
//  `For mail utilities

//moved all mail utility methods in the MailUtilities folder

//**********`Modified by: Costas Manousakis-(Designer)-(4/12/13)
// Modified Method(s) : 
//bFuncObsCheck
//  `Added optional parameter $7 to specify a test year for the bridge age will default to the current year
//iAgeofBridge
//  `Added optional parameter $3 to specify the 'present' year as a value gt zero
//End Mods_2013_04