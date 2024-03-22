FORM SET INPUT:C55([Addendum_Maintenance:102]; "Addendum In")
ADD RECORD:C56([Addendum_Maintenance:102])

RELATE MANY:C262([Contract_Assignment_Maintenance:101])
ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; >)

//QUERY([Addendum_Maintenance];[Addendum_Maintenance]ContractNo=[Contract_Maintenance]ContractNo;*)
//QUERY([Addendum_Maintenance]; & ;[Addendum_Maintenance]AssignNo=[Contract_Assignment_Maintenance]AssignNo)
//ORDER BY([Addendum_Maintenance];[Addendum_Maintenance]AddendumNo;>)

//CM_CalculateNegotiatedCosts 

