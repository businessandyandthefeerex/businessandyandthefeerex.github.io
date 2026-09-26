---
layout: page
title: Whanganui, New Zealand
country: New Zealand
region: Whanganui
permalink: /country/new-zealand/whanganui/
---
[↑ Go to New Zealand regions](/country/new-zealand/)

{% assign posts = site.posts | where: "region", "Whanganui" | where: "country", "New Zealand" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/new-zealand/whanganui/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
