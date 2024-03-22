//%attributes = {"invisible":true}
//Method: RatRep_SetUpPosting
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/15/18, 11:17:11
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	//Add new fields[RatingReports]WithPedestrianAccess_b [RatingReports]WithRestrictions_
	//Modified by: Chuck Miller (5/15/18 11:01:51)
End if 
//
C_TEXT:C284($1; $FieldName_txt)
$FieldName_txt:=$1
C_POINTER:C301($Fld_ptr)

Case of 
		
	: ($FieldName_txt="NoPosting")
		If ([RatingReports:65]NoPosting:24)
			Case of 
				: ([RatingReports:65]PostingWaived:26)
					$Fld_ptr:=->[RatingReports:65]PostingWaived:26
				: ([RatingReports:65]RemainPosted:34)
					$Fld_ptr:=->[RatingReports:65]RemainPosted:34
				: ([RatingReports:65]BridgeClosed:25)
					$Fld_ptr:=->[RatingReports:65]BridgeClosed:25
			End case 
		End if 
	: ($FieldName_txt="PostingWaived")
		If ([RatingReports:65]PostingWaived:26)
			Case of 
				: ([RatingReports:65]NoPosting:24)
					$Fld_ptr:=->[RatingReports:65]NoPosting:24
				: ([RatingReports:65]RemainPosted:34)
					$Fld_ptr:=->[RatingReports:65]RemainPosted:34
				: ([RatingReports:65]BridgeClosed:25)
					$Fld_ptr:=->[RatingReports:65]BridgeClosed:25
			End case 
		End if 
	: ($FieldName_txt="RemainPosted")
		If ([RatingReports:65]RemainPosted:34)
			Case of 
				: ([RatingReports:65]NoPosting:24)
					$Fld_ptr:=->[RatingReports:65]NoPosting:24
				: ([RatingReports:65]BridgeClosed:25)
					$Fld_ptr:=->[RatingReports:65]BridgeClosed:25
				: ([RatingReports:65]PostingWaived:26)
					$Fld_ptr:=->[RatingReports:65]PostingWaived:26
			End case 
		End if 
	: ($FieldName_txt="BridgeClosed")
		If ([RatingReports:65]BridgeClosed:25)
			Case of 
				: ([RatingReports:65]NoPosting:24)
					$Fld_ptr:=->[RatingReports:65]NoPosting:24
				: ([RatingReports:65]RemainPosted:34)
					$Fld_ptr:=->[RatingReports:65]RemainPosted:34
				: ([RatingReports:65]PostingWaived:26)
					$Fld_ptr:=->[RatingReports:65]PostingWaived:26
			End case 
		End if 
End case 
If (Is nil pointer:C315($Fld_ptr))
Else 
	$Fld_ptr->:=False:C215
	PushChange(2; $Fld_ptr)
End if 
RatRep_SetUpRestrictions
//End RatRep_SetUpPosting