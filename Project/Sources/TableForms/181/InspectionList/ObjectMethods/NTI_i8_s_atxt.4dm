
If (False:C215)
	
End if 
NTI_i8_s_atxt:=0
If ([NTI_TunnelInfo:181]NTI_i8_s:13#"")
	NTI_i8_s_atxt:=Find in array:C230(NTI_i8_s_atxt; [NTI_TunnelInfo:181]NTI_i8_s:13+"@")
End if 
If (NTI_i8_s_atxt<1)
	NTI_i8_s_atxt:=0
	NTI_i8_s_atxt{0}:="Select Route Direction"
End if 

//End NTI_i8_s_atxt

