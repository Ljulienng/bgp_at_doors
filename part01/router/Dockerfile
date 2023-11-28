FROM alpine:latest

# Installation des dépendances nécessaires
RUN apk --no-cache add quagga busybox

# Configuration de Quagga (Zebra, BGPD, OSPFD, IS-IS)
COPY zebra.conf /etc/quagga/zebra.conf
COPY bgpd.conf /etc/quagga/bgpd.conf
COPY ospfd.conf /etc/quagga/ospfd.conf
COPY isisd.conf /etc/quagga/isisd.conf

# Attribuer les bons droits aux fichiers de configuration
RUN chown quagga.quaggavty /etc/quagga/*.conf && \
	chmod 640 /etc/quagga/*.conf

# Exposer les ports nécessaires
EXPOSE 179 2601 2604 2605

# Commande pour lancer Zebra et les autres daemons de Quagga
CMD ["sh", "-c", "zebra -d && bgpd -d && ospfd -d && isisd -d && tail -f /dev/null"]
