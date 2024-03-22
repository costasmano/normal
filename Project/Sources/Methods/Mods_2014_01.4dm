//%attributes = {"invisible":true}
//Method: Mods_2014_01
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/13/14, 14:56:16
	// ----------------------------------------------------
	//Created : 
	Mods_2014_01
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(1/16/14)
// Modified Form Methods : 
//[RatingReports];"RatReportsIn"
//  `Added query on [RatingMember] at the on load event

//[RatingMember];"RatMemberIn"
//  `modified form to add display of Bin, bdept, rating date, consultant; increased HT of descr; added vert scroll bars
//  `on the on validate event clean out the text in the descr  to avoid multiple extra lines

//**********`Modified by: Costas Manousakis-(Designer)-(1/24/14)
// Modified Forms : 
//[Inspections];"TunnelSpecialMember"
//  `resized  Item8 and kilo point to give more space to inspection date.

// Modified Method(s) : 
//ut_executeMethod 
//  `Added ability to execute on a registered client

//**********`Modified by: Costas Manousakis-(Designer)-(1/27/14)
// Modified Object Methods : 
//[Bridge MHD NBIS];"SI & A Input".Bridge Name 
//  `added trim of entry and  added entry filter  on the field with semicolon  pattern " -}" allows chars from space to }, add "-" and "~"
//  `Created Filter AllASCII32to126 that includes all characters. assigned to bridge name object

//**********`Modified by: Costas Manousakis-(Designer)-(1/30/14)
// Modified Method(s) : 
//ut_SQLDeleteLocalRecords
//  `Fixed bug where the parentfield pointer was not the correct field for refIDType=1

//End Mods_2014_01