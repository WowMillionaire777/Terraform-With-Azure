
Connect-AzAccount

$location="North Europe"
$PublisherName="MicrosoftSQLServer"
Get-AzVMImageOffer -Location $location -PublisherName $PublisherName | Select Offer


$offerName="sql2019-ws2019"
Get-AzVMImageSku -Location $location -PublisherName $PublisherName -Offer $offerName | Select Skus


$skuName="sqldev"
Get-AzVMImage -Location $location  -PublisherName $PublisherName -Offer $offerName -Sku $skuName | Select Version


$Version="15.0.220510"