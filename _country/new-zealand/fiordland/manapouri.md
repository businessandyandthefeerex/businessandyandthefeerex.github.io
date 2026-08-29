---
layout: page
title: Manapouri, Fiordland, New Zealand
country: New Zealand
region: Fiordland
city: Manapouri
permalink: /country/new-zealand/fiordland/manapouri/
---
[↑ Go to Fiordland](/country/new-zealand/fiordland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Fiordland" | where: "city", "Manapouri" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
{% if group.name != "" %}
#### [{{ group.name }}](/country/new-zealand/fiordland/{{ group.name | downcase | slugify }}/){: style="color: var(--heading-color);"}
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
