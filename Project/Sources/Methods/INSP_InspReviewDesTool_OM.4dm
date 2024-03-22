//%attributes = {"invisible":true}
//Method: INSP_InspReviewDesTool_OM
//Description
// object method for the designer tools button in the inspection review form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/19/21, 20:01:44
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-28T00:00:00 17:15:46)
	Mods_2021_10_bug
	//  `change from execute method to EXECUTE FORMULA
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37)
		//always show popup menu
		ARRAY TEXT:C222($names_atxt; 0)
		ARRAY TEXT:C222($methods_atxt; 0)
		Begin SQL
			select 
			[zSpecialReports].[ReportName]
			,[zSpecialReports].[MethodName]
			from [zSpecialReports]
			where 
			[zSpecialReports].[Purpose] = 'INSPReviewDesTools'
			into :$names_atxt , :$methods_atxt ;
		End SQL
		If (Size of array:C274($names_atxt)>0)
			C_TEXT:C284($menu_txt; $command_txt)
			$menu_txt:=MENU_BuildMenuFromArrays(->$names_atxt; ->$methods_atxt; "")
			$command_txt:=Dynamic pop up menu:C1006($menu_txt)
			RELEASE MENU:C978($menu_txt)
			If ($command_txt#"")
				EXECUTE FORMULA:C63($command_txt)
			End if 
		End if 
		
End case 

//End INSP_InspReviewDesTool_OM