---
layout: page
title: Auckland, New Zealand
country: New Zealand
region: Auckland
permalink: /country/new-zealand/auckland/
---
[↑ Go to New Zealand regions](/country/new-zealand/)

{% assign posts = site.posts | where: "region", "Auckland" | where: "country", "New Zealand" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/new-zealand/auckland/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
