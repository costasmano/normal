//%attributes = {"invisible":true}
//Method: Mods_2017_12_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/01/17, 14:23:36
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(12/1/17)
// BrgRank_DoRankCalc
//  `added DOM tree BridgeRankHIChgByAvgCond_txt - used in PM_GetPctDeteriorationByRunDate 
//  `to get an HI change when there are no data for the current bridge record.
//  `the dom has pairs of avg bridge cond and avg HI change. the avg bridge cond is 0,1,2,3,4,5,6,7,8,9  
//  `avg cond = 10 is the overall average of HI change
//  `fixed bad calculation of the Bridge condition category - use the reported value

// PM_GetPctDeteriorationByRunDate
//  `if nothing found in the [Pontis_Metric_Data] table try to use the averages in DOM tree BridgeRankHIChgByAvgCond_txt
//  `added 3rd parameter for the Average bridge condition
//  `changed 2nd param to text

// BridgeRankingCalculation
//  `add the BridgeRankingAvgCondition to the call to PM_GetPctDeteriorationByRunDate

//```
//```    **** End of Release 7.0.2.a 01-Dec-2017
//```

//**********`Modified by: Costas Manousakis-(Designer)-(12/13/17)
// NTI_LoadElementHelp
//  `fixed case if there are no Defects listed for the element in the defect tree - 
//  `in our case for  'rollup' elements. 

//End Mods_2017_12_bug