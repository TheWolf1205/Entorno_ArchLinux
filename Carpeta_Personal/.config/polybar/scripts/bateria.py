import psutil
import notify2
import time
import math
import os

notify2.init("Notificación: ¡BATERIA BAJA!")

# Define el nivel mínimo de batería antes de enviar la notificación (en porcentaje)
MIN_BATTERY_LEVEL = 25

# Verifica periódicamente el nivel de batería y envía una notificación si el nivel es bajo
while True:
    battery = psutil.sensors_battery()
    percent = round(battery.percent)
    if percent <= MIN_BATTERY_LEVEL:
        os.system('paplay /home/TheWolf/Audio/Efectos/audioEfecto de Sonido de alerta.mp3')
        message = f"Bateria Baja: {percent}% restante"
        n = notify2.Notification("¡BATERIA BAJA!", message)
        os.system('paplay /home/TheWolf/Audio/Efectos/audioEfecto_de_Sonido_de_alerta.mp3')
        n.show()
    # espera 2 minutos antes de verificar el nivel de batería nuevamente
    time.sleep(120)

