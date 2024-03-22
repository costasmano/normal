//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 14:56:09
//----------------------------------------------------
//Method: FM_RefStructureTypeInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/8/15 14:56:32)
	
End if 


C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		START TRANSACTION:C239
		
		If (Is new record:C668([LSS_refStructureTypes:171]))
			ARRAY TEXT:C222($StructCategories_atxt; 0)
			Begin SQL
				select distinct([LSS_refStructureTypes].[LSS_Category_s])
				from
				[LSS_refStructureTypes]
				into
				:$StructCategories_atxt;
				
			End SQL
			If (Find in array:C230($StructCategories_atxt; "IT")>0)
			Else 
				APPEND TO ARRAY:C911($StructCategories_atxt; "IT")
			End if 
			C_TEXT:C284($QueryBy_txt)
			$QueryBy_txt:=" "+Char:C90(1)
			C_LONGINT:C283($Loop_l)
			For ($Loop_l; 1; Size of array:C274($StructCategories_atxt))
				$QueryBy_txt:=$QueryBy_txt+$StructCategories_atxt{$Loop_l}+Char:C90(1)
			End for 
			
			$Loop_l:=Pop up menu:C542($QueryBy_txt)
			$QueryBy_txt:=$StructCategories_atxt{$Loop_l-1}
			C_TEXT:C284($Result_txt)
			
			Begin SQL
				select max([LSS_refStructureTypes].[LSS_StructureTypeId_s])
				from
				[LSS_refStructureTypes]
				where
				[LSS_refStructureTypes].[LSS_Category_s] = :$QueryBy_txt
				into
				:$Result_txt;
				
				
				
				
			End SQL
			[LSS_refStructureTypes:171]LSS_Category_s:2:=$QueryBy_txt
			$Loop_l:=Num:C11($Result_txt)
			If ($Loop_l<0)
				$Loop_l:=$Loop_l*-1
			End if 
			$Loop_l:=$Loop_l+1
			[LSS_refStructureTypes:171]LSS_StructureTypeId_s:1:=$QueryBy_txt+"-"+String:C10($Loop_l; "000")
			
			
		End if 
		OBJECT SET ENTERABLE:C238(*; "LSS_Category_s"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_Category_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_Category_s"; <>Color_Not_Editable)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)  //current table
		
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		
End case 




//End FM_RefStructureTypeInput

