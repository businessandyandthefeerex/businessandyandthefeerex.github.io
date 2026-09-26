---
layout: page
title: Western Australia, Australia
country: Australia
region: Western Australia
permalink: /country/australia/western-australia/
---
[↑ Go to Australia regions](/country/australia/)

{% assign posts = site.posts | where: "region", "Western Australia" | where: "country", "Australia" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/australia/western-australia/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
