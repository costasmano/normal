
If (False:C215)
	
	
End if 
NTI_i9_L_atxt:=Find in array:C230(NTI_i9_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_i9_L:14)+"@")

If (NTI_i9_L_atxt<1)
	NTI_i9_L_atxt:=0
	NTI_i9_L_atxt{0}:="Select Route Type"
End if 
