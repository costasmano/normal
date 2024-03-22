//Method: [Templates];"Input".Tools
//Description
// Tools menu for quick report templates
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 02/26/22, 08:27:44
	// ----------------------------------------------------
	//Created : 
End if 
//

C_POINTER:C301($qrarea_ptr)
$qrarea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "QRT_Template")
C_TEXT:C284($popmenu_txt)
$popmenu_txt:="Load from Record;"+\
"Load from File;"+\
"Save Quick Report to Record;"+\
"Save Quick Report to File"
C_LONGINT:C283($action_L)

$action_L:=Pop up menu:C542($popmenu_txt)

Case of 
	: ($action_L=1)
		If ($qrarea_ptr->>0)
		Else 
			QR NEW AREA:C1320($qrarea_ptr)
		End if 
		QR BLOB TO REPORT:C771($qrarea_ptr->; [Templates:86]Template_:3)
		TEMPLATE_SIZE_L:=BLOB size:C605([Templates:86]Template_:3)
		Template_Qrt_TableNo_L:=QR Get report table:C758($qrarea_ptr->)
		C_LONGINT:C283($indx)
		$indx:=Find in array:C230(Template_Qrt_TableNo_ar; Template_Qrt_TableNo_L)
		If ($indx>0)
			Template_Qrt_TableNm_ar:=$indx
		Else 
			Template_Qrt_TableNm_ar:=0
		End if 
		
	: ($action_L=2)
		C_TEXT:C284($file_txt)
		ARRAY TEXT:C222($Files_atxt; 0)
		$file_txt:=Select document:C905(""; ".4qr"; "Select a quick report to load"; 0; $Files_atxt)
		
		If (OK=1)
			$file_txt:=$Files_atxt{1}
			C_BLOB:C604($Qrblob)
			DOCUMENT TO BLOB:C525($file_txt; $Qrblob)
			If ($qrarea_ptr->>0)
			Else 
				QR NEW AREA:C1320($qrarea_ptr)
			End if 
			QR BLOB TO REPORT:C771($qrarea_ptr->; $Qrblob)
			TEMPLATE_SIZE_L:=BLOB size:C605($Qrblob)
			Template_Qrt_TableNo_L:=QR Get report table:C758($qrarea_ptr->)
			C_LONGINT:C283($indx)
			$indx:=Find in array:C230(Template_Qrt_TableNo_ar; Template_Qrt_TableNo_L)
			If ($indx>0)
				Template_Qrt_TableNm_ar:=$indx
			Else 
				Template_Qrt_TableNm_ar:=0
			End if 
			
		End if 
		
	: ($action_L=3)  // save to record
		QR REPORT TO BLOB:C770($qrarea_ptr->; [Templates:86]Template_:3)
		TEMPLATE_SIZE_L:=BLOB size:C605([Templates:86]Template_:3)
		PushChange(1; ->[Templates:86]Template_:3)
		
	: ($action_L=4)  //save to file
		C_TEXT:C284($file_txt)
		ARRAY TEXT:C222($Files_atxt; 0)
		$file_txt:=Select document:C905(""; ".4qr"; "Select a quick report to save"; File name entry:K24:17; $Files_atxt)
		If (OK=1)
			C_BLOB:C604($Qrblob)
			
			QR REPORT TO BLOB:C770($qrarea_ptr->; $Qrblob)
			BLOB TO DOCUMENT:C526($Files_atxt{1}; $Qrblob)
		End if 
		
End case 

//End [Templates];"Input".3D Button