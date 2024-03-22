FORM SET INPUT:C55([Contract_Project_Maintenance:100]; "Project Maintenance In")
ADD RECORD:C56([Contract_Project_Maintenance:100])

RELATE MANY:C262([Contract_Assignment_Maintenance:101])
ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]BridgeNo:4; >)

//QUERY([Contract_Project_Maintenance];[Contract_Project_Maintenance]ContractNo=[Contract_Maintenance]ContractNo;*)
//QUERY([Contract_Project_Maintenance]; & ;[Contract_Project_Maintenance]AssignNo=[Contract_Assignment_Maintenance]AssignNo)
//ORDER BY([Contract_Project_Maintenance];[Contract_Project_Maintenance]AssignNo;>;[Contract_Project_Maintenance]BIN;>)

