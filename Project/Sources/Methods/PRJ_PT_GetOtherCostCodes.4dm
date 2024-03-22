//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/07, 17:24:12
	// ----------------------------------------------------
	// Method: PRJ_PT_GetOtherCostCodes
	// Description
	// Get the other cost codes.
	// Other Cost codes are stored in table [TableOfLists].
	// The List name is "OtherCostCodes"
	// The Value format should be coded as <CostcodeName [EWO]>
	// The sequence value in the [TableOfLists]ListSequence_l is used as a unique project ID.
	// They should be unique to easily differentiate things.
	//
	// This routine parses the values in the table.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_TimeTracking
End if 
QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="OtherCostCodes")
ARRAY TEXT:C222($OtherCostCodesV_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222(PT_CostCodeName_atxt; 0)
ARRAY TEXT:C222(PT_CostCodeEWO_atxt; 0)
ARRAY LONGINT:C221(PT_CostCodeIDs_aL; 0)
SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $OtherCostCodesV_as; [TableOfLists:125]ListSequence_l:3; PT_CostCodeIDs_aL)
SORT ARRAY:C229($OtherCostCodesV_as; PT_CostCodeIDs_aL)
C_LONGINT:C283($i; $BracketStart_L; $BracketEnd_L)
ARRAY TEXT:C222(PT_CostCodeName_atxt; Size of array:C274($OtherCostCodesV_as))
ARRAY TEXT:C222(PT_CostCodeEWO_atxt; Size of array:C274($OtherCostCodesV_as))
For ($i; 1; Size of array:C274($OtherCostCodesV_as))
	$BracketStart_L:=Position:C15("["; $OtherCostCodesV_as{$i})
	Case of 
		: ($BracketStart_L>1)
			PT_CostCodeName_atxt{$i}:=Substring:C12($OtherCostCodesV_as{$i}; 1; $BracketStart_L-1)
			$OtherCostCodesV_as{$i}:=Substring:C12($OtherCostCodesV_as{$i}; ($BracketStart_L+1))
			$BracketEnd_L:=Position:C15("]"; $OtherCostCodesV_as{$i})
			Case of 
				: ($BracketEnd_L>1)
					PT_CostCodeEWO_atxt{$i}:=Substring:C12($OtherCostCodesV_as{$i}; 1; $BracketEnd_L-1)
					
				: ($BracketEnd_L=1)
					//blank
				: ($BracketEnd_L<=0)  //not found
					If (Length:C16($OtherCostCodesV_as{$i})>0)
						PT_CostCodeEWO_atxt{$i}:=$OtherCostCodesV_as{$i}
					End if 
					
			End case 
			
		: ($BracketStart_L=1)
			
		Else 
			PT_CostCodeName_atxt{$i}:=$OtherCostCodesV_as{$i}
			
	End case 
	
End for 

ARRAY TEXT:C222($OtherCostCodesV_as; 0)  //Command Replaced was o_ARRAY string length was 80