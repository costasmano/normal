//Method: [Bridge MHD NBIS].Rating Evalu 10y.Invisible Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/18/17, 12:31:53
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
	
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($Title_txt)
	$Title_txt:=OBJECT Get title:C1068(*; "RatedValue")
	If ($Title_txt="") | ($Title_txt=" ")
		OBJECT SET TITLE:C194(*; "RatedValue"; "X")
		OBJECT SET ENABLED:C1123(*; "RatedPriority_@"; True:C214)
		OBJECT SET TITLE:C194(*; "NoRatingNeeded"; "")
		OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
		OBJECT SET VISIBLE:C603(*; "RatingText"; True:C214)
		
	Else 
		OBJECT SET TITLE:C194(*; "HighPriority"; "")
		OBJECT SET TITLE:C194(*; "MediumPriority"; "")
		OBJECT SET TITLE:C194(*; "LowPriority"; "")
		OBJECT SET TITLE:C194(*; "RatedValue"; "")
		OBJECT SET ENABLED:C1123(*; "RatedPriority_@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "NoRatedValue"; True:C214)
		OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
		OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
		
	End if 
End if 
//End [Bridge MHD NBIS].Rating Evalu 10y.Invisible Button