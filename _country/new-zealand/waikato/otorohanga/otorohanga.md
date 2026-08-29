---
layout: page
title: Otorohanga, Otorohanga, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Otorohanga
city: Otorohanga
permalink: /country/new-zealand/waikato/otorohanga/otorohanga/
---
[↑ Go to Otorohanga](/country/new-zealand/waikato/otorohanga/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Otorohanga" | where: "city", "Otorohanga" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
