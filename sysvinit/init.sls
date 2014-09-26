#!jinja|yaml

{% from "sysvinit/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('sysvinit:lookup')) %}

{% if 'inittab' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.inittab|default({}) %}
inittab:
  file:
    - managed
    - name: /etc/inittab
    - source: salt://sysvinit/files/inittab.{{ salt['grains.get']('os_family') }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
{% endif %}

{% if 'rclocal' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.rclocal|default({}) %}
default_config:
  file:
    - managed
    - name: {{ f.path }}
    - mode: {{ f.mode|default('755') }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - contents_pillar: sysvinit:lookup:config:rclocal:content
{% endif %}
