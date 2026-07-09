param(
    [switch]$Silent
)

$ErrorActionPreference = "Stop"
$TempDir = "$env:TEMP\comparti-install"
$InstallerPath = "$TempDir\comparti-setup.exe"
$ReleaseUrl = "https://github.com/SJohanValancia/comparti-releases/releases/download/v1.0.0/comparti.Setup.1.0.0.exe"

Write-Host "Comparti - Instalador automatico" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

try {
    Write-Host "`nDescargando Comparti..." -ForegroundColor Yellow
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $ReleaseUrl -OutFile $InstallerPath
    Write-Host "Descarga completada." -ForegroundColor Green

    Write-Host "`nInstalando..." -ForegroundColor Yellow
    $process = Start-Process -FilePath $InstallerPath -ArgumentList "/S" -Wait -PassThru

    if ($process.ExitCode -eq 0) {
        Write-Host "`nComparti instalado exitosamente!" -ForegroundColor Green
        Write-Host "Ejecuta 'comparti' para iniciar." -ForegroundColor Cyan
    } else {
        Write-Host "`nError en la instalacion (codigo: $($process.ExitCode))" -ForegroundColor Red
        exit $process.ExitCode
    }
}
catch {
    Write-Host "`nError: $_" -ForegroundColor Red
    exit 1
}
finally {
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
