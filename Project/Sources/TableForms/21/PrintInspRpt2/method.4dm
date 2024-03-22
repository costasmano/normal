If (False:C215)
	//Form Method: [Dialogs];"PrintInspRpt2"
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(1/8/2007 13:49:04)
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(6/7/16 14:08:21)
	Mods_2016_06
	//  `Added case if inspection type is T@ (Tunnel inspection) to change print label to NTE
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(bCmtsFlag; bSpecMemPgsFlag; bPhotoFlag; bSketchFlag; bChartFlag; bPontisFlag; bInvPhotoFlag)  //chng.2007..
		C_LONGINT:C283(vlPrintInspRptDlgWID)
		vlPrintInspRptDlgWID:=Frontmost window:C447
		vPrintPage1:=1
		vPrintPage2:=1
		If (bSpecMemPgsFlag)
			vPrintSpMemPgs:=1
		Else 
			vPrintSpMemPgs:=0
			OBJECT SET VISIBLE:C603(vPrintSpMemPgs; False:C215)
			OBJECT MOVE:C664(*; "Lower@"; 0; -22; 0; 0)
		End if 
		//chng.2007..
		If (bInvPhotoFlag)
			vPrintInvPhotos:=0
			aInvPhotoDate_aD:=0
		Else 
			vPrintInvPhotos:=0
			OBJECT SET VISIBLE:C603(vPrintInvPhotos; False:C215)
			OBJECT SET VISIBLE:C603(aInvPhotoDate_aD; False:C215)
			OBJECT MOVE:C664(*; "Lower Inv@"; 0; -22; 0; 0)
		End if 
		//\End Chg
		If (bCmtsFlag)
			vPrintCmts:=1
		Else 
			vPrintCmts:=0
		End if 
		
		If (bPhotoFlag)
			vPrintPhotos:=1
		Else 
			vPrintPhotos:=0
		End if 
		If (bSketchFlag)
			vPrintSketches:=1
		Else 
			vPrintSketches:=0
		End if 
		If (bChartFlag)
			vPrintCharts:=1
		Else 
			vPrintCharts:=0
		End if 
		If (bPontisFlag)
			vPrintPontis:=1
		Else 
			vPrintPontis:=0
		End if 
		
		vPrintPontisField:=0
		
		vPrintSIA:=0
		vPrintPreview:=0
		If ([Inspections:27]Insp Type:6="T@")  //Tunnel inspections
			OBJECT SET TITLE:C194(vPrintPontis; "Print NTEs")
			OBJECT SET TITLE:C194(vPrintPontisField; "Print NTEs Field Form")
		End if 
	: (Form event code:C388=On Deactivate:K2:10)
		BRING TO FRONT:C326(Current process:C322)
		SHOW WINDOW:C435(vlPrintInspRptDlgWID)
End case 
