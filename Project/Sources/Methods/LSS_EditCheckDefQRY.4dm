//%attributes = {"invisible":true}
//Method: LSS_EditCheckDefQRY
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/19/19, 14:11:16
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//

C_BOOLEAN:C305($DeficiencyOK_B; $UrgencyOK_B; $ElementConditionOK_B; $ElementCategoriesOK_B; $ElementTextOK_B; $0)
C_BOOLEAN:C305($WeHaveCriteria_B)
$WeHaveCriteria_B:=False:C215
If (cbDeficiency=1)
	$DeficiencyOK_B:=False:C215
	//OBJECT SET VISIBLE(*;"DEF_Warning";False)
	
	Case of 
		: (vDefOp#"") & (vDef#"")
			$WeHaveCriteria_B:=True:C214
			$DeficiencyOK_B:=True:C214
		: (vDefOp#"") & (vDef="")
			//OBJECT SET VISIBLE(*;"DEF_Warning";True)
			
		: (vDefOp="") & (vDef#"")
			//OBJECT SET VISIBLE(*;"DEF_Warning";True)
			
			
	End case 
Else 
	//OBJECT SET VISIBLE(*;"DEF_Warning";False)
	
	$DeficiencyOK_B:=True:C214
End if 


If (cbUrgency=1)
	$UrgencyOK_B:=False:C215
	//OBJECT SET VISIBLE(*;"URG_Warning";False)
	
	Case of 
		: (vUrgOp#"") & (vUrg#"")
			$UrgencyOK_B:=True:C214
			$WeHaveCriteria_B:=True:C214
		: (vUrgOp#"") & (vUrg="")
			//OBJECT SET VISIBLE(*;"URG_Warning";True)
		: (vUrgOp="") & (vUrg#"")
			//OBJECT SET VISIBLE(*;"URG_Warning";True)
	End case 
Else 
	$UrgencyOK_B:=True:C214
	//OBJECT SET VISIBLE(*;"URG_Warning";False)
	
End if 


If (cbElmtCond=1)
	$ElementConditionOK_B:=False:C215
	//OBJECT SET VISIBLE(*;"CON_Warning";False)
	
	Case of 
		: (vElmtCondOp#"") & (cboElmtCond>1)
			$ElementConditionOK_B:=True:C214
			$WeHaveCriteria_B:=True:C214
		: (vElmtCondOp="") & ((cboElmtCond=0) | (cboElmtCond=1))
			$ElementConditionOK_B:=True:C214
			$WeHaveCriteria_B:=True:C214
		Else 
			//OBJECT SET VISIBLE(*;"CON_Warning";True)
			
	End case 
Else 
	//OBJECT SET VISIBLE(*;"CON_Warning";False)
	$ElementConditionOK_B:=True:C214
End if 


If (cbElementCat=1)
	$ElementCategoriesOK_B:=False:C215
	OBJECT SET VISIBLE:C603(*; "CAT_Warning"; False:C215)
	
	Case of 
		: (cboInspType=0) & (cboElem=0)
			$ElementCategoriesOK_B:=True:C214
		: (cboInspType>0)
			$ElementCategoriesOK_B:=True:C214
			$WeHaveCriteria_B:=True:C214
		Else 
			OBJECT SET VISIBLE:C603(*; "CAT_Warning"; True:C214)
	End case 
Else 
	OBJECT SET VISIBLE:C603(*; "CAT_Warning"; False:C215)
	
	$ElementCategoriesOK_B:=True:C214
End if 
If (cbElemDescTxt=1)
	$ElementTextOK_B:=False:C215
	OBJECT SET VISIBLE:C603(*; "DES_Warning"; False:C215)
	
	Case of 
		: (SRC_ELEMDESC_txt="") & (cboDescComparison=0)
			$ElementTextOK_B:=True:C214
		: (SRC_ELEMDESC_txt#"") & (cboDescComparison>0)
			$ElementTextOK_B:=True:C214
			$WeHaveCriteria_B:=True:C214
		Else 
			
			OBJECT SET VISIBLE:C603(*; "DES_Warning"; True:C214)
	End case 
Else 
	OBJECT SET VISIBLE:C603(*; "DES_Warning"; False:C215)
	$ElementTextOK_B:=True:C214
End if 

$0:=($WeHaveCriteria_B) & ($DeficiencyOK_B) & ($UrgencyOK_B) & ($ElementConditionOK_B) & ($ElementCategoriesOK_B) & ($ElementTextOK_B)
//End LSS_EditCheckDefQRY