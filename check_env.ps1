Write-Host "PATH entries:"
$env:PATH -split ';' | ForEach-Object { Write-Host " - $_" }
Write-Host "Checking git command: $((Get-Command git -ErrorAction SilentlyContinue) -ne $null)"
Write-Host "Checking code command: $((Get-Command code -ErrorAction SilentlyContinue) -ne $null)"
