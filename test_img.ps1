[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
try {
    $data = $wc.DownloadData('https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=100')
    Write-Host "Success, downloaded bytes: $($data.Length)"
} catch {
    Write-Host "Error: $_"
}
