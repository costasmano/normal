C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([Contract Invoice:84]; "ContractInvoice In")
ADD RECORD:C56([Contract Invoice:84])
vbNewRec:=False:C215
RELATE MANY:C262([Contracts:79])

ORDER BY:C49([Contract Invoice:84]; [Contract Invoice:84]InvoiceNo:2; >)