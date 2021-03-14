{% from 'allowed_states.map.jinja' import allowed_states %}
{% if sls in allowed_states %}

# This state is for checking things
{% if grains['role'] in ['so-manager', 'so-managersearch', 'so-standalone'] %}
# Make sure Cross Cluster is good. Will need some logic once we have hot/warm
crossclusterson:
  cmd.script:
    - shell: /bin/bash
    - cwd: /opt/so
    - runas: socore
    - source: salt://utility/bin/crossthestreams
    - template: jinja

{% endif %}
{% if grains['role'] in ['so-eval', 'so-import'] %}
fixsearch:
  cmd.script:
    - shell: /bin/bash
    - cwd: /opt/so
    - runas: socore
    - source: salt://utility/bin/eval
    - template: jinja
{% endif %}

{% else %}

{{sls}}_state_not_allowed:
  test.fail_without_changes:
    - name: {{sls}}_state_not_allowed

{% endif %}
