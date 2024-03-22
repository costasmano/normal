//%attributes = {"invisible":true}
C_LONGINT:C283($LBCol_L; $LBRow_L)
LISTBOX GET CELL POSITION:C971(*; "PHotos_LB"; $LBCol_L; $LBRow_L)
If ($LBRow_L>0)
	GOTO SELECTED RECORD:C245([LSS_Photos:166]; $LBRow_L)
	
	BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_Picture_pct)
	UNLOAD RECORD:C212([LSS_Photos:166])
	
End if 