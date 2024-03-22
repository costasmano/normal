If (False:C215)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:07:19)
End if 
//[Inspections];"Pontis Form"
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		//set the title
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; False:C215)
				
			Else 
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; True:C214)
				
		End case 
		
		START TRANSACTION:C239
		
		vInspTitle:=G_Insp_SetTitle
		InitChangeStack(1)
		InitChangeStack(2)
		InitChangeStack(3)
		InitChangeStack(4)
		
		//Initialize Pontis form
		If ([BMS Inspections:44]Metric:14)
			tbMetric:=1
			tbEnglish:=0
		Else 
			tbMetric:=0
			tbEnglish:=1
		End if 
		//Check on security...
		G_SecureInspection
		RememberCombined
		DISPL_CUs
		If (vbInspectionLocked)
			//disable entry if inspection is locked
			G_Insp_LockFormOnOff(True:C214)
		Else 
			//otherwise make sure they are enterable    
			G_Insp_LockFormOnOff(False:C215)
		End if 
		G_Insp_SetPersUI
		C_BOOLEAN:C305($UseLB_B)
		$UseLB_B:=ut_UseListBox("ListOfPontisElements")
		If ($UseLB_B)
			OBJECT SET VISIBLE:C603(*; "ListOfPontisElements"; True:C214)
			OBJECT SET VISIBLE:C603(*; "DE btnCUAdd"; False:C215)
			OBJECT SET VISIBLE:C603(*; "subFormCU"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE cbCU@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "ListOfPontisElements"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE btnCUAdd"; True:C214)
			OBJECT SET VISIBLE:C603(*; "subFormCU"; True:C214)
			OBJECT SET VISIBLE:C603(*; "DE cbCU@"; True:C214)
			
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		RememberCombined
		
End case 