$router="192.168.1.254"
$internet="1.1.1.1"
$results=@()

Write-Host "Test kører. Tryk Ctrl+C når du oplever problemet." -ForegroundColor Green

for($n=0; $n -lt 1800; $n++) {
    $time=Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $routerResult=Test-Connection $router -Count 1 -ErrorAction SilentlyContinue
    $internetResult=Test-Connection $internet -Count 1 -ErrorAction SilentlyContinue

    if($routerResult) {
        $routerPing=$routerResult.ResponseTime
    } else {
        $routerPing="TIMEOUT"
    }

    if($internetResult) {
        $internetPing=$internetResult.ResponseTime
    } else {
        $internetPing="TIMEOUT"
    }

    $row=[PSCustomObject]@{
        Time=$time
        Router=$routerPing
        Internet=$internetPing
    }

    $results += $row

    Write-Host "$time | Router: $routerPing ms | Internet: $internetPing ms"

    $results | Export-Csv "D:\internet-test.csv" -NoTypeInformation

    Start-Sleep -Seconds 1
}