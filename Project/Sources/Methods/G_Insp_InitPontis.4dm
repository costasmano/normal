//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_InitPontis
	Mods_2005_CM06
	// Modified by: Costas Manousakis-(Designer)-(3/3/15 12:28:55)
	Mods_2015_03
	//  `radio button for engl/metric will be renamed to cbUMetricPONTIS in future - keep both references 
End if 

//Initialize Pontis form
If ([Combined Inspections:90]BMSInspID:3>0)
	//Not a valid Pontis inspection      
	OBJECT SET ENABLED:C1123(tbMetric; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(tbEnglish; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(bAddCU; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENTERABLE:C238(*; "DE cbUMetric"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "DE cbUMetricPONTIS"; True:C214)
	OBJECT SET ENABLED:C1123(*; "DE CopyPontis@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	//disable  the Add Pontis button
	OBJECT SET ENABLED:C1123(*; "DE AddPontis@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
Else 
	//Not a valid Pontis inspection      
	OBJECT SET ENABLED:C1123(tbMetric; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(tbEnglish; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(bAddCU; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENTERABLE:C238(*; "DE cbUMetric"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "DE cbUMetricPONTIS"; False:C215)
	OBJECT SET ENABLED:C1123(*; "DE CopyPontis@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	//Enable only the Add button
	OBJECT SET ENABLED:C1123(*; "DE AddPontis@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 