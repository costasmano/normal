//object method vHS20percent  

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Load:K2:1))
	Case of 
		: (vHS20percent=40)
			aDesLoads:=1
		: (vHS20percent=60)
			aDesLoads:=2
		: (vHS20percent=75)
			aDesLoads:=3
		: (vHS20percent=80)
			aDesLoads:=4
		: (vHS20percent=100)
			aDesLoads:=5
		Else 
			aDesLoads:=6
	End case 
	
End if 