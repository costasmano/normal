//Method: [Town Address].View Town Address_LB.TownAddressLB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-06T00:00:00, 17:37:18
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	//  //added to handle sorting ; enabled on after sort in LB events; made all columns static
End if 
//
C_LONGINT:C283($0)
$0:=0
C_LONGINT:C283($formEvent_L)
$formEvent_L:=Form event code:C388
Case of 
	: ($formEvent_L=On Header Click:K2:40)
		C_POINTER:C301($Header_ptr)
		$Header_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		Case of 
			: ($Header_ptr=OBJECT Get pointer:C1124(Object named:K67:5; "Town"))
				If ($Header_ptr->>1)
					ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2; >)
					$Header_ptr->:=1
				Else 
					ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2; <)
					$Header_ptr->:=2
					
				End if 
				$0:=-1
				
			: ($Header_ptr=OBJECT Get pointer:C1124(Object named:K67:5; "Contact"))
				
				If ($Header_ptr->>1)
					ORDER BY:C49([Town Address:78]; [Town Address:78]ContactLName:9; >)
					$Header_ptr->:=1
				Else 
					ORDER BY:C49([Town Address:78]; [Town Address:78]ContactLName:9; <)
					$Header_ptr->:=2
					
				End if 
				$0:=-1
				
			: ($Header_ptr=OBJECT Get pointer:C1124(Object named:K67:5; "Street"))
				
			: ($Header_ptr=OBJECT Get pointer:C1124(Object named:K67:5; "Zip"))
				
		End case 
		
		UNLOAD RECORD:C212(Current form table:C627->)
		//OBJECT Get pointer(Object current)
	: ($formEvent_L=On After Sort:K2:28)
		UNLOAD RECORD:C212(Current form table:C627->)
End case 

//End [Town Address].View Town Address_LB.TownAddressLB