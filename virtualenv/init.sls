{% from 'virtualenv/map.jinja' import virtualenv with context %}

virtualenv_pkg:
  pkg.installed:
    - name: {{ virtualenv.package }}
{% for name, value in virtualenv.pkg_options %}
    - {{ name }}: {{ value | yaml }}
{% endfor %}

{% if grains.os_family == 'FreeBSD' %}
# https://docs.python.org/2.7/install/index.html#location-and-names-of-config-files
# This is mostly for pysqlite that needs to find locally installed sqlite3
# headers and libraries.  But it might be needed for other modules as well.
prepare_distutils.cfg:
  file.managed:
    - name: /usr/local/lib/python2.7/distutils/distutils.cfg
  ini.options_present:
    - name: /usr/local/lib/python2.7/distutils/distutils.cfg
    - sections:
        build_ext:
          include_dirs: /usr/local/include
          library_dirs: /usr/local/lib
    - require:
      - file: prepare_distutils.cfg
{% endif %}
