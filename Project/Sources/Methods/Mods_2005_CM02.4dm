//%attributes = {"invisible":true}
//12-Jan-2005 *********

//Modified Field
//[Conslt Rating]RequestRatDate 
//  `Renamed to [Conslt Rating]FirstExpctSubmDate,
//  `Made it visible.

//Modified Form:
//[Conslt Rating];"Cslt Rating In"
//  `Added field [Conslt Rating]FirstExpctSubmDate on page 1

//Modified Form:
//[Conslt Rating];"View Cslt Rating"
//  `Added field [Conslt Rating]FirstExpctSubmDate; Added sort button

//Created method
//G_CSRTG_InitSortBtns
//  `Initialize all sort arrows in form [Conslt Rating];"View Cslt Rating"

//Modified Object Methods
//[Conslt Rating];"View Cslt Rating". All sort buttons
//  `Use method G_CSRTG_InitSortBtns

//Modified Form:
//[Conslt Rating];"Rating Print Form"
//  `Added field [Conslt Rating]FirstExpctSubmDate

//Modified Method:
//M_WRT_CsltRating_NTP 
//  `Include field [Conslt Rating]FirstExpctSubmDate in the Assignment list
//  `variable.

//Modified Tempate
//WRtemplate_CsltRating_NTP
//  `Added column for Completion date; Adjusted tab spacings elsewhere.