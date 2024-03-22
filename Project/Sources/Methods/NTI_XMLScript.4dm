//%attributes = {"invisible":true,"publishedWeb":true}
//Method: NTI_XMLScript
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 11/05/15, 14:24:43
	//----------------------------------------------------
	Mods_2015_10  // 
	//Modified by: administrator (11/5/15 14:24:44)
	Compiler_NTI
	// Modified by: Costas Manousakis-(Designer)-(12/8/15 13:50:09)
	Mods_2015_12_bug
	//  `added C_TEXT($0;$1) !!
	// Modified by: Costas Manousakis-(Designer)-(4/25/17 17:35:55)
	Mods_2017_04
	//  `added NTI_D1_txt   NTI_D2_txt
End if 

C_TEXT:C284($0; $1)  //These MUST be declared for calls by 4DACTION 

If ([NTI_TunnelInfo:181]NTI_L1_s:59="N")
	NTI_L2_txt:=""
	NTI_L3_txt:=""
Else 
	NTI_L2_txt:=String:C10([NTI_TunnelInfo:181]NTI_L2_r:60)
	NTI_L3_txt:=String:C10([NTI_TunnelInfo:181]NTI_L3_r:61)
	
End if 
NTI_D1_txt:=String:C10(Month of:C24([NTI_TunnelInfo:181]NTI_D1_d:53); "00")+String:C10(Day of:C23([NTI_TunnelInfo:181]NTI_D1_d:53); "00")+String:C10(Year of:C25([NTI_TunnelInfo:181]NTI_D1_d:53); "0000")
NTI_D2_txt:=String:C10(Month of:C24([NTI_TunnelInfo:181]NTI_D2_d:54); "00")+String:C10(Day of:C23([NTI_TunnelInfo:181]NTI_D2_d:54); "00")+String:C10(Year of:C25([NTI_TunnelInfo:181]NTI_D2_d:54); "0000")

//End NTI_XMLScript