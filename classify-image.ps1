$predictionUrl="https://josh-explore-computer-vision.cognitiveservices.azure.com/customvision/v3.0/Prediction/4148c2e1-d636-4681-a754-07cc6d515228/classify/iterations/animals/url"
$predictionKey = "5dd748ea8b064171b802813c91b9616a"


# Code to call Custom Vision service for image classification

$img_num = 1
if ($args.count -gt 0 -And $args[0] -in (1..3))
{
    $img_num = $args[0]
}

$img = "https://raw.githubusercontent.com/JosueAfouda/Azure-Cognitive-Services/main/data/vision/animals/animal-$($img_num).jpg"

$headers = @{}
$headers.Add( "Prediction-Key", $predictionKey )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri $predictionUrl `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$prediction = $result | ConvertFrom-Json

Write-Host ("`n",$prediction.predictions[0].tagName, "`n")
