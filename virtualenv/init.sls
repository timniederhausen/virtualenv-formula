{% from 'virtualenv/map.jinja' import virtualenv with context %}

virtualenv_pkg:
  pkg.installed:
    - name: {{ virtualenv.package }}
{% for name, value in virtualenv.pkg_options %}
    - {{ name }}: {{ value | yaml }}
{% endfor %}
