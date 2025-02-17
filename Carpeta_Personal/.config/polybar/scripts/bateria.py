import psutil
import notify2
import time
import os

notify2.init("Notificación de batería")

# Define niveles de batería para notificaciones
MIN_BATTERY_LEVEL = 25
MAX_BATTERY_LEVEL = 80

# Función para enviar notificación
def send_notification(title, message, sound_path):
    os.system(f'paplay {sound_path}')
    n = notify2.Notification(title, message)
    n.show()

# Verifica periódicamente el nivel de batería
while True:
    battery = psutil.sensors_battery()
    percent = round(battery.percent)
    plugged = battery.power_plugged

    # Alerta de batería baja
    if percent <= MIN_BATTERY_LEVEL:
        send_notification("¡BATERÍA BAJA!", f"Batería baja: {percent}% restante", "~/.config/polybar/scripts/sonido/audioEfecto_de_Sonido_de_alerta.mp3")
    
    # Alerta de batería al 80%
    elif percent >= MAX_BATTERY_LEVEL and plugged:
        send_notification("Nivel de carga óptimo alcanzado", f"Batería cargada al {percent}%", "~/.config/polybar/scripts/sonido/audioEfecto_de_Sonido_de_alerta.mp3")
    
    # Espera 2 minutos antes de verificar nuevamente
    time.sleep(120)

