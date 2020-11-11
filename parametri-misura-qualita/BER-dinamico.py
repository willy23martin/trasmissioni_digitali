
"""
Santiago de Cali, 10 di Novembre, 2020

Lezione: Parametri di misura della qualità di un canale di trasmissione digitale:

- Parametro di misura: Tasso di Errore di Bit (BER):
    -> rappresenta il rapporto tra i bit con gli errori ricevuti sul destinatario (Rx)
       ed i bit che sono stati trasmessi sul canale per il sorgente (Tx).
    -> BER = # bits con errori che sono stati ricevuti / # bits che sono stati trasmessi.

I libreri Python-MATLAB:
- https://matplotlib.org/users/installing.html
- https://matplotlib.org/tutorials/introductory/pyplot.html
"""

#==============================================================================

"""
Spunti di approfondimento #1:
- Canale: Senza fili (Wireless).
    ** Capacità: 1.4 volte più della Velocità di trasmissione (Rb).
- Servizio: 2 ore di conferenza.
    ** Supporta 90 frames con i bits con errori.
    ** 1 frame è equivalente a 512 bits.
- Velocità di trasmissione / Frequenza di cifra / bit-rate (Rb): 5 Mbps.
- Larghezza di Banda (BW): 8 MHz.
- Calcolare:
    ** BER.
    ** Rapporto Segnale-Rumore (SNR).
    ** Potenza media ricevuta (Pr).
- Simulazione dinamica: BER-dinamico.py.
"""
import matplotlib.pyplot as plotter
import numpy as numpy
import math
"""
Variabili:
"""

frequenza_di_cifra_Rb = 5000000
print("La frequenza di cifra (Rb) è: ", frequenza_di_cifra_Rb, " bits per secondo.")
capacita_di_canale_C = 1.4 * frequenza_di_cifra_Rb
print("La Capacità Shannon del Canale (C) è: ", capacita_di_canale_C, " bits per secondo.")
larghezza_di_banda_BW = 8000000
print("La Larghezza di Banda del segnale (BW) è: ", larghezza_di_banda_BW, " Hz.")
rumore_No = 4.21E-18
print("Il rumore è: ", rumore_No, " mW/Hz.")

frames_con_gli_errori = 90
bits_per_frame = 512
bits_con_errori = frames_con_gli_errori * bits_per_frame
print("Gli errori supportati per il servizio sono: ", bits_con_errori, " bits.")

tempo_servizio_ore = 2
tempo_servizio_secondi = tempo_servizio_ore * 3600
bits_totali_trasmessi_per_servizio = frequenza_di_cifra_Rb * tempo_servizio_secondi
print("I bits totali trasmessi per servizio sono: ", bits_totali_trasmessi_per_servizio, " bits.")
""""""

"""
Metodi:
"""
def calcolo_BER (bits_con_errori, bits_totali_trasmessi_per_servizio):
    if bits_totali_trasmessi_per_servizio != 0:
        tasso_di_errore_di_bit = bits_con_errori / bits_totali_trasmessi_per_servizio
        return tasso_di_errore_di_bit
    else:
        return "Gli errori supportati sono nulli. Deve indicarli."

def calcolo_SNR_dB_con_C_BW (capacita_di_canale_C, larghezza_di_banda_BW):
    if larghezza_di_banda_BW != 0:
        rapporto_segnale_rumore_SNR = (2 ** (capacita_di_canale_C/larghezza_di_banda_BW)) - 1
        print("Il Rapporto Segnale Rumore lineare è: ", rapporto_segnale_rumore_SNR)
        rapporto_segnale_rumore_SNR_dB = 10 * math.log(rapporto_segnale_rumore_SNR, 10)
        return rapporto_segnale_rumore_SNR_dB
    else:
        return "La Larghezza di Banda (BW) è nulla. Deve indicarla (Hz)."

def calcolo_SNR_lineare_con_C_BW (capacita_di_canale_C, larghezza_di_banda_BW):
    if larghezza_di_banda_BW != 0:
        rapporto_segnale_rumore_SNR = (2 ** (capacita_di_canale_C/larghezza_di_banda_BW)) - 1
        return rapporto_segnale_rumore_SNR
    else:
        return "La Larghezza di Banda (BW) è nulla. Deve indicarla (Hz)."

def calcolo_lineare_potenza_media_ricevuta_Pr(capacita_di_canale_C, larghezza_di_banda_BW):
    SNR = calcolo_SNR_lineare_con_C_BW(capacita_di_canale_C, larghezza_di_banda_BW)
    return SNR * rumore_No * larghezza_di_banda_BW

def calcolo_dB_potenza_media_ricevuta_Pr(capacita_di_canale_C, larghezza_di_banda_BW):
    SNR_dB = calcolo_SNR_dB_con_C_BW(capacita_di_canale_C, larghezza_di_banda_BW)
    potenza_media_ricevuta_temp = math.pow(10, (SNR_dB/10)) * rumore_No * larghezza_di_banda_BW
    return potenza_media_ricevuta_temp

""""""

tasso_di_errore_di_bit_BER = calcolo_BER(bits_con_errori, bits_totali_trasmessi_per_servizio)
rapporto_segnale_rumore_SNR_dB = calcolo_SNR_dB_con_C_BW(capacita_di_canale_C, larghezza_di_banda_BW)
potenza_media_ricevuta_Pr = calcolo_dB_potenza_media_ricevuta_Pr(capacita_di_canale_C, larghezza_di_banda_BW)

print("Il Tasso di errore di bit (BER) è: \n", tasso_di_errore_di_bit_BER)
print("Il Rapporto Segnale Rumore è: ", rapporto_segnale_rumore_SNR_dB, "dB")
print("La Potenza media ricevuta è: ",  potenza_media_ricevuta_Pr, "mW")

"""
Simulazione: con plotter matplotlib.pyplot
"""
rapporto_segnale_rumore_SNR_dB_x = 0.1 * numpy.arange(-9, 0, 0.01, dtype=float)
print("SNR (dB) \n", rapporto_segnale_rumore_SNR_dB_x)
rapporto_segnale_rumore_SNR_lineare_x = numpy.power(10, numpy.divide(rapporto_segnale_rumore_SNR_dB_x, 10))
print("SNR lineare \n", rapporto_segnale_rumore_SNR_lineare_x)
capacita_di_canale_C_y = numpy.multiply(numpy.log2(1 + rapporto_segnale_rumore_SNR_lineare_x), larghezza_di_banda_BW)
print("Capacità di canale \n", capacita_di_canale_C_y)
potenza_media_ricevuta_Pr_y = numpy.multiply(rapporto_segnale_rumore_SNR_lineare_x, (larghezza_di_banda_BW * rumore_No))
print("Potenza ricevuta \n", potenza_media_ricevuta_Pr_y)
plotter.plot(rapporto_segnale_rumore_SNR_dB_x, capacita_di_canale_C_y)
plotter.xlabel('Rapporto Segnale-Rumore - SNR (dB)')
plotter.ylabel('Capacità di Canale (bps)')
plotter.show()

plotter.plot(rapporto_segnale_rumore_SNR_dB_x, potenza_media_ricevuta_Pr_y)
plotter.xlabel('Rapporto Segnale-Rumore - SNR (dB)')
plotter.ylabel('Potenza media ricevuta - Pr (mW)')
plotter.show()

plotter.plot(potenza_media_ricevuta_Pr_y, capacita_di_canale_C_y)
plotter.xlabel('Potenza media ricevuta - Pr (mW)')
plotter.ylabel('Capacità di Canale (bps)')
plotter.show()

""""""

#==============================================================================

