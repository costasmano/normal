//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/10, 11:21:21
	// ----------------------------------------------------
	// Method: Method: CRTG_LoadReviewerLists
	// Description
	//  ` Load the lists of the Rating Reviewers
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
ARRAY TEXT:C222(Reviewer1List; 0)
ARRAY TEXT:C222(Reviewer2List; 0)
ARRAY TEXT:C222(Reviewer3List; 0)
ARRAY TEXT:C222(Reviewer4List; 0)
ARRAY LONGINT:C221(CRTG_Reviewers_aL; 0)  //not needed only used for the function
PRJ_FillPersonnelDropDowns(->CRTG_Reviewers_aL; ->Reviewer1List; "RatingReviewers")
INSERT IN ARRAY:C227(Reviewer1List; 0)
Reviewer1List{1}:=""
COPY ARRAY:C226(Reviewer1List; Reviewer2List)
COPY ARRAY:C226(Reviewer1List; Reviewer3List)
COPY ARRAY:C226(Reviewer1List; Reviewer4List)
POPUP(->Reviewer1List; ->[Conslt Rating:63]ReviewRtgWho1:8; 0; True:C214)
POPUP(->Reviewer2List; ->[Conslt Rating:63]ReviewRtgWho2:54; 0; True:C214)
POPUP(->Reviewer3List; ->[Conslt Rating:63]ReviewRtgWho3:55; 0; True:C214)
POPUP(->Reviewer4List; ->[Conslt Rating:63]ReviewRtgWho4:56; 0; True:C214)
If (Size of array:C274(Reviewer1List)=0)
	OBJECT SET ENABLED:C1123(Reviewer1List; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(Reviewer2List; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(Reviewer3List; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(Reviewer4List; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
