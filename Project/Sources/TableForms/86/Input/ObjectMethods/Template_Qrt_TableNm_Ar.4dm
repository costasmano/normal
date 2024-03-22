If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 11:30:24      ` Type all local variables for v11
End if 
C_LONGINT:C283($Current_tblNo)

POPUPMENUC(->Template_Qrt_TableNm_ar; ->Template_Qrt_TableNo_ar; ->Template_Qrt_TableNo_L)
$Current_tblNo:=QR Get report table:C758(QRT_Template)
If ($Current_tblNo#Template_Qrt_TableNo_L)
	QR SET REPORT TABLE:C757(QRT_Template; Template_Qrt_TableNo_L)
End if 
