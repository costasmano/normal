//%attributes = {"invisible":true}
C_LONGINT:C283($blackColor; $redColor)
$blackColor:=-(Black:K11:16+(256*White:K11:1))
$redColor:=-(Red:K11:4+(256*White:K11:1))

If ([Contract_Maintenance:97]ApproxRemainingFund:19<0)
	OBJECT SET RGB COLORS:C628([Contract_Maintenance:97]ApproxRemainingFund:19; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR([Contract_Maintenance]ApproxRemainingFund; $redColor)
Else 
	OBJECT SET RGB COLORS:C628([Contract_Maintenance:97]ApproxRemainingFund:19; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR([Contract_Maintenance]ApproxRemainingFund; $blackColor)
End if 

If ([Contract_Maintenance:97]ActualRemainingFund:20<0)
	OBJECT SET RGB COLORS:C628([Contract_Maintenance:97]ActualRemainingFund:20; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR([Contract_Maintenance]ActualRemainingFund; $redColor)
Else 
	OBJECT SET RGB COLORS:C628([Contract_Maintenance:97]ActualRemainingFund:20; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR([Contract_Maintenance]ActualRemainingFund; $blackColor)
End if 