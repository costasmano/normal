//[RatingReports];"RatReportsIn"
//Popupmenu for Item 43b

C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!

//If (Blank ([RatingReports]Item43inRating)=True)
//  [RatingReports]Item43inRating:=[Bridge MHD NBIS]Item43
//End if 

item43b:=Substring:C12([RatingReports:65]Item43inRating:17; 2; 2)
POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
If (Form event code:C388=On Clicked:K2:4)
	[RatingReports:65]Item43inRating:17:=Substring:C12([RatingReports:65]Item43inRating:17; 1; 1)+item43b
	[Bridge MHD NBIS:1]Item43:75:=[RatingReports:65]Item43inRating:17
	PushChange(1; ->[Bridge MHD NBIS:1]Item43:75)
	PushChange(2; ->[RatingReports:65]Item43inRating:17)
End if 
