$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")

try {
    $listener.Start()
    Write-Output "KathiravanMart local server listening on http://localhost:8080/"

    while ($listener.IsListening) {
        try {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response
            
            $urlPath = $request.Url.LocalPath
            $cssPath = "c:\Users\ELCOT\Desktop\kathiravan\src\main\webapp\css\style.css"
            $htmlPath = "c:\Users\ELCOT\Desktop\kathiravan\preview.html"

            if ($urlPath -match "style\.css") {
                $content = if (Test-Path $cssPath) { [System.IO.File]::ReadAllBytes($cssPath) } else { [byte[]]@() }
                $response.ContentType = "text/css"
            } else {
                $content = if (Test-Path $htmlPath) { [System.IO.File]::ReadAllBytes($htmlPath) } else { [byte[]]@() }
                $response.ContentType = "text/html; charset=utf-8"
            }

            $response.ContentLength64 = $content.Length

            if ($request.HttpMethod -ne "HEAD") {
                $response.OutputStream.Write($content, 0, $content.Length)
            }
            $response.Close()
        } catch {
            Write-Output "Request error: $_"
        }
    }
} catch {
    Write-Output "Fatal server error: $_"
} finally {
    if ($listener.IsListening) { $listener.Stop() }
}
