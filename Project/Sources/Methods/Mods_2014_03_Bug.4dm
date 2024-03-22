//%attributes = {"invisible":true}
//Method: Mods_2014_03_Bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/13/14, 09:28:43
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03_Bug
End if 
//
// Modified Object Methods : 
//[ElementsSafety].FreezeThawInp_1A.Comments 
//  `fixed wrong stack number on data change

// Modified Method(s) : 
//SETUTIL_Control 
//  `fixed "bug" when loading files that are actual 4D Set. now if the file loaded deoas not have the "SETUTIL_SAVESET" tag
//  `it is assumed to be a 4D Set and loaded directly into the current table


//```
//```   **** End of Release  6.3.1.a Version 3/14/2014
//```

// Modified Field(s) : 
//CHANGED FIELDS
//----------------------------
//[Inspections]BIN: Index: False->True;
//[Inspections]DBrInspEngr: Index: False->True;
//[Inspections]TeamLeader: Index: False->True;
//[Inspections]Insp Type: Index: False->True;
//[Inspections]InspReviewed: Index: False->True;
//[Inspections]Insp Date: Index: False->True;
//[Inspections]Modified By: Index: False->True;
//[Inspections]InspApproved: Index: False->True;
//[Inspections]InspComplete: Index: False->True;
//[BMS Inspections]BIN: Index: False->True;
//[BMS Inspections]Insp Date: Index: False->True;
//[BMS Inspections]DBrInspEngr: Index: False->True;
//[BMS Inspections]TeamLeader: Index: False->True;
//[Preservation_Reviews]AssignID: Index: False->True;
//[Preservation_Reviews]ReviewTYpe_s: Index: False->True;
//[Preservation_Reviews]SentBackToPM_d: Index: False->True;
//[Preservation_Reviews]Deadline_d: Index: False->True;
//[Preservation_Meetings]AssignID: Index: False->True;
//[Preservation_Meetings]MeetingType_s: Index: False->True;
//[Preservation_Meetings]MeetingDate_d: Index: False->True;
//[Inspections]UpdateMaximo_L: Index: False->True;

// Modified Method(s) : 
//DEV_UPDATE_STRUCTURE_LOG
//  `sending the "header" text to the doc at the end was missing. 
//  `added some features to compare to a dfferent folde so you can compare two different struct version
//  `optionaly overwrite the struct data on disk


//```
//```   **** End of Release 6.3.1.b 03/18/2014
//```

//**********`Modified by: Costas Manousakis-(Designer)-(3/24/14)

// Modified Table(s) : 
//[Bridge Design]BridgeDesignID
//  `Reset field to unique and indexed


//End Mods_2014_03_Bug