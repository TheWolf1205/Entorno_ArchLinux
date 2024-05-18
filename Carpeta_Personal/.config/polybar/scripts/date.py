#!/usr/bin/env python3

import datetime
import locale

# Configura el idioma local a español
locale.setlocale(locale.LC_ALL, 'es_CO.utf8')

# Obtiene la fecha y hora actual en formato local
now = datetime.datetime.now()

# Imprime la fecha y hora formateadas en español
print(now.strftime('%B %e | %I:%M %p').capitalize())
