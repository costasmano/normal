//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/27/15, 15:09:21
//----------------------------------------------------
//Method: NTI_FillDropDowns
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/27/15 15:09:22)
	
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	// Modified by: Costas Manousakis-(Designer)-(12/8/15 11:36:02)
	Mods_2015_12_bug
	//  `fixed select for Town Data to get the Place code
	Mods_2017_12  //Add comment types for NTI Inspections
	//Add code to allow for nti inspection comment types
	//Modified by: Chuck Miller (12/21/17 14:37:40)
	
End if 
Begin SQL
	
	select
	[Town Data].[Town Name],
	CONCAT(CONCAT(CONCAT(CONCAT([Town Data].[County Code],'-'), CONCAT([Town Data].[District],'-')), CONCAT([Town Data].Place_Code,'-')),  [Town Data].[BDEPT Prefix])
	from
	[Town Data]
	ORDER BY 1 ASC
	into
	:NTI_TownName_atxt, :NTI_Codes_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l] 
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_i8_s'
	ORDER BY 2 ASC
	into 
	:NTI_i8_s_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_i9_L'
	ORDER BY 2 ASC
	into 
	:NTI_i9_L_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_A8_L'
	ORDER BY 2 ASC
	into 
	:NTI_A8_L_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_C1_s'
	ORDER BY 2 ASC
	into 
	:NTI_C1_s_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_C3_s'
	ORDER BY 2 ASC
	into 
	:NTI_C3_s_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_C4_s'
	ORDER BY 2 ASC
	into 
	:NTI_C4_s_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_C7_L'
	ORDER BY 2 ASC
	into  :NTI_C7_L_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_C8_s'
	ORDER BY 2 ASC
	into 
	:NTI_C8_s_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_L1_s'
	ORDER BY 2 ASC
	into 
	:NTI_L1_s_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_L4_s'
	ORDER BY 2 ASC
	into 
	:NTI_L4_s_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'NTI_S2_L'
	ORDER BY 2 ASC
	into 
	:NTI_S2_L_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_S3_L'
	ORDER BY 2 ASC
	into 
	:NTI_S3_L_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_S4_L'
	ORDER BY 2 ASC
	into 
	:NTI_S4_L_atxt;
	
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_N3_s'
	ORDER BY 2 ASC
	into 
	:NTI_N3_s_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_TunnelID_s'
	ORDER BY 2 ASC
	into 
	:NTI_TunnelID_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_VentID_s'
	ORDER BY 2 ASC
	into 
	:NTI_VentID_atxt;
	
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l]
	from 
	[TableOfLists]
	
	where
	[TableOfLists].[ListName_s] = 'NTI_Owner_s'
	ORDER BY 2 ASC
	into 
	:NTI_Owner_atxt;
	
	
	
End SQL

COPY ARRAY:C226(NTI_C1_s_atxt; NTI_C2_s_atxt)
//End NTI_FillDropDowns

