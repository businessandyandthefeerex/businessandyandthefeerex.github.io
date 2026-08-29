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
### [{{ city_group.name }}](/country/australia/western-australia/{{ city_slug }}/){: style="color: var(--heading-color);"}
{% else %}
### Unspecified city
{% endif %}

{% assign suburb_groups = city_group.items | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
{% assign suburb_slug = group.name | downcase | slugify %}
{% if group.name != "" %}
#### [{{ group.name }}](/country/australia/western-australia/{{ suburb_slug }}/){: style="color: var(--heading-color);"}
{% else %}
#### Unspecified suburb
{% endif %}

{% assign rating_groups = group.items | group_by: "rating" %}
{% assign sorted_rating_groups = rating_groups | sort: "name" %}

{% for rating_group in sorted_rating_groups reversed %}
##### Rating: {{ rating_group.name }}

{% for post in rating_group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
{% endfor %}
{% endfor %}
