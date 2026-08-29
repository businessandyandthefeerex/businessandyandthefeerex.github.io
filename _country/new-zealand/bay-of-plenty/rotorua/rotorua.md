---
layout: page
title: Rotorua, Rotorua, Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
suburb: Rotorua
city: Rotorua
permalink: /country/new-zealand/bay-of-plenty/rotorua/rotorua/
---
[↑ Go to Rotorua](/country/new-zealand/bay-of-plenty/rotorua/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Bay of Plenty" | where: "suburb", "Rotorua" | where: "city", "Rotorua" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
