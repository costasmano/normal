//%attributes = {"invisible":true}
If (False:C215)
	//procedure: GetKey
	//by Albert Leung
	//date: 2/6/97
	//purpose: return key code for keypressed
	
	Mods_2005_CM15
End if 
If (Type:C295(Keycode)=Is undefined:K8:13)
	KeyCode:=0
End if 
<>Key:=KeyCode
FILTER EVENT:C321