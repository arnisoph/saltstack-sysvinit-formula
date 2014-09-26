sysvinit:
  lookup:
    config:
      manage:
{% if grains['os_family'] == 'Debian' %}
        - inittab
{% endif %}
{% if grains['os_family'] == 'RedHat' %}
        - rclocal
      rclocal:
        content: |
          #!/bin/sh
          #
          # This script will be executed *after* all the other init scripts.
          # You can put your own initialization stuff in here if you don't
          # want to do the full Sys V style init stuff.

          touch /var/lock/subsys/local
          ferm /etc/ferm/ferm.conf
{% endif %}
