---
layout: page
title: Waiheke Island, New Zealand
country: New Zealand
region: Waiheke Island
permalink: /country/new-zealand/waiheke-island/
---
[↑ Go to New Zealand regions](/country/new-zealand/)

{% assign posts = site.posts | where: "region", "Waiheke Island" | where: "country", "New Zealand" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
{% assign city_slug = city_group.name | downcase | slugify %}
{% if city_group.name != "" %}
- [{{ city_group.name }}](/country/new-zealand/waiheke-island/{{ city_slug }}/)
{% else %}
- Unspecified city
{% endif %}
{% endfor %}
