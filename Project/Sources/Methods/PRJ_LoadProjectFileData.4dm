//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadProjectFileData
// User name (OS): cjmiller
// Date and time: 03/24/06, 10:39:40
// ----------------------------------------------------
// Description
// This method will make sure that the correct project file record is loaded
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/30/07 ` add ability to select by design contract
	Mods_2007_CJM_v5310
	// Modified by: ManousakisC (6/15/2007)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5310  //06/28/07 `Make sure amounts display blank `Add new variables to display ad cost and project total
	// Modified by: costasmanousakis-(Designer)-(9/17/2007 14:50:09)
	Mods_2007_CM12_5301
	Mods_2008_December  //CJM `r001    `12/17/08, 15:56:55 ``Add new page to project input form with project file and design contract information    
End if 

RELATE ONE:C42([PRJ_ProjectDetails:115]PF_FileID_l:3; [PRJ_ProjectFile:117]PF_FileID_l:1)
PRJ_PFDescription_txt:=""
PRJ_DEProjectFileNo_l:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
PRJ_SelectByDesignContract_l:=0
If (PRJ_DEProjectFileNo_l<=0)
	OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; True:C214)
Else 
	OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; False:C215)
End if 

If (Records in selection:C76([PRJ_ProjectFile:117])=0)
	PRJ_AdvertisingDate_s:=""
	PRJ_ActualAdvertisedDate_s:=""
	PRJ_EstimatedBid_txt:=""
	PRJ_AdCost_txt:=""
	PRJ_TotalProjCost_txt:=""
Else 
	PRJ_PFDescription_txt:=[PRJ_ProjectFile:117]PF_Description_txt:16
	If ([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5=!00-00-00!)
		PRJ_AdvertisingDate_s:=""
	Else 
		PRJ_AdvertisingDate_s:=String:C10([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; 7)
	End if 
	If ([PRJ_ProjectFile:117]PF_Advertised_d:14=!00-00-00!)
		PRJ_ActualAdvertisedDate_s:=""
	Else 
		PRJ_ActualAdvertisedDate_s:=String:C10([PRJ_ProjectFile:117]PF_Advertised_d:14; 7)
	End if 
	PRJ_EstimatedBid_txt:=String:C10(Round:C94([PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8; 2); "$###,###,###,##0.00;;")
	PRJ_AdCost_txt:=String:C10(Round:C94([PRJ_ProjectFile:117]PF_CostAd_r:9; 2); "$###,###,###,##0.00;;")
	PRJ_TotalProjCost_txt:=String:C10(Round:C94([PRJ_ProjectFile:117]PF_EstTotalCost_r:10; 2); "$###,###,###,##0.00;;")
End if 
//End PRJ_LoadProjectFileData