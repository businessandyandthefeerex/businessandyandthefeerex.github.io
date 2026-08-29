---
layout: page
title: Hahei, Hahei, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Hahei
city: Hahei
permalink: /country/new-zealand/coromandel/hahei/hahei/
---
[↑ Go to Hahei](/country/new-zealand/coromandel/hahei/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Hahei" | where: "city", "Hahei" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
