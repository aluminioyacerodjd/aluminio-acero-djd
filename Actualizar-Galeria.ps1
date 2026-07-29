$root = $PSScriptRoot
$imageRoot = Join-Path $root 'assets\images'
$categories = [ordered]@{
  'puertas-ventanas' = 'Puertas y ventanas'
  'vidrio-espejos' = 'Vidrio y espejos'
  'acero-barandas' = 'Acero y barandas'
  'estructuras-metalicas-disenos' = 'Estructuras metálicas y diseños'
  'interiores' = 'Interiores'
}
$extensions = @('.jpg', '.jpeg', '.png', '.webp', '.jfif')
$galleryData = [ordered]@{}

foreach ($category in $categories.Keys) {
  $categoryPath = Join-Path $imageRoot $category
  $items = @()

  if (Test-Path -LiteralPath $categoryPath) {
    $items = @(Get-ChildItem -LiteralPath $categoryPath -File | Where-Object { $extensions -contains $_.Extension.ToLowerInvariant() } | Sort-Object Name | ForEach-Object {
      $name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name) -replace '[-_]+', ' '
      $name = (Get-Culture).TextInfo.ToTitleCase($name.ToLower())
      [ordered]@{
        src = "assets/images/$category/$($_.Name)"
        title = $name
        description = $categories[$category]
      }
    })
  }

  $galleryData[$category] = $items
}

$json = $galleryData | ConvertTo-Json -Depth 5
$content = "window.galleryData = $json;"
Set-Content -LiteralPath (Join-Path $root 'gallery-data.js') -Value $content -Encoding utf8
Write-Host 'Galerías actualizadas correctamente.'
