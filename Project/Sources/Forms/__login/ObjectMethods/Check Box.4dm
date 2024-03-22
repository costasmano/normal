C_TEXT:C284($fontName_t)
Case of 
	: (Form_Show_Pass=True:C214)
		$fontName_t:="Arial"
		
	: (Form_Show_Pass=False:C215)
		$fontName_t:="%password"
		
End case 


OBJECT SET FONT:C164(*; "USR_UserPassword_t"; $fontName_t)