// [RatingReports];"RatReportsIn".PostingStatus1
If (False:C215)
	Mods_2018_05
	//Add new fields[RatingReports]WithPedestrianAccess_b [RatingReports]WithRestrictions_b
	//Modified by: Chuck Miller (5/15/18 11:01:51)
	//and modify posting,waived and remain postred checkbox behaviour
End if 

PushChange(2; Self:C308)
RatRep_SetUpPosting(Field name:C257(Self:C308))
