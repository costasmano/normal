RELATE MANY:C262([Contract_Assignment_Maintenance:101])

Case of 
	: (Self:C308->=1)
		//Assignment Tab
		//QUERY([Addendum_Maintenance];[Addendum_Maintenance]ContractNo=[Contract_Maintenance]ContractNo;*)
		//QUERY([Addendum_Maintenance]; & ;[Addendum_Maintenance]AssignNo=[Contract_Assignment_Maintenance]AssignNo)
		//ORDER BY([Addendum_Maintenance];[Addendum_Maintenance]AddendumNo;>)
		ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; >)
		
	: (Self:C308->=2)
		//Project Tab
		//QUERY([Contract_Project_Maintenance];[Contract_Project_Maintenance]ContractNo=[Contract_Maintenance]ContractNo;*)
		//QUERY([Contract_Project_Maintenance]; & ;[Contract_Project_Maintenance]AssignNo=[Contract_Assignment_Maintenance]AssignNo)
		//ORDER BY([Contract_Project_Maintenance];[Contract_Project_Maintenance]AssignNo;>;[Contract_Project_Maintenance]BIN;>)
		ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]BridgeNo:4; >)
		
End case 