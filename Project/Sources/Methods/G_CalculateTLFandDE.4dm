//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// Method: G_CalculateTLFandDE
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 12:32:21)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:19:59)
	Mods_2006_CM03
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDEactualRemaining; vDEactualSpent; vDEAdditional_add; vDEAdditional_transf; vDEapproxRemaining)
C_REAL:C285(vDEapproxSpent; vDEpending; vDEpending_add; vDEpending_transf; vDEupdated)
C_REAL:C285(vTLFactualRemaining; vTLFactualSpent; vTLFAdditional_add; vTLFAdditional_transf; vTLFapproxRemaining)
C_REAL:C285(vTLFapproxSpent; vTLFPending; vTLFPending_add; vTLFpending_Transf; vTLFupdated)

vDEactualRemaining:=0
vDEactualSpent:=0
vDEAdditional_add:=0
vDEAdditional_transf:=0
vDEapproxRemaining:=0
vDEapproxSpent:=0
vDEpending:=0
vDEpending_add:=0
vDEpending_transf:=0
vDEupdated:=0
vTLFactualRemaining:=0
vTLFactualSpent:=0
vTLFAdditional_add:=0
vTLFAdditional_transf:=0
vTLFapproxRemaining:=0
vTLFapproxSpent:=0
vTLFPending:=0
vTLFPending_add:=0
vTLFpending_Transf:=0
vTLFupdated:=0

CIR_RecalcAddFunds

CIR_RecalcFundTransf

//calculate spent amount
CIR_RecalcAssgnFunds(False:C215)  //don't update/Save Contracts record

C_LONGINT:C283($blackColor; $redColor)
$blackColor:=-(Black:K11:16+(256*White:K11:1))
$redColor:=-(Red:K11:4+(256*White:K11:1))

If (vTLFapproxRemaining<0)
	OBJECT SET RGB COLORS:C628(vTLFapproxRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFapproxRemaining;$redColor)
Else 
	OBJECT SET RGB COLORS:C628(vTLFapproxRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFapproxRemaining;$blackColor)
End if 

If (vTLFactualRemaining<0)
	OBJECT SET RGB COLORS:C628(vTLFactualRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFactualRemaining;$redColor)
Else 
	OBJECT SET RGB COLORS:C628(vTLFactualRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFactualRemaining;$blackColor)
End if 


If (vDEapproxRemaining<0)
	OBJECT SET RGB COLORS:C628(vDEapproxRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vDEapproxRemaining;$redColor)
Else 
	OBJECT SET RGB COLORS:C628(vDEapproxRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vDEapproxRemaining;$blackColor)
End if 

If (vDEactualRemaining<0)
	OBJECT SET RGB COLORS:C628(vDEactualRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vDEactualRemaining;$redColor)
Else 
	OBJECT SET RGB COLORS:C628(vDEactualRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vDEactualRemaining;$blackColor)
End if 