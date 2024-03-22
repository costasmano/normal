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
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($Title_txt)
		$Title_txt:=OBJECT Get title:C1068(*; "NoRatingNeeded")
		If ($Title_txt="") | ($Title_txt=" ")
			
			OBJECT SET TITLE:C194(*; "NoRatingNeeded"; "X")
			OBJECT SET TITLE:C194(*; "RatedValue"; "")
			OBJECT SET TITLE:C194(*; "HighPriority"; "")
			OBJECT SET TITLE:C194(*; "MediumPriority"; "")
			OBJECT SET TITLE:C194(*; "LowPriority"; "")
			OBJECT SET ENABLED:C1123(*; "RatedPriority_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "NoRatingText"; True:C214)
			OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
			OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
			
			OBJECT SET TITLE:C194(*; "NoRatingNeeded"; "")
		End if 
		
End case 
//End [Bridge MHD NBIS].Rating Evalu 10y.Invisible Button