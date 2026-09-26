---
layout: page
title: Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
permalink: /country/new-zealand/bay-of-plenty/
---
[↑ Go to New Zealand regions](/country/new-zealand/)

{% assign posts = site.posts | where: "region", "Bay of Plenty" | where: "country", "New Zealand" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/new-zealand/bay-of-plenty/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
