If (False:C215)
	// Method: Object Method: [Inspections].InspectionReview.SorttmLdr
	// Description
	// 
	// Modified by: Costas Manousakis-(Designer)-(10/31/13 16:04:34)
	Mods_2013_10
	//  `  `  `loop thru the aPtrSortOrder  array to set the other sort variables to 0
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(128)
		INSP_SortByTmLeader(Self:C308->)
		If ((Self:C308->=0) | (Self:C308->=1))
			Self:C308->:=1
		End if 
		If (Type:C295(aPtrSortOrder)=Pointer array:K8:23)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(aPtrSortOrder))
				aPtrSortOrder{$loop_L}->:=0
			End for 
		End if 
		ARRAY POINTER:C280(aPtrSortField; 0)
		ARRAY POINTER:C280(aPtrSortOrder; 0)
		SET CURSOR:C469(0)
		vbSortedHeader:=True:C214
		REDRAW WINDOW:C456
		
	: ((Form event code:C388=On Header:K2:17) & Not:C34(vbSortedHeader))
		If (SorttmLdr>0)
			INSP_SortByTmLeader(SorttmLdr)
			REDRAW WINDOW:C456
		End if 
		
End case 