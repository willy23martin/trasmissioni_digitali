"""
Santiago de Cali, 10 di Novembre, 2020

Lezione: Parametri di misura della qualità de un canale di trasmissione digitale:

- Parametro di misura: Tasso di Errore di Bit (BER):
    -> rapprasenta il rapporto tra i bit con gli errori ricevuti sul destinatario (Rx)
       ed i bit che sono stati trasmessi sul canale per il sorgente (Tx).
    -> BER = # bits che si sono ricevuti.
"""

#==============================================================================

"""
Spunti di approfondimento #1:
- Canale: Senza fili (Wireless).
    ** Capacità: 1.4 volte di più alla Velocità di trasmissione (Rb).
- Servizio: 2 ore di conferenza.
    ** Sopporta 90 frames con gli errori.
    ** 1 frame è equivalente a 512 bits.
- Velocità di trasmissione / Frequenza di cifra / bit-rate (Rb): 5 Mb/s.
- Larghezza di banda (BW): 8 MHz.
- Calcolare:
    ** BER.
    ** Rapporto Segnale-Rumore (SNR).
    ** Potenza media ricevuta (Px).
- Simulazione.
"""