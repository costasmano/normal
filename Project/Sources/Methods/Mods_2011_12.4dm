//%attributes = {"invisible":true}
If (False:C215)
	Mods_2011_12
End if 

// **********  ` Modified by: costasmanousakis-(Designer)-(12/1/11 15:23:42)
// Created Method(s) : 
//TEST_NetUtilTests

//GetBridgeFieldData
//  ` Retrieve a data field from a bridge record by BIN.
//  ` Usefull for searching by formula on tables with a BIN field but 
//  ` with no relation defined in the structure to the [Bridge MHD NBIS] table
// Parameters
// $0 : $RetValue_txt
// $1 : $BIN_txt
// $2 : $Bridgefld_ptr

// **********  ` Modified by: costasmanousakis-(Designer)-(12/2/11 15:26:56)
// Modified Method(s) : 
//WRUTIL_Function
//  `Make sure right par margin is not less than zero

//G_InspParagProt
//  `Make sure the continution header is in black and white by re-setting the default style sheet.

//INSP_ViewAllComments
//  `Moved exterbak window to 20,20 from 10,10
//  `Disabled editing in the area to avoid confusion

//Startup
//  `Modified Code that stores machinename to include last date and count of logins from that machine

// **********  ` Modified by: costasmanousakis-(Designer)-(12/5/11 15:26:56)
//PERS_GetInfo
// Description :
//  ` Get info about a person return it in a variable passed as a pointer in pairs of "INFO" ; VarPtr.
//  ` Usage :
//  ` PERS_GetInfo( PID; "EMAIL";->$EmailVar_txt; "EMPLOYER"; ->$EmplVar_txt)
// 
// Parameters
// $1 : $PersID_L
// $2 : $Type1_txt ("EMAI:" | "EMPLOYER" | "FIRSTLAST" | "FULLNAME" 
// $3 : $Var1_ptr
// $4 : $Type2_txt
// $5 : $Var2_ptr
// etc...

// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `Clean up logic on selecting the DBIE who will be ccd upon review

// **********  ` Modified by: costasmanousakis-(Designer)-(12/6/11 15:26:56)
// Created Method(s) : 
//GRP_GetGroupRepID
// Description
//  ` Retrieve the ID of the representative of a personnel group. 
//  ` Either the primary, the acting, or the first one on the list
//  ` Parameters
//  ` $0 : $PersonID_L of primary member
//  ` $1 : $GroupName_txt in Pers_groups

// Modified Method(s) : 
//INSP_ReviewAction
//  ` Do not send email if it is a final approval 

//CRTG_ReviewerCBO_OM
//  ` Added assignment of $2-> := $2-> to force refresh of variable. 
//  ` it did not refresh in some cases

// **********  ` Modified by: costasmanousakis-(Designer)-(12/7/11 15:26:56)
// Modified Forms : 
//[Bridge MHD NBIS];"RailTransitSIA"
//  `modified Form to show Railroad bridge no and branch name- got rid of Milepoint

// **********  ` Modified by: costasmanousakis-(Designer)-(12/8/11 15:26:56)
// Modified Method(s) : 
//ut_GetBackupInfo
//  `Fixed email_to address when error : append the email from param MAIL_TRANSFEMRGLIST, not use only that one

// **********  ` Modified by: costasmanousakis-(Designer)-(12/9/11 15:26:56)
//ut_LoadUsersAndGroups
//  `Fixed bug in the GET DOC PROP call; it neede the Folder included in the document name

// **********  ` 
// **********  ` End of changes for RELEASE v5.9.1.a
// **********  ` 

// **********  ` Modified by: costasmanousakis-(Designer)-(12/12/11 09:04:28)
// Modified Method(s) : 
//ut_GetBackupInfo
//  `Added additional informarion on the email text to identify where the email is coming from

//ut_executeMethod
//  `sort the array of commands before storing them; remove if(FALSE) code block

//P_ListTownAddress
//  `Replace all RW Groups with TownContactRW group and Design Access Group;
//  `Calculate the number of districts from the information in the [Town Data] table

// Modified Object Methods : 
//[Personnel];"Inspectors out".PersTools_atxt
//  `Access given to Design Access Group

//Fix quick report problem where changing to related many table will not print data from original one table
//modified by Charkes Miller 12/13/11, 14:32:17    
//  Move code to 2004
//SIA_CustomQRBtn_OM 
//  `Added NBI Secondary table to the list of related tables
//CM_CustomQRBtn_OM 
//DCM_CustomQRBtn_OM 
//ut_QRProcess

//Modified by: Charles Miller (12/13/11 12:12:57)
// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".PRJ_RelatedQRs
//`Fix quick report problem where changing to related many table will not print data from original one table

// **********  ` Modified by: costasmanousakis-(Designer)-(12/14/11 08:18:59)
// Modified Method(s) : 
//ut_LoadUserLoginInformation
//  `Fixed declaration of $Membership_aL switch from text array to longint
//  `Add Check for OK after doc select

// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".RefBINSelector_atxt
//[Bridge MHD NBIS];"BDEPT Input".bGetRef
//  `Switched from aItem7 to RefBINSelector_atxt


//Fix quick report problem where changing to related many table will not print data from original one table
//Added NBI Secondary table to the list of related tables
//modified by Charkes Miller 12/13/11, 14:32:17    
//SIA_CustomQRBtn_OM
//DCM_CustomQRBtn_OM 
//CM_CustomQRBtn_OM 
//ut_QRProcess 
//[PRJ_ProjectDetails]."ProjectDetails.o"
//  `Method: Object Method: [PRJ_ProjectDetails].ProjectDetails.o.PRJ_RelatedQRs
