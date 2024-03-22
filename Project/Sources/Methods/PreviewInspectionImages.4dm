//%attributes = {"invisible":true}
If (False:C215)
	//PreviewInspectionImages    
	//Method used to do a print preview of Image for an Inspection.
	//Called from vbPrintImages button on Standard Photos form.
	//Created December 2004
	
	Mods_2004_VN04
End if 

If (Records in selection:C76([Standard Photos:36])>0)
	
	C_LONGINT:C283(vPageNo)  //Command Replaced was o_C_INTEGER
	C_BOOLEAN:C305(PrintFlag)
	vPageNo:=viSkPgStart-1
	//PrintFlag:=True
	vPrintPhotos:=1
	vPrintSketches:=1
	vPrintCharts:=1
	
	PrintPreviewImages
	PAGE BREAK:C6
	
End if 