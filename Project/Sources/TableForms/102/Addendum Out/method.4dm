If (False:C215)
	Case of 
		: (Form event code:C388=On Load:K2:1)
			QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
			QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2)
			ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; >)
	End case 
End if 
