If (False:C215)
	Mods_2005_CM06
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(1/8/2007 14:04:45)
	Mods_2007_CM02
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(vlPrintInspRptDlgWID)
		vlPrintInspRptDlgWID:=Frontmost window:C447
		C_BOOLEAN:C305(bSpecMemPgsFlag; bCmtsFlag; bPhotoFlag; bSketchFlag; bChartFlag; bPontisFlag)
		C_LONGINT:C283(viNumPg1s)  //Command Replaced was o_C_INTEGER
		vPrintPage1:=1
		If (([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="OTH") | ([Inspections:27]Insp Type:6="DAM"))
			If (viNumPg1s>1)
				OBJECT SET TITLE:C194(vPrintPage1; "Print Page 1s ("+String:C10(viNumPg1s)+")")
			End if 
		End if 
		If (bSpecMemPgsFlag)
			vPrintSPMemPgs:=1
		Else 
			OBJECT SET VISIBLE:C603(vPrintSPMemPgs; False:C215)
			OBJECT MOVE:C664(*; "Lower@"; 0; -23; 0; 0)
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
	: (Form event code:C388=On Deactivate:K2:10)
		BRING TO FRONT:C326(Current process:C322)
		SHOW WINDOW:C435(vlPrintInspRptDlgWID)
End case 