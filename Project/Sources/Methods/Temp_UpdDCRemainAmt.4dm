//%attributes = {"invisible":true}
//If (False)
//  ` ----------------------------------------------------
//  ` User name (OS): costasmanousakis
//  ` User name (4D): Designer
//  ` Date and time: 05/24/07, 11:28:40
//  ` ----------------------------------------------------
//  ` Method: Temp_UpdDCRemainAmt
//  ` Description
//  ` Update the amt remaining in design contracts
//  ` 
//  ` Parameters
//  ` ----------------------------------------------------
//
//Mods_2007_CM10 
//End if 
//ALL RECORDS([PRJ_DesignContracts])
//FIRST RECORD([PRJ_DesignContracts])
//While (Not(End selection([PRJ_DesignContracts])))
//If (ut_LoadRecordInteractive (->[PRJ_DesignContracts]))
//If ([PRJ_DesignContracts]DC_FromSQL_b)
//[PRJ_DesignContracts]DC_RemainingAmount_r:=[PRJ_DesignContracts]DC_ESTContractAmt_r-[PRJ_DesignContracts]DC_ActualAmount_r  `Mods_PRJSELECTION
//SAVE RECORD([PRJ_DesignContracts])
//End if 
//End if 
//NEXT RECORD([PRJ_DesignContracts])
//End while 
