---
layout: page
title: Aorangi, Aorangi, Rarotonga, Cook Islands
country: Cook Islands
region: Rarotonga
suburb: Aorangi
city: Aorangi
permalink: /country/cook-islands/rarotonga/aorangi/aorangi/
---
[↑ Go to Aorangi](/country/cook-islands/rarotonga/aorangi/)

{% assign posts = site.posts | where: "country", "Cook Islands" | where: "region", "Rarotonga" | where: "suburb", "Aorangi" | where: "city", "Aorangi" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
