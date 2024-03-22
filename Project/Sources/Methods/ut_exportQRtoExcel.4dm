//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:42:11
	// ----------------------------------------------------
	// Method: ut_exportQRtoExcel
	// Description
	//  ` Loads a Quick report from a file and performs an export to an Excel XML file
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 

//Load quick report from doc
C_TEXT:C284($DocName_txt; $DocPath_txt; $TargetOutput_txt)
$DocName_txt:=Select document:C905(1; ".4qr"; "Choose Quick Report to Export to Excel"; 16)
If (OK=1)
	$DocPath_txt:=Document
	C_BLOB:C604($QRBlob_x)
	DOCUMENT TO BLOB:C525($DocPath_txt; $QRBlob_x)
	$TargetOutput_txt:=ut_CreateMSOfficeDoc(".XLS"; ".XML")
	C_LONGINT:C283($QRArea_L)
	$QRArea_L:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($QRArea_L; $QRBlob_x)
	QR SET DESTINATION:C745($QRArea_L; qr HTML file:K14903:5; $TargetOutput_txt)
	C_TEXT:C284(MyTemplate_txt)
	MyTemplate_txt:=QR Get HTML template:C751($QRArea_L)
	SET TEXT TO PASTEBOARD:C523(MyTemplate_txt)
	MyTemplate_txt:=ut_ConstructXMLSpreadSheet($QRArea_L)
	QR SET HTML TEMPLATE:C750($QRArea_L; MyTemplate_txt)
	SHORT_MESSAGE("Generating Report...")
	QR RUN:C746($QRArea_L)
	CLOSE WINDOW:C154
	QR DELETE OFFSCREEN AREA:C754($QRArea_L)
	SET BLOB SIZE:C606($QRBlob_x; 0)
	ut_OpenDocument($TargetOutput_txt)
End if 