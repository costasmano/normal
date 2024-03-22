//check for unique assignment number before saving it

C_LONGINT:C283($vlRecCount)
SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)

QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1; *)
QUERY:C277([Contract_Assignment_Maintenance:101];  & ; [Contract_Assignment_Maintenance:101]AssignNo:2=[Contract_Assignment_Maintenance:101]AssignNo:2)

If ($vlRecCount>0)
	ALERT:C41("This assignment number is already being used. Please enter a different one!")
End if 

SET QUERY DESTINATION:C396(Into current selection:K19:1)