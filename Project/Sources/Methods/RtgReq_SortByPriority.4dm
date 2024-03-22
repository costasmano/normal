//%attributes = {"invisible":true}
//Method: RtgReq_SortByPriority
//Description
//  `Sorting function to sort a rating request list by priority
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 12:05:18
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_LONGINT:C283($0)
$0:=-1

Case of 
	: ([RatingRequests:154]Priority_s:5="High")
		$0:=3
	: ([RatingRequests:154]Priority_s:5="Medium")
		$0:=2
	: ([RatingRequests:154]Priority_s:5="Low")
		$0:=1
End case 

//End RtgReq_SortByPriority