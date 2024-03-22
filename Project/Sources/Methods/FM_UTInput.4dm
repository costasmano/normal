//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 12:10:08
//----------------------------------------------------
//Method: FM_UTInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 12:28:30)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		InitChangeStack(9)  //[LSS_UT]
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_UT];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		
		C_BOOLEAN:C305($Buttons_B)
		$Buttons_B:=True:C214
		
		If (Is new record:C668([LSS_UT:175]))
			$Buttons_B:=False:C215
			
			[LSS_UT:175]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			C_LONGINT:C283($ID_L)
			
			Inc_Sequence("LSS_UTId_s"; ->$ID_L)
			[LSS_UT:175]LSS_UTId_s:1:=String:C10($ID_L; <>KeyMask_s)
			
			LSS_SetUpButtonsForNewRecords
		Else 
			LSS_SetPrevNextButtons(LSS_UTRow_L; Records in selection:C76([LSS_UT:175]))
			
		End if 
		
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
				
			: (Not:C34(LSS_EditingInspection_B))
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (User in group:C338(Current user:C182; "Design Access Group"))
				$Entry_b:=True:C214
			: (Read only state:C362([LSS_UT:175]))
			Else 
				$Entry_b:=True:C214
				
		End case 
		OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_StructureTypeDesc_atxt"; $Entry_b)
		
		OBJECT SET ENTERABLE:C238(*; "LSS_@"; $Entry_b)
		
		OBJECT SET ENTERABLE:C238(*; "LSS_ID@"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_ID@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_ID@"; <>Color_Not_Editable)
		ARRAY TEXT:C222(LSS_StructureTypeDesc_atxt; 0)
		ARRAY TEXT:C222(LSS_StructureTypeIDs_atxt; 0)
		C_TEXT:C284($Category_txt)
		$Category_txt:="UT"
		Begin SQL
			select [LSS_refStructureTypes].[LSS_StructureTypeId_s],
			[LSS_refStructureTypes].[LSS_Description_txt]
			from
			[LSS_refStructureTypes]
			where
			[LSS_refStructureTypes].[LSS_Category_s] = :$Category_txt
			into
			:LSS_StructureTypeIDs_atxt, :LSS_StructureTypeDesc_atxt;
			
		End SQL
		
		LSS_SelectUTResults_New
		
		
		
End case 
//End FM_UTInput

