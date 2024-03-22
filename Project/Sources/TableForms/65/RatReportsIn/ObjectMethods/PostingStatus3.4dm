//Method: [RatingReports].RatReportsIn.PostingStatus3
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/15/18, 11:00:12
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	//Add new fields[RatingReports]WithPedestrianAccess_b [RatingReports]WithRestrictions_b
	//Modified by: Chuck Miller (5/15/18 11:01:51)
End if 
//
PushChange(2; Self:C308)
If ([RatingReports:65]BridgeClosed:25=True:C214)
	[RatingReports:65]Item64:29:=0
	[RatingReports:65]Item66:31:=0
	[Bridge MHD NBIS:1]Item64:137:=[RatingReports:65]Item64:29
	[Bridge MHD NBIS:1]Item66:139:=[RatingReports:65]Item66:31
	PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
	PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
	PushChange(2; ->[RatingReports:65]Item66:31)
	PushChange(2; ->[RatingReports:65]Item64:29)
	vbForce0:=True:C214
Else 
	vbForce0:=False:C215
End if 
RatRep_SetUpPosting(Field name:C257(Self:C308))

//End [RatingReports].RatReportsIn.PostingStatus3