//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/27/07, 11:42:49
	// ----------------------------------------------------
	// Method: WKHR_ApprvReject_OM
	// Description
	// Object method for approveReject btn on 
	// [Work_Estimate];"Input" form
	// 
	// Parameters
	// $1 : $BtnPtr_ptr : pointer to the button
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/30/2007 11:08:54)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/19/09 16:41:57)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 16:45:55  ` ("WKHRMODS")
End if 
C_POINTER:C301($1; $BtnPtr_ptr)
$BtnPtr_ptr:=$1
C_TEXT:C284($ButtnName_txt)
C_LONGINT:C283($TblNo_L; $FldNo_L)
RESOLVE POINTER:C394($BtnPtr_ptr; $ButtnName_txt; $TblNo_L; $FldNo_L)
Case of 
	: ($ButtnName_txt="WKHRReview_p")  //Reviewer button code
		Case of 
			: (Form event code:C388=On Load:K2:1)
				$BtnPtr_ptr->:=([Work_Estimate:103]WkHrEstReviewed:33+1)
				If ([Work_Estimate:103]WkHrEstReviewed:33>0)
					OBJECT SET ENTERABLE:C238(*; "Review_@"; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(*; "Review_@"; False:C215)
				End if 
				
			: (Form event code:C388=On Clicked:K2:4)
				[Work_Estimate:103]WkHrEstReviewed:33:=($BtnPtr_ptr->-1)
				PushChange(1; ->[Work_Estimate:103]WkHrEstReviewed:33)
				Case of 
					: ([Work_Estimate:103]WkHrEstReviewed:33=2)
						[Work_Estimate:103]ReviewedBy:34:=Current user:C182
						[Work_Estimate:103]ReviewDate:36:=Current date:C33(*)
						ARRAY INTEGER:C220(Arr_WKHR_ReviewRef; 0)  //Clear Reviewer entered values
						ARRAY REAL:C219(arr_WKHR_ReviewVal; (WKHR_CategoryCount_i+1); 0)
						OBJECT SET ENTERABLE:C238(*; "Review_@"; True:C214)
					: ([Work_Estimate:103]WkHrEstReviewed:33=1)
						[Work_Estimate:103]ReviewedBy:34:=Current user:C182
						[Work_Estimate:103]ReviewDate:36:=Current date:C33(*)
						OBJECT SET ENTERABLE:C238(*; "Review_@"; True:C214)
						[Work_Estimate:103]WkHrEstComplete:17:=False:C215
						PushChange(1; ->[Work_Estimate:103]WkHrEstComplete:17)
					: ([Work_Estimate:103]WkHrEstReviewed:33=0)
						[Work_Estimate:103]ReviewedBy:34:=""
						[Work_Estimate:103]ReviewDate:36:=!00-00-00!
						OBJECT SET ENTERABLE:C238(*; "Review_@"; False:C215)
				End case 
				PushChange(1; ->[Work_Estimate:103]ReviewedBy:34)
				PushChange(1; ->[Work_Estimate:103]ReviewDate:36)
				
		End case 
		
	: ($ButtnName_txt="ApprvReject_p")  //`Final Approval button code
		Case of 
			: (Form event code:C388=On Load:K2:1)
				$BtnPtr_ptr->:=([Work_Estimate:103]WkHrEstApproved:18+1)
				If ([Work_Estimate:103]WkHrEstApproved:18>0)
					OBJECT SET ENTERABLE:C238(*; "Approve_@"; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(*; "Approve_@"; False:C215)
				End if 
				
			: (Form event code:C388=On Clicked:K2:4)
				[Work_Estimate:103]WkHrEstApproved:18:=($BtnPtr_ptr->-1)
				PushChange(1; ->[Work_Estimate:103]WkHrEstApproved:18)
				Case of 
					: ([Work_Estimate:103]WkHrEstApproved:18=2)
						[Work_Estimate:103]ApprovedBy:22:=Current user:C182
						[Work_Estimate:103]ApprovedDate:19:=Current date:C33(*)
						ARRAY INTEGER:C220(Arr_WKHR_ReviewRef; 0)  //Clear Reviewer entered values
						ARRAY REAL:C219(arr_WKHR_ReviewVal; (WKHR_CategoryCount_i+1); 0)
						OBJECT SET ENTERABLE:C238(*; "Approve_@"; True:C214)
						WKHR_PropFund2Assgn("Update")
						
					: ([Work_Estimate:103]WkHrEstApproved:18=1)
						[Work_Estimate:103]ApprovedBy:22:=Current user:C182
						[Work_Estimate:103]ApprovedDate:19:=Current date:C33(*)
						[Work_Estimate:103]WkHrEstReviewed:33:=0
						[Work_Estimate:103]WkHrEstComplete:17:=False:C215
						WKHRReview_p:=([Work_Estimate:103]WkHrEstReviewed:33+1)
						PushChange(1; ->[Work_Estimate:103]WkHrEstReviewed:33)
						PushChange(1; ->[Work_Estimate:103]WkHrEstComplete:17)
						OBJECT SET ENTERABLE:C238(*; "Approve_@"; True:C214)
						OBJECT SET VISIBLE:C603(*; "UpdateAssignment@"; False:C215)
						WKHR_PropFund2Assgn("Clear")
						
					: ([Work_Estimate:103]WkHrEstApproved:18=0)
						[Work_Estimate:103]ApprovedBy:22:=""
						[Work_Estimate:103]ApprovedDate:19:=!00-00-00!
						OBJECT SET VISIBLE:C603(*; "UpdateAssignment@"; False:C215)
						OBJECT SET ENTERABLE:C238(*; "Approve_@"; False:C215)
				End case 
				PushChange(1; ->[Work_Estimate:103]ApprovedBy:22)
				PushChange(1; ->[Work_Estimate:103]ApprovedDate:19)
				WKHR_MailReviewNotice  // Mods_2007_CM12_5301
		End case 
End case 