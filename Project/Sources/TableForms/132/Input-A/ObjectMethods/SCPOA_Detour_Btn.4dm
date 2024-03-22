If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($numpics_L)
SCPOA_ImageHandle("DETOUR"; Form event code:C388)
SET QUERY DESTINATION:C396(Into variable:K19:4; $numpics_L)
QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="Detour")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($numpics_L>0)
	SCPOA_DetourAttach_L:=1
Else 
	SCPOA_DetourAttach_L:=0
End if 
