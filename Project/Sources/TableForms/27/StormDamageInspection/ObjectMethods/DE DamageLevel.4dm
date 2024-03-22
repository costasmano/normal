Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($choise_L)
		$choise_L:=0
		Case of 
			: ([Inspections:27]CollisionDamSup:13="1")
				$choise_L:=1
			: ([Inspections:27]CollisionDamSup:13="2")
				$choise_L:=2
			: ([Inspections:27]CollisionDamSup:13="3")
				$choise_L:=3
			: ([Inspections:27]CollisionDamSup:13="4")
				$choise_L:=4
				
		End case 
		Self:C308->:=$choise_L
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($choise_L)
		$choise_L:=Self:C308->
		
		Case of 
			: ($choise_L=1)
				[Inspections:27]CollisionDamSup:13:="1"
			: ($choise_L=2)
				[Inspections:27]CollisionDamSup:13:="2"
			: ($choise_L=3)
				[Inspections:27]CollisionDamSup:13:="3"
			: ($choise_L=4)
				[Inspections:27]CollisionDamSup:13:="4"
		End case 
		
		PushChange(1; ->[Inspections:27]CollisionDamSup:13)
End case 