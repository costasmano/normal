//Method: [RatingReports].RatReportsIn.PostingStatus4
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/15/18, 11:02:46
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	//Add new fields[RatingReports]WithPedestrianAccess_b [RatingReports]WithRestrictions_b
	//and modify posting,waived and remain postred checkbox behaviour
	//Modified by: Chuck Miller (5/15/18 11:01:51)
End if 
//
PushChange(2; Self:C308)
RatRep_SetUpPosting(Field name:C257(Self:C308))


//End [RatingReports].RatReportsIn.PostingStatus4