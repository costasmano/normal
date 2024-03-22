//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/30/07, 12:29:55
	// ----------------------------------------------------
	// Method: PRJ_DC_OpenProjectDetail
	// Description
	// 
	// 
	// Parameters
	// $1 : Related Table ptr
	// $2 : Selection Counter _L
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
	Mods_2008_CM_5404  // ("ACCESS")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
End if 
C_POINTER:C301($1)
C_LONGINT:C283($2)
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			If ($2>0)
				If (User in group:C338(Current user:C182; "ReadOnly"))
				Else 
					C_BOOLEAN:C305($RecordLoaded_B)
					GOTO SELECTED RECORD:C245([PRJ_ProjectDetails:115]; $2)
					READ WRITE:C146($1->)
					$RecordLoaded_B:=ut_LoadRecord($1)
					If ($RecordLoaded_B)
						COPY NAMED SELECTION:C331([PRJ_DesignContracts:123]; "DesContractsPreEntry")
						PUSH RECORD:C176([PRJ_DesignContracts:123])
						If (Not:C34(Is compiled mode:C492))
							Compiler_PRJ
							Compiler_LSTS
							Compiler_SQL
						End if 
						If (Table:C252($1)=Table:C252(->[PRJ_ProjectDetails:115]))
							PRJ_LoadDropDownLists
							ARRAY TEXT:C222(PRJ_ConsultantFNames_atxt; 0)
							ARRAY TEXT:C222(PRJ_ConsultantLNames_atxt; 0)
							ARRAY LONGINT:C221(PRJ_ConsultantIDs_al; 0)
							ALL RECORDS:C47([Conslt Address:77])
							SELECTION TO ARRAY:C260([Conslt Address:77]ConsltAddressID:1; PRJ_ConsultantIDs_al; [Conslt Address:77]ContactFName:3; PRJ_ConsultantFNames_atxt; [Conslt Address:77]ContactLName:4; PRJ_ConsultantLNames_atxt)
						End if 
						
						MODIFY RECORD:C57($1->)
						READ WRITE:C146([PRJ_DesignContracts:123])
						USE NAMED SELECTION:C332("DesContractsPreEntry")
						CLEAR NAMED SELECTION:C333("DesContractsPreEntry")
						POP RECORD:C177([PRJ_DesignContracts:123])
					End if 
				End if 
			End if 
			
		End if 
		
End case 