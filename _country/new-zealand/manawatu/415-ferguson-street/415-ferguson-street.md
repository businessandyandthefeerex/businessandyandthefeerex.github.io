---
layout: page
title: 415 Ferguson Street, 415 Ferguson Street, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 415 Ferguson Street
city: 415 Ferguson Street
permalink: /country/new-zealand/manawatu/415-ferguson-street/415-ferguson-street/
---
[↑ Go to 415 Ferguson Street](/country/new-zealand/manawatu/415-ferguson-street/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "415 Ferguson Street" | where: "city", "415 Ferguson Street" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
  <h4>Rating: {{ group.name }}</h4>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
