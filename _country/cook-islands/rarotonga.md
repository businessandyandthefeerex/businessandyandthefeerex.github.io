---
layout: page
title: Rarotonga, Cook Islands
country: Cook Islands
region: Rarotonga
permalink: /country/cook-islands/rarotonga/
---
[↑ Go to Cook Islands regions](/country/cook-islands/)

{% assign posts = site.posts | where: "region", "Rarotonga" | where: "country", "Cook Islands" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/cook-islands/rarotonga/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
