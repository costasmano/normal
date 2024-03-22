If (False:C215)
	//Form Method: [Inspections]DisplayCoRE 
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//Initialize Pontis form
		If ([BMS Inspections:44]Metric:14)
			tbMetric:=1
			tbEnglish:=0
		Else 
			tbMetric:=0
			tbEnglish:=1
		End if 
		DISPL_CUs
	: (Form event code:C388=On Display Detail:K2:22)
		display_1cuLB
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
End case 