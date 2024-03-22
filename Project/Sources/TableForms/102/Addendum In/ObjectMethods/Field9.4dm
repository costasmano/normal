//check for unique addendum number before saving it

C_LONGINT:C283($vlRecCount)
SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)

QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2; *)
QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AddendumNo:2=[Addendum_Maintenance:102]AddendumNo:2)

If ($vlRecCount>0)
	ALERT:C41("This addendum number is already being used. Please enter a different one!")
End if 

SET QUERY DESTINATION:C396(Into current selection:K19:1)