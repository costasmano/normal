//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/05, 15:54:06
	// ----------------------------------------------------
	// Method: G_Insp_FmtBDEPT_P_107
	// Description
	// Format in inspection print forms sBDEPT_P object 107 pixels wide.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM15
End if 
If ((Form event code:C388=On Header:K2:17) | (Form event code:C388=On Printing Detail:K2:18))
	sBDEPT_P:=sBDEPT
	Case of 
		: (Length:C16(sBDEPT)>13)
			OBJECT SET FONT SIZE:C165(*; "Brg Dept@"; 9)
			sBDEPT_P:=Substring:C12(sBDEPT_P; 1; 13)+Char:C90(13)+Substring:C12(sBDEPT_P; 14)
			OBJECT SET FORMAT:C236(*; "Brg Dept@"; "#-##-#####-##-######-##-###")
			OBJECT MOVE:C664(*; "Brg Dept@"; 0; -5; 0; 10)
		: (Length:C16(sBDEPT)>6)
			OBJECT SET FONT SIZE:C165(*; "Brg Dept@"; 10)
			//SET FORMAT(*;"Brg Dept@";(13*"#"))
			
	End case 
End if 