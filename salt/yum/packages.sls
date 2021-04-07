install_yum_utils:
  pkg.installed:
    - name: yum-utils

{% if grains.os == 'CentOS' %}
install_yum_versionlock:
  pkg.installed:
    - name: yum-plugin-versionlock
{% elif grains.os == 'OEL' %}
install_yum_versionlock:
  pkg.installed:
    - name: python3-dnf-plugin-versionlock
{% endif %}
