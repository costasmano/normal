//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/05, 14:49:10
	// ----------------------------------------------------
	// Method: G_Insp_FmtBDEPT_P_86
	// Description
	// Format in inspection print forms sBDEPT_P object 86 pixels wide.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM15
End if 
If ((Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Header:K2:17))
	sBDEPT_P:=sBDEPT
	Case of 
		: (Length:C16(sBDEPT)>13)
			//there are more than TWO bridge dept nums
			sBDEPT_P:=Substring:C12(sBDEPT_P; 1; 13)+Char:C90(13)+Substring:C12(sBDEPT_P; 14)
			OBJECT SET FONT SIZE:C165(*; "Bridge Dept Num"; 8)
			OBJECT SET FORMAT:C236(*; "Bridge Dept Num"; "#-##-#####-##-######-##-###")
			OBJECT MOVE:C664(*; "Bridge Dept Num"; 0; -4; 0; 12)
		: (Length:C16(sBDEPT)>6)
			//there are more than one bridge dept nums
			OBJECT SET FONT SIZE:C165(*; "Bridge Dept Num"; 9)
			OBJECT SET FORMAT:C236(*; "Bridge Dept Num"; "#-##-#####-##-###")
			//MOVE OBJECT(*;"sBDEPT@";0;4)
	End case 
End if 
