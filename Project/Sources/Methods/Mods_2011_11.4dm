//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(11/1/11 14:44:19)
// Modified Method(s) : 
//BMSUtil_BelongToBridge
//  `Fixed MBTA case - it used to be MBT not MBTA

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bAddInsp
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `USe global var ◊CurrentUser_Name


// **********  ` Modified by: costasmanousakis-(Designer)-(11/2/11 16:08:35)
// Modified Method(s) : 
//G_SetInspFont
//  `Made sure that the font is Arial if not Geneva or Times New Roman.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/3/11 09:39:52)
// Modified Method(s) : 
//WRUTIL_Function
//  `Added codes 202 and 210 in Cleanchars function

// **********  ` Modified by: costasmanousakis-(Designer)-(11/8/11 12:07:46)
// Modified Method(s) : 
//SCPOA_Variables
//  `Fixed assignement of SCPOA_UWInspFreq_L when there is a UW Spec mem inspection freq.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/10/11 08:14:39)
// Modified Method(s) : 
//INSP_SortReviewList
//  `Removed ut_Send2Clipboard calls

//P_ReviewInspcts
//  `Enabled the new method of displaying pending inspections

//WRUTIL_Function
//  `Enabled Cleanchars for all users

// **********  ` Modified by: costasmanousakis-(Designer)-(11/14/11 11:25:38)
// Modified Method(s) : 
//ut_setPrefSMTPServer
//  `Added check in the error output of nslookup. In windows the "can't find" might be in there


// **********  ` Modified by: costasmanousakis-(Designer)-(11/17/11 18:17:21)
// Modified Method(s) : 
//INSP_CheckSpcMfrFreq
//  `Added call to CalcItem91 to adjust item 91 if spec mem freq is changed

// **********  ` Modified by: costasmanousakis-(Designer)-(11/25/11 18:17:21)
//Mail_SendInspRevuNotif
//  `For DBIE email add the DBIE Email to the cc list; if the curr user is not the DBIE. 
//  `use method PERS_GetInfo to get personnel information.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/30/11 18:17:21)
//SIA_SecureInputForm
//  `For non_NBI records unlock Item91 Inspection frequency

// Modified Method(s) : 
//CalcItem91
//  `Added RRO to the bridges that this method does nothing

// Modified Forms : 
// [Inspections];"RailRoutinePrPg1"
//  `Changed object names so that they are not platform specific. Removed the set visible commands;
//  `in the form changes the Reference from tracks under to Item 45

// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input" 
//  ` Use ◊CurrentUser_Name instead of Current user
