//%attributes = {"invisible":true}
C_LONGINT:C283($blackColor; $redColor)
$blackColor:=-(Black:K11:16+(256*White:K11:1))
$redColor:=-(Red:K11:4+(256*White:K11:1))

If ([Contracts:79]ApproxRemainingFund:19<0)
	OBJECT SET RGB COLORS:C628([Contracts:79]ApproxRemainingFund:19; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ApproxRemainingFund; $redColor)
Else 
	OBJECT SET RGB COLORS:C628([Contracts:79]ApproxRemainingFund:19; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ApproxRemainingFund; $blackColor)
End if 

If ([Contracts:79]ActualRemainingFund:20<0)
	OBJECT SET RGB COLORS:C628([Contracts:79]ActualRemainingFund:20; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ActualRemainingFund; $redColor)
Else 
	OBJECT SET RGB COLORS:C628([Contracts:79]ActualRemainingFund:20; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ActualRemainingFund; $blackColor)
End if 