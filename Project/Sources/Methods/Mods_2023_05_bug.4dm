//%attributes = {"invisible":true}
//Method: Mods_2023_05_bug
If (False:C215)
	
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2023-05-03)

// [Standard Photos];"Standard Photos".PrintButton
//  `for print preview - save the flag when choice is made and use it right before printing.

//**********`Modified by: Costas Manousakis-(Designer)-(2023-05-04)
// INSP_GetConsProjMgr
//  `added missing [Personnel].EmailAddress_s from the SQL select - array $Emails_atxt was not getting filled

//**********`Modified by: Costas Manousakis-(Designer)-(2023-05-10)
// ut_OpenProjInfo_OM
//  `check if the projectinfo site is available on the network ; minor code changes


//```
//```    **** End 
//```


//```
//```    **** End of version sent to 4D for conversion to v19.
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2023-05-25)
// LSS_PrintMultipleInspections - copied from V18bug 2023-09-19
//  `fix/adjustments when printing to pdf - adjust for mac or windows pdf printers.
//  `  logic does not work with PDF Report writer. 
//  `if printing to pdf show the last created pdf at the end


//End Mods_2023_05_bug   