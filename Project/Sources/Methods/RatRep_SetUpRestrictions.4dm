//%attributes = {"invisible":true}
//Method: RatRep_SetUpRestrictions
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/15/18, 10:42:24
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/11/18 16:42:35)
End if 
//

OBJECT SET ENABLED:C1123(*; "WithRestrictions_b"; ([RatingReports:65]NoPosting:24 | \
[RatingReports:65]PostingWaived:26 | \
[RatingReports:65]RemainPosted:34) | \
(([RatingReports:65]RecPost3:15+[RatingReports:65]RecPost3S2:16+[RatingReports:65]RecPostingH:14+[RatingReports:65]RecSinglePosting_L:39)>0))

OBJECT SET ENABLED:C1123(*; "WithPedestrianAccess_b"; [RatingReports:65]BridgeClosed:25)
Case of 
	: (([RatingReports:65]RecPost3:15+[RatingReports:65]RecPost3S2:16+[RatingReports:65]RecPostingH:14+[RatingReports:65]RecSinglePosting_L:39)>0)
	: ([RatingReports:65]NoPosting:24)
	: ([RatingReports:65]PostingWaived:26)
	: ([RatingReports:65]RemainPosted:34)
	Else 
		If ([RatingReports:65]WithRestrictions_b:37)
			[RatingReports:65]WithRestrictions_b:37:=False:C215
			PushChange(2; ->[RatingReports:65]WithRestrictions_b:37)
		End if 
End case 
If (Not:C34([RatingReports:65]BridgeClosed:25))
	If ([RatingReports:65]WithPedestrianAccess_b:38)
		[RatingReports:65]WithPedestrianAccess_b:38:=False:C215
		PushChange(2; ->[RatingReports:65]WithPedestrianAccess_b:38)
	End if 
	
End if 
If (([RatingReports:65]RecPostingH:14>0) | ([RatingReports:65]RecPost3:15>0) | ([RatingReports:65]RecPost3S2:16>0))
	If ([RatingReports:65]RecSinglePosting_L:39>0)
		[RatingReports:65]RecSinglePosting_L:39:=0
		PushChange(2; ->[RatingReports:65]RecSinglePosting_L:39)
	End if 
End if 



//End RatRep_SetUpRestrictions