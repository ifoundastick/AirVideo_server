{% set user = 'frank' %}
Extract_AirVideo:
  archive.extracted:
    - name: /opt/AirVideo
#    - source: salt://AirVideo_Server/AirVideoServerHD-2.2.3.tar.bz2
    - source: https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-2.2.3.tar.bz2
    - source_hash: md5=45761149c9444a4f4dfc771b5b12aa20
    - user: {{ user }}
    - group: {{ user }}
    - if_missing: /opt/AirVideo/start.sh
    - archive_format: tar
Server_properties:
  file.managed:
    - name: /opt/AirVideo/Server.properties
    - source: salt://AirVideo_Server/Server.properties
    - user: root
    - group: root
    - mode: 644
Airvideo_dbus:
  file.managed:
    - name: /etc/default/AirVideo
    - source: salt://AirVideo_Server/AirVideo
    - user: root
    - group: root
    - mode: 644
AirVideo.Service:
   file.managed:
    - name: /etc/systemd/system/AirVideo.service
    - source: salt://AirVideo_Server/AirVideo.service
    - user: root
    - group: root
    - mode: 644
   module.run:
     - name: service.systemctl_reload
     - onchanges:
       - file: /etc/systemd/system/AirVideo.service
AirVideo:
  service.running:
    #    - name: AirVideo.service
    - watch:
      - file: /opt/AirVideo/Server.properties 
