//object Method aDesLoads


If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (aDesLoads{aDesLoads}="H 10")
			vHS20percent:=40
		: (aDesLoads{aDesLoads}="H 15")
			vHS20percent:=60
		: (aDesLoads{aDesLoads}="HS 15")
			vHS20percent:=75
		: (aDesLoads{aDesLoads}="H 20")
			vHS20percent:=80
		: (aDesLoads{aDesLoads}="HS 20")
			vHS20percent:=100
	End case 
End if 