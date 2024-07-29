@echo off
echo Navegando al directorio del proyecto...
cd C:\xampp\htdocs\laravel\inventarioISTL

echo Iniciando el servidor de desarrollo de Laravel en segundo plano...
start "" /B php artisan serve

echo Esperando a que el servidor esté disponible...

:: Configura la URL del servidor
set "url=http://localhost:8000/admin"

:: Verificación usando PowerShell
powershell -Command "& {
    function Test-HttpStatus {
        param([string]$url)
        try {
            $response = Invoke-WebRequest -Uri $url -UseBasicP -Method Head -TimeoutSec 5 -ErrorAction Stop
            return $response.StatusCode -eq 200
        } catch {
            return $false
        }
    }

    while (-not (Test-HttpStatus -url '%url%')) {
        Start-Sleep -Seconds 1
    }

    Write-Output 'El servidor está funcionando.'
}"

echo Abriendo el navegador web en %url%...
start %url%

echo Proceso completado.
pause
