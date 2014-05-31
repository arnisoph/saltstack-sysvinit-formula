#!jinja|yaml

{% from "sysvinit/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('sysvinit:lookup')) %}

/etc/inittab:
  file:
    - managed
    - source: salt://sysvinit/files/inittab
    - mode: 644
    - user: root
    - group: root
    - template: jinja
