If (False:C215)
	//Layout Procedure
	//[Bridge MHD NBIS];"Other Info"
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(1/4/08 12:36:35)
	Mods_2007_CM_5401
	//  `Release the curr bridge rec if the user is not part of the SIAAccess group
	// Modified by: costasmanousakis-(Designer)-(4/16/08 12:05:52)
	Mods_2008_CM_5403
	//  `Also check BRG_RWAccess; Make sure on load we start with all enabled.
	// Modified by: costasmanousakis-(Designer)-(12/24/08 10:58:28)
	Mods_2008_CM_5404
	//Added display of MPOs 
	// Modified by: costasmanousakis-(Designer)-(12/30/09 13:55:12)
	Mods_2009_12
	//  `Added checkbox field [Bridge MHD NBIS]InspRequired
	// Modified by: costasmanousakis-(Designer)-(1/13/11 12:44:30)
	Mods_2011_01
	//  `Added field [Bridge MHD NBIS]FundingSource
	// Modified by: Costas Manousakis-(Designer)-(9/11/18 14:46:53)
	Mods_2018_09_bug
	//  `added code to make Item37 editable or not here.
	// Modified by: Costas Manousakis-(Designer)-(9/12/18 17:18:29)
	Mods_2018_09_bug
	//  `change from 4D Group Historical Significance" to Personnel group SIA_Item37Edit
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(BridgeMPOList_txt)  // old C_STRING length 255
		
		//## Initialize transfer data
		InitChangeStack(1)
		
		TimeStamp_ut(->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]DateCreated:192; ->[Bridge MHD NBIS:1]TimeCreated:193; ->[Bridge MHD NBIS:1]DateModified:194; ->[Bridge MHD NBIS:1]TimeModified:195)
		OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE @")
		
		C_TEXT:C284($curuser_txt)
		$curuser_txt:=Current user:C182
		//Take control of the validation buttons based on login
		If (User in group:C338($curuser_txt; "Inspection Engineers")=False:C215)
			OBJECT SET ENABLED:C1123(bInspCheck; False:C215)  // **replaced _ o _DISABLE BUTTON(bInspCheck)
		End if 
		If (User in group:C338($curuser_txt; "Area Engineers")=False:C215)
			OBJECT SET ENABLED:C1123(bAreaCheck; False:C215)  // **replaced _ o _DISABLE BUTTON(bAreaCheck)
		End if 
		If (User in group:C338($curuser_txt; "Key Access")=False:C215)
			OBJECT SET ENABLED:C1123(bAdd; False:C215)  // **replaced _ o _DISABLE BUTTON(bAdd)
			OBJECT SET ENTERABLE:C238(*; "DE Townlines@"; False:C215)
		End if 
		
		If ((GRP_UserInGroup("SIA_Item37Edit")=1) | User in group:C338(Current user:C182; "Design Access Group"))
		Else 
			OBJECT SET ENABLED:C1123(*; "DE Variable15"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DE Variable15")
		End if 
		
		If ((Not:C34(User in group:C338($curuser_txt; "SIA Access"))) | Not:C34(BRG_RWAccess))
			OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DE @")
			SIA_ReleaseBridgeRec
		End if 
		
		BridgeMPOList_txt:=QR_RPCNames
		
	: (Form event code:C388=On Validate:K2:3)
		TimeStamp_ut(->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]DateCreated:192; ->[Bridge MHD NBIS:1]TimeCreated:193; ->[Bridge MHD NBIS:1]DateModified:194; ->[Bridge MHD NBIS:1]TimeModified:195)
		[Bridge MHD NBIS:1]Modified By:191:=Current user:C182
		//##Save changes made to file
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
End case 

QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2; >)