//%attributes = {"invisible":true}
//Method: Mods_2015_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/02/15, 09:54:29
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2/2/15)
// Modified Method(s) : 
//SIA_Item8Owner_OM
//  `Added optional parameter to check from which form we were called. -
//  ` don't change legacy owner when adding a new bridge record (Form [bridge mhd nbis].BDEPT INPUT)
//Compiler_SIA
//  `added SIA_Item8Owner_OM

// Modified Object Methods : 
//[Bridge MHD NBIS].BDEPT Input.aIt8OwnerDes_ 
//  `Pass the the current method name to know from which form SIA_Item8Owner_OM was called

// Modified Method(s) : 
//ARCHIVE_SDFOCalc 
//  `Added var $BaseYear_i to use the year of the archive date not the current date


//**********`Modified by: Costas Manousakis-(Designer)-(2/5/15)
// Modified Method(s) : 
//INSP_SetUpvDBIE
//  `moved the vDBIE var declaration outside  the if statement. also force the object DOTEngineer to be visible even for MBTA
//  ` the vDBIE is only in one object DOTEngineer

// Created Method(s) : 
//PON_CleanNBEXML 
//  ` Will read an NBE xml export  file from BrM and will make sure that there are no
//  ` non-NBI records included, also change the StrucNum to FHWAItem8 if needed.

//**********`Modified by: Costas Manousakis-(Designer)-(2/6/15)
// Modified Method(s) : 
//ADDUSER_Utils
//  ` under task "NAMECHANGE"
//  `changed  to $C0:=((Random%(5+1))+1)  from (6+1) : this one could result in  $C0=7
//  `also added warming of Random by calling it 5 times before using it

// Created Method(s) : 
//Method: ConvertBINtoNumber
//Description
// calculate a number from a BIN
// Parameters
// $0 : $BIN_s
// $1 : $BIN_L

// Created Method(s) : 
//Method: Find1stMissingBIN
//Description
//  ` search and find missing Bins. 
//  ` bring up dialog to show  list
//  ` return the selected one, or the first one
// Parameters
// $0 : $BIN_s

// Modified Method(s) : 
//Compiler_Bridge 
//  `added /moved here ConvertBIN , ConvertBINtoNumber , Find1stMissingBIN

//**********`Modified by: Costas Manousakis-(Designer)-(2/12/15)
// Created Method(s) : 
//Method: SCPOA_TextVarWDefault_OM
//Description
//  ` method used for text variables in the POA form where a default value based on the owner can be assigned.
// Parameters
// $1 : $TextVar_ptr :  Pointer to textvar or field
// $2 : $SysParamPrefix_txt : Prefix of a sys param in parameters table to be used as default. full param would be
//  ` the prefix + the owner code from Item 8 owner

// Modified Method(s) : 
//Compiler_SCPOA
//  `added  SCPOA_TextVarWDefault_OM

// Modified Object Methods : 
//Object Method: [ScourPOA].Input-A.Picture Button1   "SCPOA_EditTextBtn" for SCPOA_BrgClosure_txt

// Modified Forms : 
//[ScourPOA];"Input-A"
//  ` added  textEdit button for  SCPOA_Contacts_txt which calls new method  SCPOA_TextVarWDefault_OM

// Modified Method(s) : 
//SCPOA_Variables
//  ` move setting of SCPOA_ReOpenResp_txt, SCPOA_Contacts_txt,SCPOA_BrgClosure_txt,SCPOA_ClosureResp_txt,SCPOA_PostFldMonAgc_txt inside
//  ` if (Approve=0) ie. do only if POA has not been approved yet.
//  ` use system parameters for the defaults of these varaibles depending on item8 owner. 
//  ` for others except DOT and MUN use DOT as default


//**********`Modified by: Costas Manousakis-(Designer)-(2/13/15)
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Added Tunnel Other type "TOT"

// Modified Method(s) : 
//G_Insp_AddOrientation
//INSP_GetReviewRules
//  `Case for Tunnel type inspections changed to T@
//INSP_MyReviewInspections
//  `Added Damage and Other  TDA, TOT to the tunnel inspecions
//INSP_PrintInspBtn_OM
//  `Added Tunnel Damage TDA , Tunnel Other TOT
//INSP_ReturnCMLength 
//  `added  TOT : tunnel  Other
//INSP_SetSpMbPrintForm
//  `added tunnel other TOT
//INSP_UpdateInspList
//  `added TOT (tunnel other to the tunnel inspections)
//PRINT_Critical
//  `  `  `added TOT : tunnel Other
//Print_Dive_Cmt_a_new
//  `added  TOT: tunnel  other
//SIA_OnDisplayDetail
//  `added Tunnel Other for page=11


// Modified Object Methods : 
//Object Method:[Inspections];"AboveWater Template" bPrint
//[Inspections].Tunnel Template.bPrint 
//  `added TOT : tunnel Other

// Modified Method(s) : 
//ut_SQLReturnActLogRecords 
//  `added code to get changes in Town address and Conslt Address tables for Dive and district users.

//**********`Modified by: Costas Manousakis-(Designer)-(2/23/15)
// Modified Method(s) : 
//SCPOA_InpFormMethod_A
//  `added  datemodified to the changes in on validate. this is to track for any auto fill
//  ` which should not be done continually

// Modified Forms : 
//[ScourPOA];"FieldVerificationCardpg1"
//  `added extra space for the NWS river forrecast info link

//**********`
//Additions of new tables
// [PON_ELEM_DEFS] [PON_ELEM_INSP]
// Input forms and methods for the upcoming deployment of the new NBE inspections
//**********`

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/15)
// Modified Method(s) : 
//G_SortTable_new
//  `added check if the friendly fieldname is longer than 31 chars, start removing spaces from the end until ok

//```
//```   **** End of Release 6.3.3.c 02/26/2015
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2/27/15)
// Modified Method(s) : 
//SIA_FindMissingBDEPTs
//  `adjusted logic when searching in selection to look trhough the whole db not jsut selection. still will only go up to last brio in list.
//  `also display results in a listbox instead of alert showing some more information 

//modifed menu bar #2 (BridgeListMenu) ,menu "Tools" 
//added item Find Missing BDEPTs with parameter "ONE" to indicate coming from Bridge list

//modifed menu bar #1  ,menu "Tools" 
//added item Find Missing BDEPTs with parameter "ONE" to indicate coming from Bridge list

//End Mods_2015_02